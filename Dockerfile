FROM node:16-buster

RUN set -e; \
    apt update; \
    apt install -y gettext; \
    apt install -y build-essential cmake; \
    apt install -y libopencv-dev python3-opencv; \
    apt install -y python3-pip; \
    rm -rf /var/lib/apt/lists/*

# See https://github.com/waveform80/picamera/issues/578
ENV READTHEDOCS=True

RUN pip3 install picamera; \
    pip3 install dlib; \
    pip3 install face_recognition; \
    pip3 install imutils; \
    pip3 install numpy

ARG branch=master

ENV NODE_ENV production
WORKDIR /opt/magic_mirror

RUN git clone --depth 1 -b ${branch} https://github.com/MichMich/MagicMirror.git .
RUN cp -R modules /opt/default_modules
RUN cp -R config /opt/default_config
RUN npm install --unsafe-perm --silent

WORKDIR modules/MMM-Face-Reco-DNN

RUN git clone https://github.com/nischi/MMM-Face-Reco-DNN.git . && \
    npm install --unsafe-perm

WORKDIR /opt/magic_mirror

RUN git clone https://github.com/ulrichwisser/MMM-HTMLSnippet ./modules/MMM-HTMLSnippet

COPY mm-config.js docker-entrypoint.sh ./
RUN chmod +x ./docker-entrypoint.sh

EXPOSE 8080
ENTRYPOINT ["./docker-entrypoint.sh"]
CMD ["node", "serveronly"]