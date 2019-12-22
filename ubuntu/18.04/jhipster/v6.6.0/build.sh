#!/bin/bash

echo "INFO: build gitlab-runner with docker installed..."
docker build --tag pamtrak06/jhpster-docker:v6.2.0 --file build/Dockerfile build
