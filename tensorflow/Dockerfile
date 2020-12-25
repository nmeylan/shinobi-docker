FROM node:12.18.3-buster

ENV TFJS_HW=cpu \
    PLUGIN_NAME=Tensorflow \
    PLUGIN_HOST=localhost \
    PLUGIN_PORT=8080 \
    PLUGIN_HOST_PORT=8082 \
    PLUGIN_KEY=RANDOM \
    PLUGIN_MODE=client

RUN apt update -y
RUN apt install wget curl net-tools -y

RUN mkdir -p /home/shinobi-plugins/tensorflow /config
WORKDIR /home/shinobi-plugins/tensorflow


RUN apt install -y python build-essential
RUN apt install -y \
                make \
                g++ \
                gcc \
                node-pre-gyp \
                sudo

RUN npm i npm@latest -g && \
    npm install pm2 -g

RUN apt-get install -y python build-essential

COPY tensorflow /home/shinobi-plugins/tensorflow

COPY tensorflow/package.json /home/shinobi-plugins/tensorflow/package.json
RUN npm install


COPY tensorflow /home/shinobi-plugins/tensorflow
RUN wget https://gitlab.com/Shinobi-Systems/Shinobi/-/raw/dev/tools/modifyConfigurationForPlugin.js -O modifyConfigurationForPlugin.js
RUN chmod -f +x /home/shinobi-plugins/tensorflow/init.sh


VOLUME ["/config"]

EXPOSE 8082

ENTRYPOINT ["/home/shinobi-plugins/tensorflow/init.sh"]

CMD [ "pm2-docker", "pm2.yml" ]
