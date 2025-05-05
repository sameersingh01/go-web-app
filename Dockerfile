FROM golang:1.24 AS builder
WORKDIR /app
COPY . .
RUN go mod download
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o main .

#Final stage(smaller alpine image)
FROM alpine:latest
WORKDIR /app
#copy the binary from the builder
COPY --from=builder /app/main .
EXPOSE 8080

CMD [ "./main" ]


