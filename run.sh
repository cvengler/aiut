#!/usr/bin/env bash

AUTHORITY="193.23.244.244"
LISTEN=$1

curl --silent --compressed http://$AUTHORITY/tor/status-vote/current/consensus.z https://collector.torproject.org/recent/exit-lists/$(date -d "-1 day" "+%Y-%m-%d-%H-02-00") | ./aiut $LISTEN