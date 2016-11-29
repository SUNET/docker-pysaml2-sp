FROM ubuntu:16.04

RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    build-essential \
    python-dev \
    python-pip \
    libsasl2-dev \
    libssl-dev \
    libffi-dev \
    xmlsec1

RUN pip install --upgrade setuptools pip wheel
RUN pip install --src /tmp/src -e git+https://github.com/rohe/pysaml2#egg=pysaml2
RUN pip install cherrypy==3.8.1

RUN find /tmp/src/pysaml2/example/sp-wsgi/* | grep sp.py -v | xargs rm -rf

COPY start.sh /tmp/
WORKDIR /tmp/src/pysaml2/example/sp-wsgi/
ENV PYTHONPATH="/tmp/src/pysaml2/example/sp-wsgi/"
ENTRYPOINT ["/tmp/start.sh"]
