#!/bin/sh
set -e

service apache2 restart

cd /var/www/OpenJabNab/server/bin
./openjabnab

