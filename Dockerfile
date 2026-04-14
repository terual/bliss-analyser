FROM ubuntu:24.04

ENV MUSIC_PATH=/music
ENV DB_PATH=/config/bliss.db
ENV IGNORE_FILE=/config/ignore.txt
ENV LMS=127.0.0.1
ENV LOGGING=info

RUN apt-get update && apt-get install -y --no-install-recommends ffmpeg && rm -rf /var/lib/apt/lists/*

# Current is https://github.com/CDrummond/bliss-analyser/releases/download/0.5.2/bliss-analyser-linux-x86-ffmpeg-0.5.2.zip
COPY bliss-analyser /app/bliss-analyser

COPY start-container.sh /usr/bin/start-container
RUN chmod +x /usr/bin/start-container

VOLUME /config /music

ENTRYPOINT ["start-container"]
