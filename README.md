# Simple HTTP Debugging Application


This repository contains **Dockerfile** for [Docker](https://www.docker.com/)'s [automated build](https://registry.hub.docker.com/u/czerasz/http-debugger/) published to the public [Docker Hub Registry](https://registry.hub.docker.com/).


## Base Docker Image

* [node:6.7.0-slim](https://registry.hub.docker.com/_/node/)

## Installation

1. Install [Docker](https://www.docker.com/)

2. Download [automated build](https://registry.hub.docker.com/u/czerasz/http-debugger/) from public [Docker Hub Registry](https://registry.hub.docker.com/):

    ```
    docker pull czerasz/http-debugger
    ```

    Alternatively, you can build an image from `Dockerfile`:

    ```
    docker build --tag czerasz/http-debugger github.com/czerasz/docker-http-debugger
    ```

## Usage

Start the container:

```
docker run -t --rm -p 3000:3000 czerasz/http-debugger
```

Test the application with `curl`:

```
$ curl -i -XPOST localhost:3000/test -d 'test=true'
HTTP/1.1 200 OK
X-Powered-By: Express
X-Debug: true
Content-Type: text/html; charset=utf-8
Content-Length: 2
ETag: W/"2-79dcdd47"
Date: Wed, 13 May 2015 16:25:37 GMT
Connection: keep-alive

ok
```

Now go back to the terminal where the container runs. You will see the request details:

```
> debugging_application@1.0.0 start /usr/local/bin/app
> node index.js

Debugging app listening at http://:::3000

--- --- --- --- --- --- --- --- --- --- --- --- ---

[2015-05-13 16:25:37] Request 1

POST/1.1 /test on :::3000

Headers:
 - user-agent: curl/7.38.0
 - host: localhost:3000
 - accept: */*
 - content-length: 9
 - content-type: application/x-www-form-urlencoded

No cookies

Body:
test=true
```

### Use with Unix Socket

Make sure the directory exists:

```
SOCKET_DIRECTORY=/var/app/app_name/shared/tmp/sockets/
mkdir -p $SOCKET_DIRECTORY
```

Run the container:

```
docker run -t --rm \
       -v $SOCKET_DIRECTORY:$SOCKET_DIRECTORY \
       -e LISTEN_SOCKET="${SOCKET_DIRECTORY}app_name.0.sock" \
       czerasz/http-debugger
```
