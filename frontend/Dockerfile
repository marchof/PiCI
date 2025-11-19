FROM golang:1.25.4 

RUN mkdir /app 
ADD . /app/ 
WORKDIR /app 

VOLUME /builds
EXPOSE 80/tcp

RUN go get all
RUN go build -o main .

CMD ["/app/main", "/builds"]
