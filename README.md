# Docker containers for CFML application servers

This repository contains Dockerfiles to build CFML application servers.

CFML engines supported: Railo. Lucee support will be added shortly.

Adobe ColdFusion is unlikely to be supported from this repository due to licensing requirements.


## Features

### Tomcat with Native Library and Java Agent

The CFML engines run on Apache Tomcat with a compatible version of the Tomcat Native Library installed for better performance in production environments.

For Railo, the Java Agent is enabled which allows it to better manage the memory heap used for storing compiled CFML code.

### Support for single-site and multiple-site applications

The default configuration serves a single application for any hostname on the listening port. Multiple applications can be supported by editing the server.xml in the Tomcat config.

### baseimage-docker

These containers use [baseimage-docker](https://github.com/phusion/baseimage-docker) for the base image. This makes the images fairly large (600MB+) but it handles the [zombie reaping problem](https://blog.phusion.nl/2015/01/20/docker-and-the-pid-1-zombie-reaping-problem/) which can occur for applications that use `cfexecute`. It also means you can use `cron` to schedule application cleanup tasks instead of the server's built-in task scheduler.

### Template generator

These containers include the Perl Text Template Toolkit and a custom version of `tpage` that 

## Using this image

### Accessing the service

The containers run their respective engine on Tomcat and listen on port 8888. This port is exposed to other containers. You must publish the port if you wish to browse to it from the Docker host.

### Accessing the Web admin

The Railo admin is accessible from port 8888 on `/railo-context/admin/`. The server password is 'docker'.

It is **strongly** recommended that you _limit access to the Web admin_ and _change the server password_ when running containers based on this image in production environments.

### Bundled application

The default site in the Railo image contains the welcome application bundled with the installer so you can test it. This bundled application however is deleted from any derived images via an `ONBUILD` instruction in the Dockerfile so you can ADD your own CFML application to the same location in your own Dockerfiles.

### Application config

Railo and Lucee store their application configurations under `WEB-INF` by default. However storing the configurations under the web root causes problems in development environments, so for the default site these have been moved to folders outside the web root.

The location of the application config for the default site is set in the `WEB-INF/web.xml` included in the application. If you use your own web root make sure it includes a similar `WEB-INF/web.xml` file.

### Application folders

The application folders used by the container vary by application engine.

For Railo:

- Tomcat config: /opt/railo/tomcat/conf
- Tomcat logs: /opt/railo/tomcat/logs
- Web root for default site: /opt/railo/tomcat/webapps/ROOT
- Railo config for default site: /opt/railo/config/web/ROOT
- Railo logs for default site: /opt/railo/config/web/ROOT/logs
