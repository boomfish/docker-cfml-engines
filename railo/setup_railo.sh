#! /bin/sh

# Compile and generate the Railo server and default web templates
tpage2 --envvars --compile_ext=.ttc --trim --include_path=/opt/railo/config/includes \
	/opt/railo/config/includes/railo_web.xml > /opt/railo/config/web/ROOT/railo-web.xml.cfm

tpage2 --envvars --compile_ext=.ttc --trim --include_path=/opt/railo/config/includes \
	/opt/railo/config/includes/railo_server.xml > /opt/railo/lib/railo-server/context/railo-server.xml