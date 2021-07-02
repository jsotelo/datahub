ARTIFACTORY_PATH="databus-dockerv2.docker.artifactory.viasat.com/atg/datahub"
TAG=$(git rev-parse --short=12 --verify HEAD)

docker build -t $ARTIFACTORY_PATH/mae-consumer:${TAG} -f docker/mae-consumer/Dockerfile .
docker build -t $ARTIFACTORY_PATH/mce-consumer:${TAG} -f docker/mce-consumer/Dockerfile .