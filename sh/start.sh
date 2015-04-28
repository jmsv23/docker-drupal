#!/bin/bash

service ssh restart
service php5-fpm start
service nginx start
tail -F /start.sh