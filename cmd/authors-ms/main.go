package main

import (
    "github.com/BekirAktas/go-aws-terra/cmd/authors-ms/internal/common/database"
    "github.com/BekirAktas/go-aws-terra/cmd/authors-ms/internal/common/models"
    "github.com/BekirAktas/go-aws-terra/cmd/authors-ms/server"
)

func main() {
    db := database.ConnectToDatabase()

    db.AutoMigrate(&models.Author{})

    authorRepository := models.NewAuthorRepository(db)

    apiServer := server.NewApiServer(":80", *authorRepository)

    apiServer.Run()
}

