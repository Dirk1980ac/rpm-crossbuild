# Create a container suitable to build RPM packages for the desired target architecture
# We use the latest release of Fedora
FROM registry.fedoraproject.org/fedora:latest

# Copy builder script
COPY build-rpms /usr/bin/build-rpms

# Install packages
RUN <<EORUN
set -eu

sed -i '/tsflags=nodocs/d' /etc/dnf/dnf.conf
dnf -y upgrade
dnf -y swap coreutils-single coreutils-full
dnf -y swap glibc-minimal-langpack glibc-all-langpacks

dnf -y \
	--setopt="install_weak_deps=False" \
	--no-docs install \
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
rm -rf /var/{log,cache}/*
EORUN

ENV imgname="rpm-crossbuild"
ARG buildid="unset"

LABEL com.github.containers.toolbox="true" \
	name="$imagename" \
	version="$VERSION" \
	usage="This image is meant to be used with the toolbox command" \
	summary="Base image for creating Fedora toolbox containers" \
	maintainer="Dirk Gottschalk <dirk.gottschalk1980@googlemail.com>"

COPY README.md /

VOLUME /datadir

ENTRYPOINT ["/usr/bin/build-rpms"]
