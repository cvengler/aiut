# Am I using Tor?

A web application to quickly check whether a connection is using Tor or
not.

You can find an online version of this at [amiusingtor.net](https://amiusingtor.net).

## Usage

```sh
./run.sh 127.0.0.1:8080
```

## Known Issues

This program is stupidly simple, meaning it is too stupid to distinguish exit relays from middle relays.
Therefore, if you access this side from an IP that runs a middle relay, you will get a false-positive.

## TODO

* Write a tool to download the consensus from an authority, validate it and write it to a text file
