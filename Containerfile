# Create a container suitable to build RPM packages for the desired target architecture
# We use the latest release of Fedora
FROM registry.fedoraproject.org/fedora:latest

# Copy builder script
COPY build-rpms /usr/bin/build-rpms

# Install packages
RUN <<EORUN
set -eu


dnf -y --setopt="install_weak_deps=False" --no-docs install \
	passwd \
	shadow-utils \
	util-linux \
	vte-profile \
	automake \
	autoconf \
	autoconf-archive \
	rpm-build \
	libtool \
	gcc \
	pcsc-lite-devel \
	libevent-devel \
	glib2-devel \
	systemd-devel

dnf -y clean all
rm -rf /var/{log,cache,spool,tmp}/*
EORUN

ENV imgname="rpm-crossbuild"
ARG buildid="unset"

LABEL org.opencontainers.image.vendor="Dirk Gottschalk" \
	org.opencontainers.image.authors="Dirk Gottschalk" \
	org.opencontainers.image.name=${imagename} \
	org.opencontainers.image.version=${buildid} \
	org.opencontainers.image.description="Description"

COPY README.md /

VOLUME /datadir

ENTRYPOINT ["/usr/bin/build-rpms"]
