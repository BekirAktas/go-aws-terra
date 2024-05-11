package server

import (
  "net/http" 
  "github.com/gorilla/mux"
  "fmt"
  models "github.com/BekirAktas/go-aws-terra/cmd/send-telegram-message/models"
  "encoding/json"
)

type apiFunc func (http.ResponseWriter, *http.Request) error

type ApiError struct {
  Error string
}

type APIServer struct {
  listenAddr string
}

func NewApiServer(listenAddr string) *APIServer {
  return &APIServer {
    listenAddr: listenAddr,
  }
}

func (s *APIServer) Run() {
  router := mux.NewRouter()

  router.HandleFunc("/send-message", s.handleSendMessage)

  fmt.Println(http.ListenAndServe(s.listenAddr, router))
}


func (s *APIServer) handleSendMessage(w http.ResponseWriter, r *http.Request) {
  var requestBody struct {
    Message string `json:"message"`
    ChatID    string `json:"chat_id"`
  }

  fmt.Println(requestBody.ChatID, requestBody.Message)

  if err := json.NewDecoder(r.Body).Decode(&requestBody); err != nil {
    http.Error(w, "failed to parse request body", http.StatusBadRequest)
    return
  }
  defer r.Body.Close()
  fmt.Println(requestBody.ChatID, requestBody.Message)

  tlg := models.NewTelegramMessage(requestBody.Message, requestBody.ChatID)
  tlg.SendMessage()
    

    fmt.Fprintln(w, "Message sent successfully")
}
