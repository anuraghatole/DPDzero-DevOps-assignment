FROM golang:1.21-alpine

# Set GOPATH mode (turn off modules)
ENV GO111MODULE=off

# Create GOPATH-style directory
WORKDIR /go/src/app

COPY main.go .

RUN go build -o main .

EXPOSE 8001

HEALTHCHECK CMD wget --spider -q http://localhost:8001/ping || exit 1

CMD ["./main"]
