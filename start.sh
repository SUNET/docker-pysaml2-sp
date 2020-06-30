#!/bin/sh


cp -r ${DATA_DIR:?"Need to set DATA_DIR non-empty"}/* .

# generate SAML metadata
make_metadata.py sp_conf.py > sp.xml

# start the Service Provider
exec python3 sp.py sp_conf $*
