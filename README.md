# Github self-hosted runner Dockerfile and Kubernetes configuration

This repository contains a Dockerfile that builds a Docker image suitable for running a [self-hosted GitHub runner](https://sanderknape.com/2020/03/self-hosted-github-actions-runner-kubernetes/). A Kubernetes Deployment file is also included that you can use as an example on how to deploy this container to a Kubernetes cluster.

You can build this image yourself, or use the Docker image from the [Docker Hub](https://hub.docker.com/repository/docker/sanderknape/github-runner/general).

## Building the container

`docker build -t github-runner .`

## Features

* Organizational runners
* Labels
* Graceful shutdown

## Deploying to Kubernetes

1. Get a token in your organisation settings -> Actions -> Add runner

3. Modify `deployment.yml` fields to target your repository and org token:
```
data:
    # Base64 encoded of the token
    TOKEN: <a base64 encoded token>
[...]
env:
    - name: ORG_NAME
      value: <YOUR ORG>
```
4. Create the deployment:
```
$ kubectl apply -f deployment.yml
```

## Examples

Create an organization-wide runner.

```sh
docker run --name github-runner \
    -e ORG_NAME=organization \
    -e TOKEN=[token] \
    michaelcoll/github-runner:latest
```

Set labels on the runner.

```sh
docker run --name github-runner \
    -e ORG_NAME=organization \
    -e TOKEN=[token] \
    -e RUNNER_LABELS=comma,separated,labels \
    michaelcoll/github-runner:latest
```


