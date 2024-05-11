# Books API Documentation

This document provides detailed documentation for the endpoints provided by the Books API.

## Endpoints

### Get all Books

GET /books HTTP/1.1
Host: api.example.com

### Create a New Book
POST /books HTTP/1.1
Host: api.example.com
Content-Type: application/json

{
  "title": "Sample Book",
  "author_id": 1
}

