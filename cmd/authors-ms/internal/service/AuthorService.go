package service

import (
    "fmt"
    "github.com/BekirAktas/go-aws-terra/cmd/authors-ms/internal/common/models"
)

type AuthorService struct{}

func (as *AuthorService) SendAuthors(authors []models.Author) error {
    fmt.Println("Sending authors:", authors)
    return nil
}

