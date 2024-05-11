FROM golang:latest

WORKDIR /github.com/BekirAktas/go-aws-terra/cmd/send-telegram-message

COPY cmd/send-telegram-message/go.mod .
COPY cmd/send-telegram-message/go.sum .

RUN go mod download

COPY cmd/send-telegram-message .

RUN go build -o main .

CMD ["./main"]
