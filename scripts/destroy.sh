#!/bin/bash

SAIL=${PWD}/vendor/bin/sail

echo "Destroying the application..."
${SAIL} composer dump-autoload
${SAIL} artisan optimize:clear

${SAIL} down --rmi all --volumes --remove-orphans

echo "Clearing the application..."
rm -rf "${PWD}"/.env \
"${PWD}"/.env.testing \
"${PWD}"/docker-compose.yml \
"${PWD}"/vendor \
"${PWD}"/composer.lock \
"${PWD}"/node_modules \
"${PWD}"/package-lock.json \
"${PWD}"/storage/logs/*.log \
"${PWD}"/*_ide_helper* \
"${PWD}"/*helper.php \
"${PWD}"/.phpstorm* \
"${PWD}"/.phpunit* \
"${PWD}"/*_cache.php \
"${PWD}"/.rnd \
"${PWD}"/storage/oauth-private.key \
"${PWD}"/storage/oauth-public.key
echo "Application cleared"

docker system prune -af
docker container prune -f
docker image prune -f
docker volume prune -f
docker network prune -f
docker builder prune -f
echo "Application destroyed"
