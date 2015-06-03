# minion-docker
Dockerfile needed to create a fully functional Minion build

Mozilla Minion is available: https://github.com/mozilla/minion

# To build:
    docker build -t 'mozilla/minion-backend' .

# To run:
    docker run -d --name 'minion-backend' 'mozilla/minion-backend'
