#!/usr/bin/env bash

AUTHORITY="193.23.244.244"
LISTEN="127.0.0.1:8080"

curl --silent --compressed http://$AUTHORITY/tor/status-vote/current/consensus.z | go run main.go $LISTEN
