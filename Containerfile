# Create a container suitable to build RPM packages for the desired target
# architecture on an X86_64 Host

# We use the latest release of Fedora
FROM registry.fedoraproject.org/fedora:latest

LABEL description=""
LABEL vendor.name=""

# Install build tools
RUN dnf -y install automake autoconf autoconf-archive rpm-build libtool gcc

# Install the libraries we need
RUN dnf -y install pcsc-lite-devel libevent-devel glib2-devel systemd-devel

# Copy builder script
COPY build-rpms /usr/local/bin/build-rpms

VOLUME /input
VOLUME /output

ENTRYPOINT [ "/usr/local/bin/build-rpms" ]
