#!/bin/sh
usage="$(basename "$0") [-d -p] [-u] -- handles deployment to a development or production server

where:
    -h  show this help text
    -p  deploy/undo production
    -d  deploy/undo development
    -u  will undo previous development or production deployment"

# variables
BUILD_DIR=build
BACKUPS_DIR=$PWD/../_backups

DEV_SERVER=$(grep \"devServer\"\: ./package.json | sed 's/.*\: \"\(.*\)",/\1/')
DEV_SERVER_PATH=$(grep \"devServerPath\"\: ./package.json | sed 's/.*\: \"\(.*\)",/\1/')
DEV_BACKUPS_DIR=$BACKUPS_DIR/dev


if [[ ! $DEV_SERVER ]]; then
    echo 'Add "devServer" to package.json and try again'
    exit 1
fi
if [[ ! $DEV_SERVER_PATH ]]; then
    echo 'Add "devServerPath" to package.json and try again'
    exit 1
fi


TIME=$(date +"%s")

while getopts ":hpdu" opt; do
  case $opt in
    h)
      echo "$usage" >&2
      exit 1
      ;;
    p)
      echo "Production deployment" >&2
      MODE=production
      ;;
    d)
      echo "Development deployment" >&2
      MODE=development
      ;;
    u)
      echo "Undoing previous $MODE deployment"
      UNDO=true
      ;;
    \?)
      printf "Invalid option -%s\n" "$OPTARG" >&2
      echo "$usage" >&2
      exit 1
      ;;
  esac
done

if [ ! $MODE ]; then
  printf "Specify an option \n" >&2
  echo "$usage" >&2
  exit 1
fi

# make the backups dir if it doesn't exist
if [ ! -d "$BACKUPS_DIR" ]; then
    mkdir "$BACKUPS_DIR"
fi;

if [ ! -d "$DEV_BACKUPS_DIR" ]; then
    mkdir "$DEV_BACKUPS_DIR"
fi

getlatestdevdeployment() {
  local max=0
  for n in $(ls $DEV_BACKUPS_DIR); do
    if [[ n > max ]]; then max=$n; fi;
  done
  echo "$max"
}
LATEST_DEV_BACKUP=$DEV_BACKUPS_DIR/$(getlatestdevdeployment)


backupdev() {
    echo "Backing up $DEV_SERVER:$DEV_PATH$BUILD_DIR to $DEV_BACKUPS_DIR"
    echo
    rsync -rv $DEV_SERVER:$DEV_SERVER_PATH$BUILD_DIR $DEV_BACKUPS_DIR/$TIME
}

deploydev() {
    echo "Deploying $BUILD_DIR to $DEV_SERVER:$DEV_PATH"
    echo
    rsync -rv $BUILD_DIR $DEV_SERVER:$DEV_SERVER_PATH
}

undodeploydev() {
    if [ ! -d "$LATEST_DEV_BACKUP" ]; then
      echo "No backup exists. Deploy before undoing\n" >&2
      exit 1
    fi;
    echo "Undoing last dev deployment"
    echo
    rsync -rv $LATEST_DEV_BACKUP/$BUILD_DIR $DEV_SERVER:$DEV_SERVER_PATH
}

if [ "$MODE" == "development" ]; then
  if [ "$UNDO" ]; then
    echo 'Undoing last development deployment \n'
    undodeploydev
    exit
  fi
  echo 'Deploying to development server \n'
  backupdev
  deploydev
  exit
fi
