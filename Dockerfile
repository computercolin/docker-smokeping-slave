FROM lsiobase/alpine:3.13

# set version label
ARG BUILD_DATE
ARG VERSION
# ARG SMOKEPING_VERSION
LABEL build_version="version: ${VERSION} Build-date: ${BUILD_DATE}"
LABEL maintainer="computercolin"

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
 chown abc /cache && \
 ln -s /usr/sbin/fping /usr/bin/fping

# add local files
COPY root/ /

# Fix slave non-reboot on config change bug PR181
RUN \
  echo "**** Patching Slave.pm w/ PR181 ****" && \
  [ "$(sha1sum /usr/share/perl5/vendor_perl/Smokeping/Slave.pm | cut -d' ' -f1)" = 93f28590b1e24156fe0a74ce3814a434e8e7c7dd ] && \
  cat /patch/Slave.pm > /usr/share/perl5/vendor_perl/Smokeping/Slave.pm

# ports and volumes
# EXPOSE 80
VOLUME /config /data /cache
