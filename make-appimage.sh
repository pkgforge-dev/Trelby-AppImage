#!/bin/sh

set -eu

ARCH=$(uname -m)
VERSION=$(pacman -Q trelby | awk '{print $2; exit}') # example command to get version of application here
export ARCH VERSION
export OUTPATH=./dist
export ADD_HOOKS="self-updater.bg.hook"
export UPINFO="gh-releases-zsync|${GITHUB_REPOSITORY%/*}|${GITHUB_REPOSITORY#*/}|latest|*$ARCH.AppImage.zsync"
export ICON=/usr/share/trelby/resources/icon256.png
export DESKTOP=/usr/share/applications/trelby.desktop
export DEPLOY_PYTHON=1
export ALWAYS_SOFTWARE=1 # gtk3 is not hardware accelerated

# Deploy dependencies
quick-sharun /usr/bin/trelby

# Additional changes can be done in between here

# Turn AppDir into AppImage
quick-sharun --make-appimage

# Test the app for 12 seconds, if the test fails due to the app
# having issues running in the CI use --simple-test instead
quick-sharun --test ./dist/*.AppImage
