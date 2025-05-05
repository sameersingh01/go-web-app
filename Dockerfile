FROM golang:1.24 as builder
WORKDIR /app
COPY go.mod .
RUN go mod download
COPY . .
RUN go build -o main .

#Final stage - Distroless image
FROM alpine:latest
WORKDIR /app
COPY --from=builder /app/main .
COPY --from=builder /app/static ./static

CMD [ "./main" ]


