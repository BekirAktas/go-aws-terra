package server

import (
  "net/http" 
  "github.com/gorilla/mux"
  "encoding/json"
  "fmt"
  "github.com/BekirAktas/go-aws-terra/cmd/authors-ms/internal/common/models"
  "strconv"
  "bytes"
)

func WriteJSON(w http.ResponseWriter, status int, data interface{}) error {
  response := map[string]any{"message": data}
    w.Header().Set("Content-Type", "application/json; charset=utf-8")
    w.WriteHeader(status)
    return json.NewEncoder(w).Encode(response)
}


type apiFunc func (http.ResponseWriter, *http.Request) error

type ApiError struct {
  Error string
}

func makeHTTPHandleFunc(f apiFunc) http.HandlerFunc {
  return func (w http.ResponseWriter, r *http.Request) {
    if err := f(w, r); err != nil {
      WriteJSON(w, http.StatusBadRequest, ApiError{ Error: err.Error() })
    }
  }
}

type APIServer struct {
  listenAddr string
  authorRepository models.AuthorRepository
}

func NewApiServer(listenAddr string, authorRepository models.AuthorRepository) *APIServer {
  return &APIServer {
    listenAddr: listenAddr,
    authorRepository: authorRepository,
  }
}

func (s *APIServer) Run() {
  router := mux.NewRouter()

  router.HandleFunc("/create-author", makeHTTPHandleFunc(s.handleCreateAuthor))
  router.HandleFunc("/get-author/{id}", makeHTTPHandleFunc(s.handleGetAuthor))
  router.HandleFunc("/get-authors", makeHTTPHandleFunc(s.handleGetAuthors))
  router.HandleFunc("/authors/send-to/{id}", makeHTTPHandleFunc(s.handleSendAuthors))

  fmt.Println(http.ListenAndServe(s.listenAddr, router))
}

func (s *APIServer) handleSendAuthors (w http.ResponseWriter, r *http.Request) error {
  authorIDStr := mux.Vars(r)["id"]
  authors, err := s.authorRepository.GetAllAuthors()
  if err != nil {
    return fmt.Errorf("failed to send authors: %v", err)
  }

  payload, err := json.Marshal(authors)
  if (err != nil) {
    return fmt.Errorf("json marshal error %v", err)
  }

  reqBody := struct {
    Message string `json:"message"`
    ChatID  string `json:"chat_id"`
  }{
    Message: string(payload),
    ChatID:  authorIDStr,
  }

  reqBodyBytes, err := json.Marshal(reqBody)

  if err != nil {
    return fmt.Errorf("failed to marshal request body: %v", err)
  }

  req, err := http.NewRequest("POST", "http://send-telegram-message:80/send-message", bytes.NewBuffer(reqBodyBytes))

  if err != nil {
    return fmt.Errorf("failed to create request: %v", err)
  }

  client := &http.Client{}
  resp, err := client.Do(req)
  if err != nil {
    return fmt.Errorf("failed to send request: %v", err)
  }
  defer resp.Body.Close()

  if resp.StatusCode != http.StatusOK {
    return fmt.Errorf("unexpected status code: %v", resp.StatusCode)
  }

  return WriteJSON(w, http.StatusOK, "Authors sent successfully")
}

func (s *APIServer) handleGetAuthor(w http.ResponseWriter, r *http.Request) error {
    authorIDStr := mux.Vars(r)["id"]
    
    authorID, err := strconv.ParseUint(authorIDStr, 10, 64)
    if err != nil {
        return fmt.Errorf("invalid author ID: %v", err)
    }
    
    author, err := s.authorRepository.GetAuthorByID(uint(authorID))
    if err != nil {
        return fmt.Errorf("failed to get author: %v", err)
    }
    
    if author == nil {
        return fmt.Errorf("author not found")
    }

    return WriteJSON(w, http.StatusOK, author)
}


func (s *APIServer) handleCreateAuthor(w http.ResponseWriter, r *http.Request) error {
    var author models.Author
    if err := json.NewDecoder(r.Body).Decode(&author); err != nil {
        return err
    }
    if err := s.authorRepository.CreateAuthor(&author); err != nil {
        return err
    }
    return WriteJSON(w, http.StatusCreated, "Author created successfully")
  }


func (s *APIServer) handleGetAuthors(w http.ResponseWriter, r *http.Request) error {
  authors, err := s.authorRepository.GetAllAuthors()
  if err != nil {
    return err
  }
  return WriteJSON(w, http.StatusOK, authors)
}
