#!/bin/sh

set -eu

ARCH=$(uname -m)

echo "Installing package dependencies..."
echo "---------------------------------------------------------------"
# pacman -Syu --noconfirm PACKAGESHERE

echo "Installing debloated packages..."
echo "---------------------------------------------------------------"
get-debloated-pkgs --add-common --prefer-nano

# the app is hardcoded to compile the doc file using /usr/share/sgml/docbook/xsl-stylesheets
# but on archlinux that is in /usr/share/xml/docbook/xsl-stylesheets-1.79.2-nons
mkdir -p /usr/share/sgml/docbook
ln -s /usr/share/xml/docbook/xsl-stylesheets-*-nons /usr/share/sgml/docbook/xsl-stylesheets

# Comment this out if you need an AUR package
make-aur-package trelby

# for some reason when xvfb-run is used in quick-sharun the app somehow
# ends up dlopening mesa, which makes no sense at all, this does not happen when
# deploying locally, and I can reproduce the issue once I try with xvfb-run
pacman -Rdd --noconfirm mesa

# If the application needs to be manually built that has to be done down here

# if you also have to make nightly releases check for DEVEL_RELEASE = 1
#
# if [ "${DEVEL_RELEASE-}" = 1 ]; then
# 	nightly build steps
# else
# 	regular build steps
# fi
