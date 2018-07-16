#!/bin/bash

if [ -n "${APP_NAME}" ]; then
    ln -s /var/www/html/dbninja /var/www/html/${APP_NAME}/dbninja
fi
