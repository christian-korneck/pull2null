# unfortunately the container tools in EL 8.2 are too old, even
# with appstreams. So Fedora for now. However, this should probably
# get switched to centos:8.3 once it's out (for long-term use).

FROM fedora:32
RUN dnf install -y podman skopeo jq coreutils gawk grep bash
COPY pull2null /usr/local/bin/
RUN chmod a+rx /usr/local/bin/pull2null
ENTRYPOINT ["pull2null"]
CMD ["--help"]

