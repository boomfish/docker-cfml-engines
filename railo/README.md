# Railo CFML engine

[Railo](http://www.getrailo.org/) CFML application engine running on [Apache Tomcat](https://tomcat.apache.org/) J2EE application server


## Features

### Tomcat with Native Library and Java Agent

A compatible version of the [Apache Tomcat Native Library](http://tomcat.apache.org/native-doc/) is installed for better Tomcat performance in production environments.

Railo's Java Agent for the JVM is enabled for [better memory management of compiled CFML code](http://blog.getrailo.com/post.cfm/railo-4-1-smarter-template-compilation).

### Support for single-site and multiple-site applications

The default configuration serves a single application for any hostname on the listening port. Multiple applications can be supported by editing the server.xml in the Tomcat config.

### baseimage-docker

This container uses [baseimage-docker](https://github.com/phusion/baseimage-docker) for their base image. This makes the image fairly large (600MB+) but provides a few benefits:

- It handles the [zombie reaping problem](https://blog.phusion.nl/2015/01/20/docker-and-the-pid-1-zombie-reaping-problem/) which can occur for applications that use `cfexecute`
- It responds better to `docker stop` by signalling Tomcat and giving it some time to shut down cleanly.
- You can use `cron` to schedule application cleanup tasks instead of the server's built-in task scheduler.

### Template generator

This container includes the Perl [Template Toolkit](http://www.template-toolkit.org/) and a custom version of the [tpage](http://www.template-toolkit.org/docs/tools/tpage.html) command-line tool that can read environment variables. This tool is useful for generating Railo configuration files from template files and environment variables either at build time (in a Dockerfile) or run time(in a startup script).


## Using this image

### Accessing the service

Tomcat listens on port 8888. This port is exposed to other containers. You must publish the port if you wish to browse to it from the Docker host.

### Accessing the Web admin

The Railo admin URL is `/railo-context/admin/` from the exposed port. The server password is 'docker'.

**THIS IS NOT A SECURE CONFIGURATION FOR PRODUCTION ENVIRONMENTS!** It is **strongly** recommended that you secure the container by:

- Changing the server password
- Using IP or URL filtering to restrict access to the Web admin
- Following recommended security practices such as the [Railo Lockdown Guide](https://github.com/getrailo/railo/wiki/Railo-Lockdown-Guide)

### Bundled application

The default site in the Railo image contains the welcome application bundled with the installer so you can test it. This bundled application however is deleted from any derived images via an `ONBUILD` instruction in the Dockerfile so you can ADD your own CFML application to the same location in your own Dockerfiles.

### Configuration and log folders

Folder locations:

- Tomcat config: /opt/railo/tomcat/conf
- Tomcat logs: /opt/railo/tomcat/logs
- Web root for default site: /opt/railo/tomcat/webapps/ROOT
- Railo config for default site: /opt/railo/config/web/ROOT
- Railo logs for default site: /opt/railo/config/web/ROOT/logs

Railo stores its application configurations under `WEB-INF` by default. However storing the configurations under the web root may cause problems in development environments, so for the default site these have been moved to folders outside the web root.

The location of the application config for the default site is set in `/opt/railo/tomcat/webapps/ROOT/WEB-INF/web.xml`. If you use your own web root make sure it includes a similar `WEB-INF/web.xml` file.

### Setting JVM parameters

You can set the JVM parameters for Tomcat via the `RAILO_JAVA_OPTS` environment variable.

For example, o run a Railo container with an initial heap of 1GB and a maximum heap of 1.5GB:

    sudo docker run -e RAILO_JAVA_OPTS="-Xms1024m -Xmx1536m -XX:MaxPermSize=128m" boomfish/railo-engine

The default value of `RAILO_JAVA_OPTS` is "-Xms256m -Xmx512m -XX:MaxPermSize=128m".