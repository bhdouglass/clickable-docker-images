#!/bin/bash

set -Eeuo pipefail

readonly native_arch_list=(amd64 arm64 armhf)
readonly native_dirs=(16.04-native-build 16.04-ide 16.04-nvidia)
readonly native_dirs_legacy=(16.04.4-native-build)

readonly cross_arch_list=(arm64 armhf)
readonly cross_dirs=(16.04-cross-build)
readonly cross_dirs_legacy=(16.04.4-cross-build)

build_native()
{
	(
		set -x
		cd $1
		HOST_ARCH=$2 TAG=$3 ./build.sh
	)
}

build_cross()
{
	(
		set -x
		cd $1
		TARGET_ARCH=$2 TAG=$3 ./build.sh
	)
}

for arch in "${native_arch_list[@]}"; do
	for dir in "${native_dirs[@]}"; do
		build_native ${dir} ${arch} 16.04.5
	done

	for dir in "${native_dirs_legacy[@]}"; do
		build_native ${dir} ${arch} 16.04.4-qt5.9
	done
done

for arch in "${cross_arch_list[@]}"; do
	for dir in "${cross_dirs[@]}"; do
		build_cross ${dir} ${arch} 16.04.5
	done

	for dir in "${cross_dirs_legacy[@]}"; do
		build_cross ${dir} ${arch} 16.04.4-qt5.9
	done
done
