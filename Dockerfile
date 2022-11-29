FROM ubuntu:Jammy
ENV DEBIAN_FRONTEND noninteractive
MAINTAINER activer
RUN echo activer
CMD echo activer
COPY . .


RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

RUN apt-get update && apt-get upgrade -y && apt-get install -y sudo curl apt-utils libqt5gui5 python3-psutil wget python3 python3-pip p7zip-full git build-essential

RUN wget --no-check-certificate "https://github.com/Nimsilu/Lichess-Coded-Bot/raw/main/lichess_torombot_2022-03-04.bin" -O lichess_torombot_2022-03-04.bin
RUN wget --no-check-certificate "https://gitlab.com/OIVAS7572/Cerebellum3merge.bin/-/raw/master/Cerebellum3Merge.bin.7z" -O Cerebellum3Merge.bin.7z
Run 7z e Cerebellum3Merge.bin.7z && rm Cerebellum3Merge.bin.7z

RUN wget --no-check-certificate "https://abrok.eu/stockfish/builds/f3a2296e591d09dd50323fc3f96e800f5538d8bb/linux64bmi2/stockfish_22031308_x64_bmi2.zip" -O chess-engine.zip
RUN 7z e chess-engine.zip && rm chess-engine.zip && mv stockfish* chess-engine


COPY requirements.txt .
RUN python3 -m pip install --no-cache-dir -r requirements.txt

RUN chmod +x chess-engine
RUN chmod +x engines/stockfish
RUN chmod +x engines/multivariant_stockfish
