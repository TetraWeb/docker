FROM debian:jessie

MAINTAINER Dmitry Lukashin <dlukashin@tetraweb.ru>

RUN apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0x5a16e7281be7a449 \
	&& echo deb http://dl.hhvm.com/debian jessie main | tee /etc/apt/sources.list.d/hhvm.list \
	&& apt-get update \
	&& apt-get install -y hhvm --no-install-recommends \
	&& rm -r /var/lib/apt/lists/*

CMD ["php", "-a"]
