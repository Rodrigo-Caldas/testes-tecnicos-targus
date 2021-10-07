FROM golang:1.14.0

WORKDIR /go/src/app
VOLUME /go/src/app/volume_exec
COPY . .

RUN go build -v ./...

#RUN mv app volume_exec/

CMD ["/go/src/app"] 

