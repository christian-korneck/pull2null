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

### Is it treating the container registry's resources nicely?
Partly. It doesn't pull an image twice, even if that image is available under multiple tags. However it doesn't keep layers between pulls as it's intended to run on small CI runners and cloud instances with not much disk space. Please don't run it more often then necessary (i.e. every 6 months).


