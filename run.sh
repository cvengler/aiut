#!/usr/bin/env bash

AUTHORITY="193.23.244.244"
LISTEN=$1

curl --silent --compressed http://$AUTHORITY/tor/status-vote/current/consensus.z | ./aiut $LISTEN
