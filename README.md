# Am I using Tor?

A web application to quickly check whether a connection is using Tor or
not.

You can find an online version of this at [amiusingtor.net](https://amiusingtor.net).

## Usage

Grab a current consensus and pass it through stdin, providing a port for
the web server to listen on: `cat consensus.z | ./aiut :8080`

## TODO

* Make it possible to run this behind a reverse proxy (`X-Forwarded-For`)
* Write a tool to download the consensus from an authority, validate it and write it to a text file
* Write a shellscript wrapper around it
