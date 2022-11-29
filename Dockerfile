FROM ubuntu:jammy
ENV DEBIAN_FRONTEND noninteractive
MAINTAINER heroku
RUN echo heroku
CMD echo heroku
COPY . .


RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

RUN apt-get update && apt-get upgrade -y && apt-get install -y sudo curl apt-utils libqt5gui5 python3-psutil wget python3 python3-pip p7zip-full git build-essential

RUN wget --no-check-certificate "https://github.com/Nimsilu/Lichess-Coded-Bot/raw/main/lichess_torombot_2022-03-04.bin" -O lichess_torombot_2022-03-04.bin
RUN wget --no-check-certificate "https://github.com/Nimsilu/Lichess-Coded-Bot/raw/main/Perfect2021.bin" -O Perfect2021.bin

RUN wget --no-check-certificate "https://abrok.eu/stockfish/builds/d8f3209fb4053bec406645e6df0f8a4d71f5a749/linux64modern/stockfish_22112009_x64_modern.zip" -O chess-engine.zip
RUN 7z e chess-engine.zip && rm chess-engine.zip && mv stockfish* chess-engine

RUN wget --no-check-certificate "https://github.com/ianfab/Fairy-Stockfish/releases/download/fairy_sf_14_0_1_xq/fairy-stockfish-largeboard_x86-64" -O fairy-stockfish


COPY requirements.txt .
RUN python3 -m pip install --no-cache-dir -r requirements.txt

RUN chmod +x chess-engine
RUN chmod +x fairy-stockfish
