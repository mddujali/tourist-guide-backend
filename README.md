# Tourist Guide Backend
- Backend
- APIs

## Requirements
- Composer 2.7.x or higher
- 8.3.x or higher
- Node.js 20.x.x or higher
- Docker 20.x.x or higher

## Setup
- To install project dependencies
    - `composer install`
    - `npm install`
- Copy `.env.example` to `.env`
- Copy `.env.testing.example` to `.env.testing`
- Copy `docker-compose.yml.example` to `docker-compose.yml`
- Add `alias sail='sh $([ -f sail ] && echo sail || echo vendor/bin/sail)'` to `.bashrc` or `.zshrc`
- Run `sail build` to build the Docker containers
- Run `sail up` to start the Docker containers
- Run `sail up -d` to start the Docker containers in detached mode
- Run `sail artisan key:generate` to create application key
- Run `sail artisan key:generate --env=testing` to create application key for testing
- Run `sail artisan migrate` to execute outstanding migrations
- Run `sail artisan pint --repair` to fix any files with code style errors (PSR-12)
