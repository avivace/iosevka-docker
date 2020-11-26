# <img src=".meta/header.png" alt="iosevka-docker" width="400px"/>

[![Docker Pulls](https://img.shields.io/docker/pulls/avivace/iosevka-build?style=flat-square)](https://hub.docker.com/r/avivace/iosevka-build)

> Iosevka custom building with Docker and debian packages.

This repository provides an easy (and headless) way to build your own version of the Iosevka typeface without having to worry about dependencies and build environments.

## Quickstart

Prepare your custom build configuration following the [Customized Build](https://github.com/be5invis/Iosevka#customized-build) documentation or use the [Iosevka Build Customizer](https://typeof.net/Iosevka/customizer).

Go to the directory where your `private-build-plans.toml` is and run

```bash
docker run -e FONT_VERSION=3.7.1 -it -v $(pwd):/build avivace/iosevka-build
```

It will pull the container image from Docker Hub and run the font build for you, following your configuration. Your built font files will be available in the `dist/` folder.

If you want to build the docker image yourself, keep reading.

## Build

1. Be sure to have Docker installed. Clone this repository.

```bash
git clone https://github.com/avivace/fonts-iosevka.git
``` 

2. If you want, replace the provided `private-build-plans.toml` file with yours.

3. Build and run the Docker container

```bash
# Build the container
docker build -t iosevka_build . -f Dockerfile

# Launch the build on Iosevka git tag 3.7.1, using the build folder on the host
docker run -e FONT_VERSION=3.7.1 -it -v $(pwd)/build:/build iosevka_build
```

4. Done! Your built font files are available in the `dist` folder.

## Install

Copy the generated folders in `~/.local/share/fonts` and run `fc-cache`.

```bash
cp -r build/dist/* ~/.local/share/fonts/
fc-cache
```

## Debian packaging

TODO

## References and links

- https://git.mmk2410.org/deb/fonts-iosevka
- https://github.com/ejuarezg/containers/tree/master/iosevka_font#container-method
- https://github.com/be5invis/Iosevka
- [Original Dockerfile](https://gist.github.com/tasuten/0431d8af3e7b5ad5bc5347ce2d7045d7)
- https://github.com/nodesource/distributions/blob/master/README.md
- https://premake.github.io/download.html#v5
- https://stackoverflow.com/questions/6482377/check-existence-of-input-argument-in-a-bash-shell-script
- https://gist.github.com/steinwaywhw/a4cd19cda655b8249d908261a62687f8
- https://stackoverflow.com/questions/1247812/how-to-use-grep-to-get-anything-just-after-name
