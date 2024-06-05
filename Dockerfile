FROM python:3.11

WORKDIR /

ARG ANKI_DOWNLOAD_LINK='https://github.com/ankitects/anki/releases/download/24.04.1/anki-24.04.1-linux-qt6.tar.zst'

ARG ANKI_USER=example

ARG ANKI_PASSWORD=GttBV7Pm3X8UFF

RUN apt-get update && apt-get install -y zstd libxcb-xinerama0 \
  && rm -rf /var/lib/apt/lists/* \
  && wget $ANKI_DOWNLOAD_LINK \
  && DOWNLOAD_FILE=$(basename $ANKI_DOWNLOAD_LINK) \
  && echo $DOWNLOAD_FILE \
  && tar xf $DOWNLOAD_FILE \
  && FILENAME_WITHOUT_EXTENSION=$(basename $DOWNLOAD_FILE .tar.zst) \
  && mv $FILENAME_WITHOUT_EXTENSION anki \
  && mkdir ankidata

WORKDIR /anki

RUN python3 -m venv syncserver \
  && syncserver/bin/pip install anki 

# RUN sed '/xdg-mime/d' install.sh > install_without_xdg_mime.sh && mv install_without_xdg_mime.sh install.sh \
#   && ./install.sh \
#   && python3 -m venv syncserver syncserver/bin/pip install anki 

ENV SYNC_USER1=${ANKI_USER}:${ANKI_PASSWORD}
ENV SYNC_BASE='/ankidata'
ENTRYPOINT [ "syncserver/bin/python", "-m", "anki.syncserver" ]
