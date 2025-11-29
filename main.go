package main

import (
    "fmt"
    "net/http"
)

func main() {
    http.HandleFunc("/", helloHandler)
    
    fmt.Println("Starting server on :8080...")
    fmt.Println("Visit: http://localhost:8080")
    
    err := http.ListenAndServe(":8080", nil)
    if err != nil {
        fmt.Printf("Error starting server: %s\n", err)
    }
}

func helloHandler(w http.ResponseWriter, r *http.Request) {
    fmt.Fprintf(w, "Hello World!")
}
