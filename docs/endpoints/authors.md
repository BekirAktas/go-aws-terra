# Authors API Documentation

This document provides detailed documentation for the endpoints provided by the Authors API.

## Endpoints

### Get all Authors
GET /authors HTTP/1.1
Host: api.example.com

### Create a New Author
POST /authors HTTP/1.1
Host: api.example.com
Content-Type: application/json

{
  "name": "John Doe",
  "email": "john@example.com"
}

