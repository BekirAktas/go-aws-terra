package main

import (
  "github.com/BekirAktas/go-aws-terra/cmd/send-telegram-message/server"
)

func main() {
  server := server.NewApiServer(":80")
  server.Run();
}
