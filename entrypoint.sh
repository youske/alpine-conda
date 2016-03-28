#!/bin/sh -e
[ "$1" = 'bash' ] && { chown -R admin . ; exec gosu admin "$@" ; } || :
exec "$@"
