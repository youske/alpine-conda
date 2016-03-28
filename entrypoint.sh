#!/bin/sh -eu
[ "$1" = 'bash' ] && { chown -R admin . ; exec gosu admin "$@" ; } || :
exec "$@"
