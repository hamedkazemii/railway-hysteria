FROM debian:bullseye

RUN apt-get update && apt-get install -y \
    curl openssl ca-certificates && \
    apt-get clean

COPY main.sh /app/main.sh
WORKDIR /app
RUN chmod +x main.sh

CMD ["/app/main.sh"]
