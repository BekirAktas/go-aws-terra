package models

import (
  "gorm.io/gorm"
  "fmt"
)

type Author struct {
    gorm.Model
    Name  string
    Email string
}

type AuthorRepository struct {
    db *gorm.DB
}

func NewAuthorRepository(db *gorm.DB) *AuthorRepository {
    return &AuthorRepository{db}
}

func (repo *AuthorRepository) CreateAuthor(author *Author) error {
  fmt.Println(author)
    return repo.db.Create(author).Error
}

func (repo *AuthorRepository) GetAuthorByID(id uint) (*Author, error) {
    var author Author
    if err := repo.db.First(&author, id).Error; err != nil {
        return nil, err
    }
    return &author, nil
}

func (repo *AuthorRepository) GetAllAuthors() ([]*Author, error) {
    var authors []*Author
    if err := repo.db.Find(&authors).Error; err != nil {
        return nil, err
    }
    return authors, nil
}

func (repo *AuthorRepository) DeleteAuthor(author *Author) error {
    return repo.db.Delete(author).Error
}

