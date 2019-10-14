FROM lmnetworks/alpine:3.10.2_20191014

LABEL io.github.tinyproxy.version="1.10.0"
LABEL image_name="lmnetworks/tinyproxy"
LABEL maintainer="info@lm-net.it"

# add Tinyproxy
RUN apk add --no-cache tinyproxy=1.10.0-r2 && \
    cp /etc/tinyproxy/tinyproxy.conf /etc/tinyproxy/tinyproxy.conf.dist && \
    printf '    User tinyproxy\n\
    Group tinyproxy\n\
    Port 3128\n\
    LogLevel Connect\n\
    MaxClients 100\n\
    MinSpareServers 5\n\
    MaxSpareServers 20\n\
    StartServers 5\n\
    MaxRequestsPerChild 100\n\
    DisableViaHeader Yes\n'\
    > /etc/tinyproxy/tinyproxy.conf

# expose proxy port
EXPOSE 3128

# by default start Tinyproxy
CMD  [ "/usr/bin/tinyproxy", "-d" ]
