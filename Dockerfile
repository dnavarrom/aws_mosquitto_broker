FROM alpine:3.6

LABEL maintainer "diego.navarro.m@gmail.com"

ARG BUILD_DATE
ARG VCS_REF
LABEL org.label-schema.build-date=$BUILD_DATE \
    org.label-schema.docker.dockerfile="/Dockerfile" \
    org.label-schema.name="aws-mosquitto-broker" \
    org.label-schema.url="https://hub.docker.com/r/mantgambl/aws_mosquitto_broker/" \
    org.label-schema.vcs-ref=$VCS_REF \
    org.label-schema.vcs-type="Git" \
    org.label-schema.vcs-url="https://github.com/dnavarrom/aws_mosquitto_broker"


RUN apk --no-cache add mosquitto=1.4.12-r0 && \
    mkdir -p /mosquitto/config /mosquitto/data /mosquitto/log && \
    #chmod -R 110 /mosquitto && \
    chmod -R 777 /mosquitto && \
    chown -R mosquitto:mosquitto /mosquitto

    VOLUME ["/mosquitto/config", "/mosquitto/data", "/mosquitto/log"]

COPY /config /mosquitto/config
COPY docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["/usr/sbin/mosquitto", "-c", "/mosquitto/config/mosquitto.conf"]
