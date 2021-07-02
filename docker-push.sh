#
# THIS WILL CHANGE MCE & MAE images in PROD because it uses latest, which this updates!
#

ARTIFACTORY_PATH="databus-dockerv2.docker.artifactory.viasat.com/atg/datahub"
TAG=$(git rev-parse --short=12 --verify HEAD)

docker push $ARTIFACTORY_PATH/mae-consumer:${TAG}
docker tag $ARTIFACTORY_PATH/mae-consumer:${TAG} $ARTIFACTORY_PATH/mae-consumer:latest
docker push $ARTIFACTORY_PATH/mae-consumer:latest

# docker push $ARTIFACTORY_PATH/mce-consumer:${TAG}
# docker tag $ARTIFACTORY_PATH/mce-consumer:${TAG} $ARTIFACTORY_PATH/mce-consumer:latest
# docker push $ARTIFACTORY_PATH/mce-consumer:latest
