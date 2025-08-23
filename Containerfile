# Create a container suitable to build RPM packages for the desired target architecture
# We use the latest release of Fedora
FROM registry.fedoraproject.org/fedora:latest

ENV imgname="rpm-crossbuild"
ARG buildid="unset"

# Add some metadata.
LABEL org.opencontainers.image.name=${imagename} \
	org.opencontainers.image.version=${buildid} \
	org.opencontainers.image.description="(Cross) build rpms from source rpms." \
	org.opencontainers.image.vendor="Glock GmbH" \
	org.opencontainers.image.author="Dirk Gottschalk" \
	org.opencontainers.image.name=${imgname}

# Copy builder script
COPY build-rpms /usr/bin/build-rpms

# Install packages
RUN <<EORUN
set -eu
dnf -y \
	--setopt="install_weak_deps=False" \
	--no-docs install \
	automake \
	autoconf \
	autoconf-archive \
	rpm-build \
	libtool \
	gcc \
	pcsc-lite-devel \
	libevent-devel \
	glib2-devel \
	systemd-devel && \
	dnf -y clean all

rm -rf /var/log/*
rm -rf /var/cache/*
EORUN

VOLUME /datadir

ENTRYPOINT ["/usr/bin/build-rpms"]
