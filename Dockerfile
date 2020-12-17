# Build stage
<<<<<<< HEAD
ARG GO_VERSION=1.15
ARG PROJECT_PATH=/go/src/github.com/aattias/carbonbeat
FROM golang:${GO_VERSION}-alpine AS builder
RUN apk --no-cache add ca-certificates tini git gcc musl-dev
RUN go get -u github.com/golang/dep/cmd/dep
WORKDIR /go/src/github.com/aattias/carbonbeat
=======
FROM golang:1.15-buster as builder
WORKDIR /build
>>>>>>> 42f0668 (committing content to begin merge)
COPY ./ ${PROJECT_PATH}
RUN CGO_ENABLED=0 GOOS=`go env GOHOSTOS` GOARCH=`go env GOHOSTARCH` go build -o carbonbeat 

# Production image
<<<<<<< HEAD
FROM alpine:3.6
RUN apk --no-cache add ca-certificates tini
WORKDIR /
COPY --from=builder /go/src/github.com/aattias/carbonbeat/carbonbeat .
RUN adduser -D -u 69999 -s /usr/sbin/nologin carbonbeat
ADD carbonbeat.yml /carbonbeat.yml
ADD carbonbeat.template.json /carbonbeat.template.json
ADD carbonbeat.template.json /carbonbeat.template-es2x.json
ADD carbonbeat.template.json /carbonbeat.template-es6x.json
=======
FROM alpine:3.12
RUN apk --no-cache add ca-certificates tini
WORKDIR /
COPY --from=builder /build/carbonbeat .
RUN adduser -D -u 69999 -s /usr/sbin/nologin carbonbeat
>>>>>>> 42f0668 (committing content to begin merge)
#USER carbonbeat
ENTRYPOINT ["tini", "-g", "--"]
CMD ["/carbonbeat", "-v", "-e", "-d", "'*'"]
