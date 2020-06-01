FROM lsiobase/alpine:3.11

# set version label
ARG BUILD_DATE
ARG VERSION
ARG SMOKEPING_VERSION
LABEL build_version="version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="cullorblind"

# copy tcpping script
COPY tcpping /defaults/

RUN \
 echo "**** install packages ****" && \
 apk add --no-cache \
	perl-lwp-protocol-https \
	bc \
	bind-tools \
	curl \
	font-noto-cjk \
	openssh-client \
	smokeping \
	ssmtp \
	sudo \
	tcptraceroute \
	ttf-dejavu && \
 echo "**** give setuid access to traceroute & tcptraceroute ****" && \
 chmod a+s /usr/bin/traceroute && \
 chmod a+s /usr/bin/tcptraceroute && \
 chown abc /etc/smokeping/smokeping_secrets && \
 echo "**** fix path to cropper.js ****" && \
 sed -i 's#src="/cropper/#/src="cropper/#' /etc/smokeping/basepage.html && \
 echo "**** install tcping script ****" && \
 install -m755 -D /defaults/tcpping /usr/bin/ && \
 mkdir /cache && \
 chown abc /cache

# add local files
COPY root/ /

# ports and volumes
EXPOSE 80
VOLUME /config /data /cache
