package database

import (
    "gorm.io/driver/postgres"
    "gorm.io/gorm"
    "log"
)

func ConnectToDatabase() *gorm.DB  {
    dsn := "host=postgres user=postgres password=postgres dbname=go-aws-terra port=5432 sslmode=disable TimeZone=UTC"

    db, err := gorm.Open(postgres.Open(dsn))

    if err != nil {
        log.Fatal("Failed to connect to database:", err)
    }

    return db
}

