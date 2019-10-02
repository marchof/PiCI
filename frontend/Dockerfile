FROM golang:1.13.1 

RUN go get github.com/gorilla/mux
RUN go get github.com/gorilla/handlers

RUN mkdir /app 
ADD . /app/ 
WORKDIR /app 

VOLUME /builds
EXPOSE 80/tcp

RUN go build -o main .

CMD ["/app/main", "/builds"]
