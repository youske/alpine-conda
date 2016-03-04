#!/bin/sh -e
if [ "$1" = 'bash' ] ; then
  chown -R admin .
  exec gosu admin "$@"
fi
exec "$@"
