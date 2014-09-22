package main

import (
	"fmt"
	"io"
	"log"
	"net/http"
)

const (
	PORT_1 = "4000"
	PORT_2 = "4001"
)

func Port1(w http.ResponseWriter, req *http.Request) {
	io.WriteString(w, fmt.Sprintf("Listening on %s", PORT_1))
}

func Port2(w http.ResponseWriter, req *http.Request) {
	io.WriteString(w, fmt.Sprintf("Listening on %s", PORT_2))
}

func main() {
	http.HandleFunc("/", Port1)

	go func() {
		if err := http.ListenAndServe(":"+PORT_1, nil); err != nil {
			log.Fatal("ListenAndServe: ", err)
		}
	}()

	secondMux := http.NewServeMux()
	secondMux.HandleFunc("/", Port2)

	s := &http.Server{
		Addr:    fmt.Sprintf(":%s", PORT_2),
		Handler: secondMux,
	}
	log.Fatal(s.ListenAndServe())
}
