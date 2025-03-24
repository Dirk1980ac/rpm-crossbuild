# rpm-crossbuild

I use this container to cross rebuild a small RPM for arm64 I created for a
special bootc-container project internally and inject them into the Image
since it runs on a raspberry pi.

Only the libraries and components I need are installed.

The rpm-crossbuild script is used to run the container and build the package.

## Usage

Just invoke rpm-crossbuild with the apropriate parameters. It automatically
will rebuild all .src.rpm files in the given input diretory and saves the
resulting binary RPMs in the output directory.

```text
Usage: rpm-crossbuild -i <directory> -o <directory> -p <platform>

Options:
    -d <directory>      Working directory (mandatory)
    -p <platform>       Target platform (e.g linux/arm64) (mandatory)
    -h                  Show this help
```
