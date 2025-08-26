ARG BUILD_FROM
FROM ${BUILD_FROM}

# Add PulseAudio/PipeWire utils for mic capture via HA Audio, plus Python and wyoming-satellite
RUN apk add --no-cache python3 py3-pip alsa-utils pulseaudio-utils pipewire-tools \
    && pip3 install --no-cache-dir --break-system-packages wyoming-satellite

COPY run.sh /run.sh
RUN chmod a+x /run.sh

CMD [ "/run.sh" ]
