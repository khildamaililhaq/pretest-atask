
# Internal wallet transactional system || Atask Test

This Application is created using

- Ruby 3.2.0
- Rails 7.2
- Postgresql 17




### Installation and Running

For the installation process, first you need to install Ruby and Postgresql first, you can follow the instruction [here](https://docs.docker.com/compose/install/) to install docker and follow the next steps bellow.

- Enter the app directory, and type ```cp .env.example .env``` and it will created environtment file that look like this, and fill the variable with yours


```bash
##Apps Thing
export RAPID_API_KEY=99d3201c84mshb970256e7b62acdp1946d5jsn460b863e2ad8
export RAPID_API_HOST=latest-stock-price.p.rapidapi.com
export RAPID_API_URL=https://latest-stock-price.p.rapidapi.com/
export ENCRYPTION_KEY=encryption_key

##Docker Thing
export DOCKER_BUILDKIT=1
export COMPOSE_PROJECT_NAME=atask
export COMPOSE_PROFILES=postgres,web,worker
export SECRET_KEY_BASE=insecure_key_for_dev
export RAILS_ENV=development
export NODE_ENV=development
export WEB_CONCURRENCY=1
export RAILS_MAX_THREADS=1
export POSTGRES_USER=hello
export POSTGRES_PASSWORD=password
export DOCKER_RESTART_POLICY=no
export DOCKER_WEB_HEALTHCHECK_TEST=/bin/true
export DOCKER_WEB_PORT_FORWARD=3000
export DOCKER_CABLE_PORT_FORWARD=28080
export DOCKER_WEB_VOLUME=.:/app
# export DOCKER_POSTGRES_CPUS=0
# export DOCKER_POSTGRES_MEMORY=0
# export DOCKER_REDIS_CPUS=0
# export DOCKER_REDIS_MEMORY=0
# export DOCKER_WEB_CPUS=0
# export DOCKER_WEB_MEMORY=0
# export DOCKER_WORKER_CPUS=0
# export DOCKER_WORKER_MEMORY=0
# export DOCKER_CABLE_CPUS=0
# export DOCKER_CABLE_MEMORY=0

```
- Open Project Directory from terminal, and type ```docker compose up --build```
- In another terminal type ```./run rails db:prepare``` to setup postgresql database
- In another terminal type ```./run rails db:seed``` to seed predefined data
- To see the API documentation you can go to the ```{yourAppURL}/api-docs```

### Note:
- Every command in terminal to access docker container must be specify with ```./run {your command}```
- Type ```./run``` to see available command

### Account for Documentation Test:
- User -> username: demo_user, password: password, pin: 123456
- Team -> username: demo_team, password: password, pin: 123456
- Stock -> username: FUSION, password: FUSION, pin: 123456

### Rake tasks
From local Gem ```latest_stock_price``` is provided some rake tasks, don't forget to use ```./run``` prefix for
every command
- ```rake stock_price:get_price[//your stock identifier string//]``` to see specific stock price detail
- ```rake stock_price:get_prices[//your stock identifiers separated with comma//]``` to see multiple stock price detail
- ```rake stock_price:get_all``` to see all available stock price

From rails app
- ```rake stock_price:update_all``` to update all stock price
