#!/bin/sh


cp -r ${DATA_DIR:?"Need to set DATA_DIR non-empty"}/* .

# generate SAML metadata
make_metadata.py sp_conf.py > sp.xml
cp sp.xml ${DATA_DIR}/.

# start the Service Provider
echo "Starting pysaml2 SP..."
tail -F /tmp/src/pysaml2/example/sp-wsgi/spx.log &
exec start-stop-daemon --start --exec \
    /usr/bin/python3 \
    --chdir /tmp/src/pysaml2/example/sp-wsgi/ -- \
    sp.py sp_conf $*
