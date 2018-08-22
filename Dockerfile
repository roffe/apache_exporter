FROM golang:1.10-alpine as build
RUN apk add --no-cache git \
    && go get -u -v github.com/Lusitaniae/apache_exporter

FROM alpine:3.8
RUN apk add --no-cache dumb-init
COPY --from=BUILD /go/bin/apache_exporter /usr/local/bin/apache_exporter
ENTRYPOINT ["/usr/bin/dumb-init", "--", "/usr/local/bin/apache_exporter"]

