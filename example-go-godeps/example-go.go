package main

import (
	"io"
	"log"
	"net/http"
	"os"

	"github.com/apcera/nats"
)

// hello world, the web server
func HelloServer(w http.ResponseWriter, req *http.Request) {
	io.WriteString(w, nats.Version+"\n")
}

func main() {
	http.HandleFunc("/", HelloServer)
	err := http.ListenAndServe(":"+os.Getenv("PORT"), nil)
	if err != nil {
		log.Fatal("ListenAndServe: ", err)
	}
}
