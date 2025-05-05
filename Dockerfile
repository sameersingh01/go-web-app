FROM golang:1.24 as builder
WORKDIR /app
COPY . .
RUN go mod download
RUN go build -o main .

#Final stage(smaller alpine image)
FROM alpine:latest
WORKDIR /app
#copy the binary from the builder
COPY --from=builder /app/main .
EXPOSE 8080

CMD [ "./main" ]


