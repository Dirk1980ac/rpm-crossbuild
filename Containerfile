# Create a container suitable to build RPM packages for the desired target architecture
# We use the latest release of Fedora
FROM registry.fedoraproject.org/fedora:latest

ENV imgname="rpm-crossbuild"
ARG buildid="unset"

# Add some metadata.
LABEL org.opencontainers.image.name=${imagename} \
	org.opencontainers.image.version=${buildid} \
	org.opencontainers.image.description="(Cross) build rpms from source rpms." \
	org.opencontainers.image.vendor="Dirk Gottschalk" \
	org.opencontainers.image.author="Dirk Gottschalk" \
	org.opencontainers.image.name=${imgname}

# Copy builder script
COPY build-rpms /usr/local/bin/build-rpms

# Install packages
RUN <<EOF
set -eu

dnf -y update

dnf -y --setopt="install_weak_deps=False" install \
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
EOF

VOLUME /datadir

ENTRYPOINT ["/usr/local/bin/build-rpms"]
