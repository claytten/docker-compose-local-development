Dockering Common Local Development Environment (standalone)
===============
This repo is functionality not completed — need your help to improve!

## Requirement
  * `[Optional] Install Make` - [Linux](https://ioflood.com/blog/install-make-command-linux/#:~:text=In%20most%20Linux%20distributions%2C%20the,command%20sudo%20yum%20install%20make%20.) [Windows](https://stackoverflow.com/questions/32127524/how-to-install-and-use-make-in-windows) [Mac](https://stackoverflow.com/questions/10265742/how-to-install-make-and-gcc-on-a-mac)
  * `Install Docker and Docker Compose` - [Linux](https://www.howtogeek.com/devops/how-to-install-docker-and-docker-compose-on-linux/) [Windows](https://www.ionos.com/digitalguide/server/configuration/install-docker-compose-on-windows/) [Mac](https://www.ionos.com/digitalguide/server/configuration/docker-compose-on-mac/)

## Installation
Clone the repository
```
git clone https://github.com/claytten/docker-compose-local-development.git
```
Switch to the repo folder
```
cd docker-compose-local-development
```
Rename the file `.env.example` to `.env` and configure the environment variables
```
cp .env.example .env
```
(optional#1) Run using makefile command, the instruction can be found by command "make help"
```
make help
```
(optional#2) Run directly using docker-compose with spesific file, for example
```
docker-compose -f docker-compose-db.yml up -d
```
or
```
docker-compose -f docker-compose-db.yml down
```

***Note*** : If you want to use a programming language as the default local debugging needs customization
- Linux: configure the default path to .bashrc/.zshrc then source .bashrc/.zshrc to apply configuration
  ![image](https://github.com/claytten/docker-compose-local-development/assets/38114768/215f8f5f-c7f1-48d7-9829-b712d857b0a3)
- Windows: configure the default path in the environment variable
- Mac: (soon)

## License 
This repository is open-sourced software licensed under the [MIT license].
