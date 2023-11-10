# clean up
docker rm -f $(docker ps -a)
docker rmi -f $(docker images)
docker builder prune --all --force
docker network rm task2-network
docker volume rm task2-volume