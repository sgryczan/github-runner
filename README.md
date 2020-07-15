# Github self-hosted runner Dockerfile and Kubernetes configuration

This repository contains a Dockerfile that builds a Docker image suitable for running a [self-hosted GitHub runner](https://sanderknape.com/2020/03/self-hosted-github-actions-runner-kubernetes/). A Kubernetes Deployment file is also included that you can use as an example on how to deploy this container to a Kubernetes cluster.

You can build this image yourself, or use the Docker image from the [Docker Hub](https://hub.docker.com/repository/docker/sanderknape/github-runner/general).

## Building the container

`docker build -t github-runner .`

## Features

* Repository runners
* Organizational runners
* Labels
* Graceful shutdown

## Deploying to Kubernetes

1. Create a [GitHub Personal Access Token](https://docs.github.com/en/github/authenticating-to-github/creating-a-personal-access-token) (PAT)
    * Give it the `repo` scope for a private repo, or the `public_repo` scope for a public one.

2. Create the secret:
 ```
 $ kubectl create secret generic github --from-literal=pat=<YOUR PAT>
 ```
3. Modify `deployment.yml` fields to target your repository:
```
env:
    - name: GITHUB_OWNER
      value: <YOUR ORG>
    - name: GITHUB_REPOSITORY
    value: <YOUR REPO>
```
4. Create the deployment:
```
$ kubectl apply -f deployment.yml
```

## Examples

Register a runner to a repository.

```sh
docker run --name github-runner \
     -e GITHUB_OWNER=username-or-organization \
     -e GITHUB_REPOSITORY=my-repository \
     -e GITHUB_PAT=[PAT] \
     michaelcoll/github-runner:latest
```

Create an organization-wide runner.

```sh
docker run --name github-runner \
    -e GITHUB_OWNER=username-or-organization \
    -e GITHUB_PAT=[PAT] \
    michaelcoll/github-runner:latest
```

Set labels on the runner.

```sh
docker run --name github-runner \
    -e GITHUB_OWNER=username-or-organization \
    -e GITHUB_REPOSITORY=my-repository \
    -e GITHUB_PAT=[PAT] \
    -e RUNNER_LABELS=comma,separated,labels \
    michaelcoll/github-runner:latest
```


