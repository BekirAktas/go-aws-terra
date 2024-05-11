package models

import (
    "fmt"
    "net/http"
    "bytes"
    "io"
)

func MakeRequest(url string, payload *[]byte, method string) (*http.Response, error) {
    var body io.Reader
    if payload != nil {
        body = bytes.NewBuffer(*payload)
    }

    req, err := http.NewRequest(method, url, body)
    if err != nil {
        return nil, err
    }

    req.Header.Set("Content-Type", "application/json")

    client := http.Client{}
    resp, err := client.Do(req)
    if err != nil {
        return nil, err
    }

    defer resp.Body.Close()

    if resp.StatusCode == http.StatusOK {
        fmt.Println("Fine")
    } else {
        fmt.Println("Not fine")
    }
    return resp, nil
}
