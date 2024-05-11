FROM golang:latest

WORKDIR /github.com/BekirAktas/go-aws-terra/cmd/authors-ms

COPY cmd/authors-ms/go.mod .
COPY cmd/authors-ms/go.sum .

RUN go mod download

COPY cmd/authors-ms .

RUN go build -o main .

CMD ["./main"]

