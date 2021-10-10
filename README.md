# iosevka-docker

[![Docker Pulls](https://img.shields.io/docker/pulls/avivace/iosevka-build?style=flat-square)](https://hub.docker.com/r/avivace/iosevka-build)

Docker containers to build your own (or standard) version of the [Iosevka](https://github.com/be5invis/Iosevka) typeface without worrying about dependencies and build environments.

## Quickstart

Linux:
```bash
docker run -it -v $(pwd):/build avivace/iosevka-build
```

Windows (Command Prompt)
```bash
docker run -it -v %cd%:/build avivace/iosevka-build
```

Windows (PowerShell)
```bash
docker run -it -v ${PWD}:/build avivace/iosevka-build
```

_For the rest of this document, replace `$(pwd)` with either `%cd%` or `${PWD}` based on your environment_

Will build the [latest](https://github.com/be5invis/Iosevka/releases/tag/v4.0.0) released version of Iosevka with the default configuration.

Your built font files will be available in the `dist/` folder.

### Custom build configuration

To customize your build, just launch the docker command from the directory where your `private-build-plans.toml` is placed.

You can prepare your configuration following the [Customized Build](https://github.com/be5invis/Iosevka#customized-build) documentation or use the [Iosevka Build Customizer](https://typeof.net/Iosevka/customizer).

> Be aware of the breaking changes introduced with 4.0.0 i.e. configurations working with `3.7.1` are not guaranteed to work with `4.0.0`.

### Version

To specify a version to build, just add `-e FONT_VERSION=` to the Docker command. E.g. to build version `3.7.1`:

```
docker run -e FONT_VERSION=3.7.1 -it -v $(pwd):/build avivace/iosevka-build
```
Releases can be found [here](https://github.com/be5invis/Iosevka/releases). Only font versions 3.0.0 or higher are supported.

### Build arguments

You can pass any of the optional build options described in [Customized Build](https://github.com/be5invis/Iosevka#customized-build).

```
docker run -it -v $(pwd):/build avivace/iosevka-build [optional build args]
```

 E.g. to only build TTF files:

```bash
docker run -it -v $(pwd):/build avivace/iosevka-build ttf::iosevka-custom
```

## Build the Docker image yourself

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
