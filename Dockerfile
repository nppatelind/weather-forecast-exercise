FROM debian:buster-slim

RUN apt update
RUN apt install jq curl -y
RUN apt install dnsutils  -y
ADD ./ip_forecast.sh .
ENTRYPOINT ["/bin/sh", "ip_forecast.sh"]