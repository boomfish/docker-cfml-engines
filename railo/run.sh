#!/bin/sh

# switch the subshell to the tomcat directory so that any relative
# paths specified in any configs are interpreted from this directory.
cd /opt/railo/tomcat/

# Railo settings
CATALINA_BASE=/opt/railo/tomcat; export CATALINA_BASE
CATALINA_HOME=/opt/railo/tomcat; export CATALINA_HOME
CATALINA_PID=/opt/railo/tomcat/work/tomcat.pid; export CATALINA_PID
CATALINA_TMPDIR=/opt/railo/tomcat/temp; export CATALINA_TMPDIR
JRE_HOME=/opt/railo/jdk/jre; export JRE_HOME
JAVA_HOME=/opt/railo/jdk; export JAVA_HOME
TOMCAT_OWNER=root; export TOMCAT_OWNER

# Start tomcat in the foreground
exec /opt/railo/tomcat/bin/catalina.sh run