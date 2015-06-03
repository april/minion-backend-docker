# minion-backend-docker
Dockerfile needed to create a fully functional Minion build

Mozilla Minion is available:
* https://github.com/mozilla/minion
* https://github.com/mozilla/minion-backend
* https://github.com/mozilla/minion-frontend

# To build:
    docker build -t 'mozilla/minion-backend' .

# To run:
    docker run -d --name 'minion-backend' 'mozilla/minion-backend'
