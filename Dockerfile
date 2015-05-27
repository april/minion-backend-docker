# Start with Ubuntu 14.04 (LTS), and build a Minion install up from there
FROM ubuntu:14.04
MAINTAINER April King <april@twoevils.org>
ENV MINION_BACKEND /opt/minion/minion-backend
EXPOSE 8383
RUN apt-get update && apt-get install -y build-essential \
    curl \
    git \
    libcurl4-openssl-dev \
    mongodb-server \
    postfix \
    python \
    python-dev \
    python-setuptools \
    rabbitmq-server \
    stunnel

# Install minion-backend
RUN git clone https://github.com/mozilla/minion-backend.git ${MINION_BACKEND}
# RUN mkdir -p ${MINION_BACKEND}
COPY run.sh ${MINION_BACKEND}/run.sh
RUN chmod 755 ${MINION_BACKEND}/run.sh
RUN cd ${MINION_BACKEND}; python setup.py develop

# With Docker, we want Minion to listen on 0.0.0.0
RUN mkdir /etc/minion
COPY backend.json /etc/minion/backend.json

# Setup directory for MongoDB
RUN mkdir -p /data/db

# Start up RabbitMQ, MongoDB, and Minion
CMD ${MINION_BACKEND}/run.sh 
