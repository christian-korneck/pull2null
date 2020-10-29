# pull2null
script to dummy-pull all container images from a repo at a container registry to avoid [inactivity purge](https://www.docker.com/pricing/retentionfaq)

## usage

### example:

```
docker run --rm -ti docker.io/chko/pull2null docker.io/my-user/my-repo
```

### example with auth:

To increase the [rate limit](https://www.docker.com/pricing) you can login

```
docker run --rm -ti -e 'INPUT_DOCKER_USER=my-user' -e 'INPUT_DOCKER_PASSWORD=my-password' -e 'INPUT_REGISTRY_SERVER=docker.io' docker.io/chko/pull2null docker.io/my-user/my-repo
```

### reference

```
Usage:
  pull2null [flags] NAME

Description:
  script to "dummy"-pull all container images for a given container repo name
  (to prevent the container registry to purge images after a periode of inactivity)

Flags:
  --dry-run                     get metadata but does not actually pull (warning: login will persist!)
  --no-delete                   dont delete layers between pulls (prevents that layers get downloaded more
                                then once, but needs more disk space)
  -h, --help                    help for this command

Args:
  NAME                          container repo (example: docker.io/my-user/my-repo)

Optional env vars for Docker Login (to increase the rate limit):
  INPUT_DOCKER_USER             username for container registry
  INPUT_DOCKER_PASSWORD         password for container registry
  INPUT_REGISTRY_SERVER         the registry server name (for Docker Hub use: \"docker.io\" )
```

## FAQ

### Can it pull Windows container images?
Yes

### Does it work for large repos? What about pull rate limits?
Docker Hub pull rate limits currently seem to be at 100 pulls per 6 hours for unauthenticated user, 200 for authenticated users and unlimited (or so) for paid accounts. You can pass a registry login to the script via env vars (see example above) to increase the rate limit. To see how many pulls would be necessary for a particular repo you can run `--dry-run` that prints the count.

### Is it treating the container registry's resources nicely?
Partly. It doesn't pull an image twice, even if that image is available under multiple tags. However by default it doesn't keep layers between pulls as it's intended to run on small CI runners and cloud instances with not much disk space. If you have enough disk space you can use `--no-delete`, which leads to less downloads. Please don't run this script  more often then necessary (i.e. every 6 months) to not cause unnecessary traffic for your registry provider.

# Related

- new Docker Hub retention limit (starting ~~1-Nov-2020)~~ mid 2021): [FAQ](https://www.docker.com/pricing/resource-consumption-updates) and [blog post](https://www.docker.com/blog/scaling-dockers-business-to-serve-millions-more-developers-storage/) and [blog update (delay to mid 2021)](https://www.docker.com/blog/docker-hub-image-retention-policy-delayed-and-subscription-updates/)
- new Docker Hub pull rate limits: [blog post](https://www.docker.com/blog/scaling-docker-to-serve-millions-more-developers-network-egress/)
