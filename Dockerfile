FROM alpine

RUN apk add --no-cache bash curl

COPY main.sh /app/main.sh
RUN chmod +x /app/main.sh

CMD ["/app/main.sh"]
