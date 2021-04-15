# Clickable Docker Images

Docker images for [Clickable](https://clickable-ut.dev/en/latest/).

## How to build the images

Each image accepts various env variables to customize the output. One variable
supported by all build scripts is TAG. TAG sets the docker tag when building the
images. Any variable that accepts an architecture can be set to: amd64, armhf, or
arm64.

### 16.04-cross-build & 16.04.4-cross-build

- HOST_ARCH - The architecture of the system that will be running this image, only supports amd64
- TARGET_ARCH - The architecture of the target system when building

### 16.04-native-build & 16.04.4-native-build

- HOST_ARCH - The architecture of the system that will be running this image

### 16.04-ide

- HOST_ARCH - The architecture of the system that will be running this image, only supports amd64

### 16.04-nvidia

- HOST_ARCH - The architecture of the system that will be running this image, only supports amd64
- IDE - Set this to "-ide" when building the Nvidia IDE image

## License

Copyright (C) 2020 [Brian Douglass](http://bhdouglass.com/)

This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License version 3, as published
by the Free Software Foundation.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranties of MERCHANTABILITY, SATISFACTORY QUALITY, or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.


##Creating new ide templates

- clone this repo and clone the [clickable](https://gitlab.com/clickable/clickable) repo
- make sure you meet the clickable dependencies listed in the [docs](https://clickable-ut.dev/en/latest/install.html)
- edit the [dockerfile](ubuntu-sdk/16.04-ide/Dockerfile) by adding the commands needed to install, configure and run the IDE
- run `./build.sh` to build the dockerfile
- change dir to your app
- run `clickable-dev ide <ide-command>` to test

*Note:*

*You can specify a tag when building the container and call clickable with this tagged container by using the two commands like this:*
```
TAG=mytag ./build.sh
clickable-dev --docker-image clickable/imagename:mytag
```
*Mind, do not add a space after the '='.*
