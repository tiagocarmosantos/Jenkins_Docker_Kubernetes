#!/usr/bin/env bash

dockerhub_user=tiagonerv1987

jenkins_port=8080
image_name=missao-devops-jenkins
image_version=2.0.0
container_name=md-jenkins

docker stop ${container_name}

docker build -t ${dockerhub_user}/${image_name}:${image_version} .

if [ ! -d m2deps ]; then
    mkdir m2deps
fi
if [ -d jobs ]; then
    rm -rf jobs
fi
if [ ! -d jobs ]; then
    mkdir jobs
fi

docker run -p ${jenkins_port}:8080 \
    -v "$(pwd)/downloads":/var/jenkins_home/downloads \
    -v "$(pwd)/jobs":/var/jenkins_home/jobs/ \
    -v "$(pwd)/m2deps":/var/jenkins_home/.m2/repository/ \
    -v $HOME/.ssh:/var/jenkins_home/.ssh/ \
    --rm --name ${container_name} \
    ${dockerhub_user}/${image_name}:${image_version}

    