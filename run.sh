
#!/bin/sh

CONTAINER_NAME=my-mkjwk
IMAGE_NAME=mkjwk

# Check if the image exists
if ! docker image inspect $IMAGE_NAME > /dev/null 2>&1; then
    docker build -t $IMAGE_NAME . --load
fi

# Check if the container is already running
if ! [ "$(docker ps -q -f name=$CONTAINER_NAME)" ]; then
    docker run -d --name $CONTAINER_NAME -p 8080:8080 $IMAGE_NAME
fi

URL=http://localhost:8080
case "$OSTYPE" in
  darwin*)  open $URL ;;
  linux*)   xdg-open $URL ;;
  msys*)    start $URL ;;
  cygwin*)  start $URL ;;
  *)        echo "Unsupported OS" ;;
esac

