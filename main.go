package main

import (
	"bufio"
	"io"
	"log"
	"net"
	"net/http"
	"os"
	"regexp"
)

var ips *map[string]bool

func parseConsensus(input string) (*map[string]bool, error) {
	ips := make(map[string]bool)

	re := regexp.MustCompile("\nr ([A-Za-z0-9]+) ([A-Za-z0-9/+]+) ([A-Za-z0-9/+]+) ([\\d-]+) ([\\d:]+) ([\\d.]+) (\\d+) 0\n")
	matches := re.FindAllStringSubmatch(input, -1)
	for _, match := range matches {
		ip4 := match[6]
		ips[ip4] = true
	}

	re = regexp.MustCompile("\na \\[([0-9A-Za-z:]+)\\]:\\d+\n")
	matches = re.FindAllStringSubmatch(input, -1)
	for _, match := range matches {
		ip6 := match[1]
		ips[ip6] = true
	}

	return &ips, nil
}

func root(w http.ResponseWriter, req *http.Request) {
	host, _, err := net.SplitHostPort(req.RemoteAddr)
	if err != nil {
		log.Fatal(err)
	}

	_, is_tor := (*ips)[host]
	if is_tor {
		io.WriteString(w, "yes "+host+"\n")
	} else {
		io.WriteString(w, "no "+host+"\n")
	}
}

func main() {
	addr := os.Args[1]

	// Read the consensus from stdin
	reader := bufio.NewReader(os.Stdin)
	consensus, err := io.ReadAll(reader)
	if err != nil {
		log.Panic(err)
	}
	ips, err = parseConsensus(string(consensus))
	if err != nil {
		log.Panic(err)
	}
	log.Printf("Indexed %d unique IP addresses\n", len(*ips))

	log.Println("Listening on " + addr)
	http.HandleFunc("/", root)
	err = http.ListenAndServe(addr, nil)
	if err != nil {
		log.Panic(err)
	}
}
