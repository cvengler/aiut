#!/usr/bin/env bash
env CC=aarch64-linux-musl-gcc GOOS=linux GOARCH=arm64 go build aiut.go
