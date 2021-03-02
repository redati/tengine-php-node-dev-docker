# docker build -t misaelgomes/tengine-php-node-dev-docker .
# docker run -d -p 3142:3142 misaelgomes/eg_apt_cacher_ng
# acessar localhost:3142 copiar proxy correto e colar abaixo em Acquire
# docker run -d -p 80:80 misaelgomes/tengine-php74

FROM misaelgomes/tengine-php74

#https://docs.docker.com/engine/examples/apt-cacher-ng/
RUN echo 'Acquire::http { Proxy "http://172.17.0.2:3142"; };' >> /etc/apt/apt.conf.d/01proxy

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=America/Sao_Paulo

RUN apt-get update && apt-get upgrade -y && apt-get install -y software-properties-common tzdata curl



RUN cd ~
RUN curl -sL https://deb.nodesource.com/setup_14.x -o nodesource_setup.sh
RUN bash nodesource_setup.sh


RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update

RUN apt-get install -y nodejs yarn 
RUN apt-get install npm -y
RUN npm install -g gulp-cli
RUN node -v

#limpeza

RUN apt-get upgrade -y

RUN echo "America/Sao_Paulo" > /etc/timezone
RUN dpkg-reconfigure -f noninteractive tzdata

RUN apt-get remove --purge --auto-remove -y \
        && apt-get clean \
        && rm -rf /var/lib/apt/lists/*
        
RUN rm -fr /tmp/*

