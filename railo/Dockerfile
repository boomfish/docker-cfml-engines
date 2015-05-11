# Dockerfile for Railo on Tomcat

# Use phusion/baseimage as base image. To make your builds reproducible, make
# sure you lock down to a specific version, not to `latest`!
# See https://github.com/phusion/baseimage-docker/blob/master/Changelog.md for
# a list of version numbers.
FROM phusion/baseimage:0.9.16

MAINTAINER Dennis Clark <boomfish@gmail.com>

ENV RAILO_INSTALLER_URL http://www.getrailo.org/railo/remote/download42/4.2.1.008/tomcat/linux/railo-4.2.1.008-pl0-linux-x64-installer.run

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

# Download installer, run it, and delete it in one step to avoid committing the installer in a FS layer
RUN curl $RAILO_INSTALLER_URL -o /root/railo-installer && \
	chmod u+x /root/railo-installer && \
	/root/railo-installer --mode unattended --railopass docker --installconn false --startatboot false && \
	rm -rf /root/railo-installer /tmp/*

ENV DEBIAN_FRONTEND noninteractive

# Install Apache Tomcat Native Library (for Tomcat performance) and Perl Template Toolkit (for config templates)
RUN add-apt-repository ppa:pharmgkb/trusty && \
	apt-get update && \
	apt-get install -y \
		libtcnative-1 \
		python-pip \
		libtemplate-perl && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install envtpl for people who prefer to configure their apps via Jinja2 templates
RUN pip install envtpl

# Add custom Tomcat setenv.sh script
COPY setenv.sh /opt/railo/tomcat/bin/
RUN chmod 755 /opt/railo/tomcat/bin/setenv.sh

# Custom server.xml that treats /opt/railo/tomcat/webapps/ROOT/ as the default application (ie. matches any hostname)
COPY server.xml /opt/railo/tomcat/conf/

# Relocate Railo config for default site to /opt/railo/config/web/ROOT
COPY web.xml /opt/railo/tomcat/webapps/ROOT/WEB-INF/web.xml
RUN mkdir -p /opt/railo/config/web && mv /opt/railo/tomcat/webapps/ROOT/WEB-INF/railo /opt/railo/config/web/ROOT

# Add custom version of tpage that reads environment variables
COPY tpage2.pl /usr/local/bin/tpage2
RUN chmod 755 /usr/local/bin/tpage2

# Setup my_init run script
RUN mkdir /etc/service/railo
COPY run.sh /etc/service/railo/run
RUN chmod 700 /etc/service/railo/run

# Expose connector ports (8888 = HTTP 1.1, 8009 = AJP 1.3)
EXPOSE 8888 8009

# Delete the default application files when using this as a base image
ONBUILD RUN rm -rf /opt/railo/tomcat/webapps/ROOT/Application.cfc /opt/railo/tomcat/webapps/ROOT/favicon.ico /opt/railo/tomcat/webapps/ROOT/index.cfm /opt/railo/tomcat/webapps/ROOT/res


# Uncomment this if you want to enable SSH, required for 'vagrant ssh' to work
#RUN rm -f /etc/service/sshd/down
