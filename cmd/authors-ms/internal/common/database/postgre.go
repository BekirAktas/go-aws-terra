package database

import (
    "gorm.io/driver/postgres"
    "gorm.io/gorm"
    "log"
    "github.com/joho/godotenv"
    "os"
    "fmt"
)

func ConnectToDatabase() *gorm.DB  {
  godotenv.Load(".env")

  host := os.Getenv("host")
  user := os.Getenv("user")
  password := os.Getenv("password")
  db_name := os.Getenv("db_name")

  dsn := fmt.Sprintf("host=%s user=%s password=%s dbname=%s port=5432 sslmode=disable TimeZone=UTC", host, user, password, db_name)


  db, err := gorm.Open(postgres.Open(dsn))

  if err != nil {
    log.Fatal("Failed to connect to database:", err)
  }

  return db
}

