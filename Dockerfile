FROM golang:1.14 as builder
ENV GOOS=linux GOARCH=amd64 CGO_ENABLED=0
RUN useradd -u 10001 canary
WORKDIR /app
COPY . .

RUN make build 


FROM scratch 

WORKDIR /
COPY --from=builder /etc/passwd /etc/passwd
COPY --from=builder /app/bin/canary-demo /canary-demo
USER canary
EXPOSE 8080
ENTRYPOINT ["/canary-demo"]
