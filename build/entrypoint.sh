#!/bin/sh -eu
[ "$1" = 'bash' ] && { chown -R admin:admin . ; exec gosu admin "$@" ; } || :
exec "$@"
