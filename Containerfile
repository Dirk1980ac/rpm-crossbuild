# Create a container suitable to build RPM packages for the desired target architecture
# We use the latest release of Fedora
FROM registry.fedoraproject.org/fedora:latest

# Add some metadata.
LABEL description="Rebuild source rpms (for another host arch)."
LABEL vendor="Dirk Gottschalk"

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
	systemd-devel \
	glib2-devel

dnf -y clean all
EOF

VOLUME /datadir

ENTRYPOINT ["/usr/local/bin/build-rpms"]
