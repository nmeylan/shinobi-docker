FROM node:12.18.3-buster

ENV TFJS_HW=cpu \
    PLUGIN_NAME=Yolo \
    PLUGIN_HOST=localhost \
    PLUGIN_PORT=8080 \
    PLUGIN_HOST_PORT=8082 \
    PLUGIN_KEY=RANDOM \
    PLUGIN_MODE=client

RUN apt update -y
RUN apt install wget curl net-tools -y
RUN apt install -y python build-essential
RUN apt-get install apt-file -y && apt-file update && apt-get install vim -y
RUN apt install -y \
                make \
                g++ \
                gcc \
                node-pre-gyp \
                sudo

RUN npm i npm@latest -g && \
    npm install pm2 -g

RUN mkdir -p /home/shinobi-plugins/yolo /config

WORKDIR /home/shinobi-plugins/yolo


RUN wget https://gitlab.com/Shinobi-Systems/Shinobi/-/raw/dev/tools/modifyConfigurationForPlugin.js -O modifyConfigurationForPlugin.js

COPY yolo/package.json /home/shinobi-plugins/yolo/package.json
RUN npm install

COPY yolo/INSTALL.sh /home/shinobi-plugins/yolo/INSTALL.sh
RUN chmod -f +x /home/shinobi-plugins/yolo/INSTALL.sh
RUN ./INSTALL.sh

COPY yolo /home/shinobi-plugins/yolo
COPY yolo/node-yolo-patch.js /home/shinobi-plugins/yolo/node_modules/node-yolo-shinobi/index.js
RUN chmod -f +x /home/shinobi-plugins/yolo/init.sh

VOLUME ["/config"]

EXPOSE 8082

ENTRYPOINT ["/home/shinobi-plugins/yolo/init.sh"]

CMD [ "pm2-docker", "pm2.yml" ]
