FROM golang:1.24 as builder
WORKDIR /app
COPY go.mod .
RUN go mod download
COPY . .
RUN go build -o main .

#Final stage - Distroless image
FROM gcr.io.distroless/static:nonroot
WORKDIR /app
COPY --from=builder /app/main .
COPY --from=builder /app/static ./static
EXPOSE 8080
USER nonroot
CMD [ "./main" ]


