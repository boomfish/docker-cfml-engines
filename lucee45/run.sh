#!/bin/sh

# switch the subshell to the tomcat directory so that any relative
# paths specified in any configs are interpreted from this directory.
cd /opt/lucee/tomcat/

# Railo settings
CATALINA_BASE=/opt/lucee/tomcat; export CATALINA_BASE
CATALINA_HOME=/opt/lucee/tomcat; export CATALINA_HOME
CATALINA_PID=/opt/lucee/tomcat/work/tomcat.pid; export CATALINA_PID
CATALINA_TMPDIR=/opt/lucee/tomcat/temp; export CATALINA_TMPDIR
JRE_HOME=/opt/lucee/jdk/jre; export JRE_HOME
JAVA_HOME=/opt/lucee/jdk; export JAVA_HOME
TOMCAT_OWNER=root; export TOMCAT_OWNER

# Start tomcat in the foreground
exec /opt/lucee/tomcat/bin/catalina.sh run