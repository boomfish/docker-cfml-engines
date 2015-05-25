FROM boomfish/railo-engine

MAINTAINER Dennis Clark <boomfish@gmail.com>

COPY src/ /opt/railo/tomcat/webapps/ROOT/
COPY lib/ /opt/railo/config/web/ROOT/components/lib/

COPY railo_web.xml /opt/railo/config/includes/

# Default locale and timezone
ENV RAILO_LOCALE en_AU
ENV TZ Australia/Sydney