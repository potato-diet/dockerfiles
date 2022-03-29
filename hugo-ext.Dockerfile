FROM golang:alpine as builder

RUN apk add alpine-sdk unzip

WORKDIR /usr/src/app
RUN wget https://github.com/gohugoio/hugo/archive/refs/tags/v0.96.0.zip \
  && unzip v0.96.0.zip \
  && cd hugo-0.96.0 \
  && go build -ldflags "-w -s" --tags extended

FROM alpine

RUN apk add libstdc++ libgcc git

WORKDIR /src
COPY --from=builder /usr/src/app/hugo-0.96.0/hugo /usr/bin/

ENTRYPOINT ["hugo"]
