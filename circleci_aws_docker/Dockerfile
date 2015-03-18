# GET UBUNTU
FROM ubuntu
MAINTAINER Samir Said <s@samirsaid.com>

# COPY SOURCE
RUN mkdir /opt/src && mkdir /opt/build && mkdir /opt/libs_df
COPY src /opt/src
COPY libs_df /opt/libs_df
COPY package.json /opt/

# INSTALL NODE & DEPENDENCIES
RUN apt-get update && apt-get install -y  \
   npm \
   curl \
   git

RUN npm install -g n && \
   n 0.10.35

RUN cd /opt && npm install

COPY docker-entrypoint.sh /opt/build/
EXPOSE 3000
ENTRYPOINT ["/opt/build/docker-entrypoint.sh"]