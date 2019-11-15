#!/bin/bash

echo "INFO: build gitlab-runner with docker installed..."
docker build --tag pamtrak06/jhpster-with-docker --file build/Dockerfile build
