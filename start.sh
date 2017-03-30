#!/bin/sh
set -e

service apache2 restart

/var/www/OpenJabNab/server/bin/openjabnab

while true; do sleep 1000; done
