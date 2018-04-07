#!/bin/bash

# Build and run tests within Docker Containers

PWD=$(cd "${BASH_SOURCE[0]}" && pwd)

function _check_docker() {
    if ! which docker &>/dev/null; then
        >&2 echo "Docker must be installed to run tests within docker"
        exit 2
    fi
    if ! docker info &>/dev/null; then
        >&2 echo "Docker must running and available to the current user"
        exit 2
    fi
}

function _build() {
    docker build -t glusterfs:latest .
}

function _test() {
    # Run tests within a docker container

    VOL_OPT=""

    # If using a driver that does not support xattrs, pass a mount to the
    # local filesystem
    if [ "$(docker info -f '{{ .Driver }}')" = "aufs" ]; then
        BACKEND_PARENT=$(mktemp -d)
        VOL_OPT="-v $BACKEND_PARENT:/d/"
        _cleanup() {
            # Clean up root owned test files
            docker run $VOL_OPT glusterfs:latest rm -rf /d/
        }
        trap _cleanup EXIT
    fi

    # --privileged is required for trusted xattr namespaces
    docker run --rm $VOL_OPT --privileged glusterfs:latest bash -c "./run-tests.sh $*"
}

_check_docker
_build

_test $*
