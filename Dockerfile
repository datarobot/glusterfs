# Dockerfile for Building (and Testing) GlusterFS

# Build using `docker build -t glusterfs:latest .` or `./run-tests-in-docker.sh`

FROM centos:7

RUN yum install -y git autoconf automake libtool make epel-release \
    && yum install -y flex bison \
        libacl-devel userspace-rcu-devel openssl-devel libxml2-devel libtirpc-devel \
        sqlite-devel python-devel fuse-devel \
        librdmacm-devel libibverbs-devel readline-devel lvm2-devel libaio-devel \
        dbench nfs-utils yajl-devel xfsprogs attr sysvinit-tools \
        file which psmisc

COPY . /opt/glusterfs/src

WORKDIR /opt/glusterfs/src

RUN ./autogen.sh \
    && ./configure

RUN make clean
RUN make -j
RUN make -j install

VOLUME /d/
# FIXME: if GLUSTERD_WORKDIR is not set, rm -rf $GLUSTERD_WORKDIR/* is not happy...
RUN echo "export GLUSTERD_WORKDIR=/var/lib/glusterd/" > env.rc
