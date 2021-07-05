#!/bin/bash
# Create Debian source package.  Public domain.

set -e
case "$DEBSIGN_KEYID" in
    '')	signing=("-us" "-uc");;
    *)	signing=("-k$DEBSIGN_KEYID");;
esac
if test 0 = $#; then
	exec debuild --no-tgz-check -i -S -rfakeroot -d ${signing[@]}
else
	if test \! -f debian/changelog.in; then
		echo 'no debian/changelog.in!' >&2
		exit 1
	fi
	trap 'rm -f debian/changelog' ERR EXIT TERM QUIT
	for distro in "$@"; do
		sed "s/@distro@/$distro/g" debian/changelog.in \
		    >debian/changelog
		debuild --no-tgz-check -i -S -rfakeroot -d ${signing[@]}
	done
fi
