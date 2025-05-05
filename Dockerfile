FROM golang:1.24 as builder
WORKDIR /app
COPY go.mod ./
COPY go.sum ./
RUN go mod download
COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -o /main .

#Final stage(smaller alpine image)
FROM alpine:latest
#install CA certificates 
RUN apk --no-cache add ca-certificates
WORKDIR /app
#copy the binary from the builder
COPY --from=builder /main /app/main
COPY --from=builder /app/static /app/static
#Ensures binary is executable
RUN chmod +x /app/main

CMD [ "./main" ]


