#!/usr/bin/env bash

VERSION=2.0.0-1

rm -fr build/web

flutter build web --web-renderer canvaskit --release --dart-define=API_SERVER_URL=/
docker buildx build --platform=linux/amd64 -t mylxsw/deepthink-web:$VERSION . --push

