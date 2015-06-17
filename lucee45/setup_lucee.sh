#! /bin/sh

# Compile and generate the Lucee server and default web templates
tpage2 --envvars --compile_ext=.ttc --trim --include_path=/opt/lucee/config/includes \
	/opt/lucee/config/includes/lucee_web.xml > /opt/lucee/config/web/ROOT/lucee-web.xml.cfm

tpage2 --envvars --compile_ext=.ttc --trim --include_path=/opt/lucee/config/includes \
	/opt/lucee/config/includes/lucee_server.xml > /opt/lucee/lib/lucee-server/context/lucee-server.xml