#!/bin/bash
# Create Debian source package.  Public domain.

case "$DEBSIGN_KEYID" in
    '')	signing=("-us" "-uc");;
    *)	signing=("-k$DEBSIGN_KEYID");;
esac
exec debuild --no-tgz-check -i -S -rfakeroot -d ${signing[@]}
