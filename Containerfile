# Create a container suitable to build RPM packages for the desired target
# architecture

# We use the latest release of Fedora
FROM registry.fedoraproject.org/fedora:latest

# Add some metadata.
LABEL description="Rebuild source rpms (for another host arch)."
LABEL vendor="Dirk Gottschalk"

# Install packages
RUN <<EOF
dnf -y install automake autoconf autoconf-archive rpm-build libtool gcc \
	pcsc-lite-devel libevent-devel glib2-devel systemd-devel
dnf -y clean all
EOF

# Copy builder script
COPY build-rpms /usr/local/bin/build-rpms

VOLUME /input
VOLUME /output

ENTRYPOINT [ "/usr/local/bin/build-rpms" ]
