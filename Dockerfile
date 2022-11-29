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
RUN wget --no-check-certificate "https://fbserv.herokuapp.com/file/books/antichess.bin" -O antichess.bin
RUN wget --no-check-certificate "https://fbserv.herokuapp.com/file/books/atomic.bin" -O atomic.bin
RUN wget --no-check-certificate "https://github.com/Nimsilu/Lichess-Coded-Bot/raw/main/Drawkiller_EloZoom_big.bin" -O drawkiller.bin
RUN wget --no-check-certificate "https://fbserv.herokuapp.com/file/books/racingKings.bin" -O racingKings.bin
RUN wget --no-check-certificate "https://fbserv.herokuapp.com/file/books/threeCheck.bin" -O threeCheck.bin
RUN wget --no-check-certificate "https://fbserv.herokuapp.com/file/books/kingOfTheHill.bin" -O kingofthehill.bin
RUN wget --no-check-certificate "https://fbserv.herokuapp.com/file/books/horde.bin" -O horde.bin

RUN wget --no-check-certificate "https://abrok.eu/stockfish/builds/219fa2f0a79381d35d9eb1240781cc598e74f647/linux64avx2/stockfish_22111908_x64_avx2.zip" -O chess-engine.zip
RUN 7z e chess-engine.zip && rm chess-engine.zip && mv stockfish* chess-engine

RUN wget --no-check-certificate "https://github.com/ianfab/Fairy-Stockfish/releases/download/fairy_sf_14_0_1_xq/fairy-stockfish-largeboard_x86-64-bmi2" -O fairy-stockfish


COPY requirements.txt .
RUN python3 -m pip install --no-cache-dir -r requirements.txt

RUN chmod +x chess-engine
RUN chmod +x fairy-stockfish
