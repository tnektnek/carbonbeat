# Build stage
ARG GO_VERSION=1.15
ARG PROJECT_PATH=/go/src/github.com/aattias/carbonbeat
FROM golang:${GO_VERSION}-alpine AS builder
RUN apk --no-cache add ca-certificates tini git gcc musl-dev
RUN go get -u github.com/golang/dep/cmd/dep
WORKDIR /go/src/github.com/tnektnek/carbonbeat
COPY ./ ${PROJECT_PATH}
RUN CGO_ENABLED=0 GOOS=`go env GOHOSTOS` GOARCH=`go env GOHOSTARCH` go build -o carbonbeat 

# Production image
FROM alpine:3.6
RUN apk --no-cache add ca-certificates tini
WORKDIR /
COPY --from=builder /go/src/github.com/tnektnek/carbonbeat/carbonbeat .
RUN adduser -D -u 69999 -s /usr/sbin/nologin carbonbeat
ADD carbonbeat.full.yml /carbonbeat.yml
ADD carbonbeat.template.json /carbonbeat.template.json
ADD carbonbeat.template.json /carbonbeat.template-es2x.json
ADD carbonbeat.template.json /carbonbeat.template-es6x.json
#USER carbonbeat
ENTRYPOINT ["tini", "-g", "--"]
CMD ["/carbonbeat", "-v", "-e", "-d", "'*'"]
