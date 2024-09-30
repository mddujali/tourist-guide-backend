#!/bin/bash

echo "Installing project dependencies..."
composer install
npm install
echo "Project dependencies installed"

echo "Setting environment configuration..."
cp .env.example .env
cp .env.testing.example .env.testing
cp docker-compose.example.yml docker-compose.yml
echo "Environment configured"

ENV=${PWD}/.env

if [ ! -f "${ENV}" ]; then
    cp .env.example .env
fi

source "${ENV}"

SAIL=${PWD}/vendor/bin/sail

if [[ "$(uname)" == "Linux" ]]; then
  sed -i "s/exec -u sail/exec/" "${PWD}"/vendor/laravel/sail/bin/sail
fi

echo "Building and starting the application..."
${SAIL} build
${SAIL} up -d

sleep 10

echo "Generating application key..."
${SAIL} artisan key:generate
${SAIL} artisan key:generate --env=testing
echo "Application key generated"

chmod -R 777 "${PWD}"/storage

APP_CONTAINER_NAME="${APP_BASE_CONTAINER_NAME}-app"
APP_CONTAINER_ID=$(docker ps -qf status=running -f name=^/"${APP_CONTAINER_NAME}"$)

if [ "${APP_CONTAINER_ID}" ]; then
  echo "${APP_CONTAINER_NAME} container is running"
fi

unset APP_CONTAINER_ID

MYSQL_CONTAINER_NAME="${APP_BASE_CONTAINER_NAME}-mysql"
MYSQL_CONTAINER_ID=$(docker ps -qf status=running -f name=^/"${MYSQL_CONTAINER_NAME}"$)

if [ "${MYSQL_CONTAINER_ID}" ]; then
  echo "${MYSQL_CONTAINER_NAME} container is running"
  ${SAIL} artisan migrate
fi

unset MYSQL_CONTAINER_ID
echo "Application started"
