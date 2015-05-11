# Docker images for CFML application servers

This repository contains Dockerfiles to build CFML application servers.

The only CFML engine supported at the moment is [Railo](http://www.getrailo.org/). [Lucee](http://lucee.org/) support will be added shortly.

[Adobe ColdFusion](http://www.adobe.com/products/coldfusion) is unlikely to be supported from this repository due to licensing requirements.

## Features

### Tomcat with Native Library and Java Agent

A compatible version of the [Apache Tomcat Native Library](http://tomcat.apache.org/native-doc/) is installed for better Tomcat performance in production environments.

Railo's Java Agent for the JVM is enabled for [better memory management of compiled CFML code](http://blog.getrailo.com/post.cfm/railo-4-1-smarter-template-compilation).

### Support for single-site and multiple-site applications

The default configuration serves a single application for any hostname on the listening port. Multiple applications can be supported by editing the server.xml in the Tomcat config.

### baseimage-docker

These containers use [baseimage-docker](https://github.com/phusion/baseimage-docker) for their base image. This makes the images fairly large (600MB+) but provides a few benefits:

- It handles the [zombie reaping problem](https://blog.phusion.nl/2015/01/20/docker-and-the-pid-1-zombie-reaping-problem/) which can occur for applications that use `cfexecute`
- It responds better to `docker stop` by signalling Tomcat and giving it some time to shut down cleanly.
- You can use `cron` to schedule application cleanup tasks instead of the server's built-in task scheduler.

### Template generators

These containers include two template generators:

- A custom version of the [tpage](http://www.template-toolkit.org/docs/tools/tpage.html) command-line tool for the Perl [Template Toolkit](http://www.template-toolkit.org/).
- The [envtpl](https://github.com/andreasjansson/envtpl) command-line tool for the Python [Jinja2 template engine](http://jinja.pocoo.org/).

Both of these generators can read environment variables and feed them as variables into their respective templates. They are useful for generating Railo configuration files from template files either at build time (in a Dockerfile) or run time (in a startup script).


## Details on Docker images

[Railo CFML engine on Docker](railo/README.md)

## Prebuilt images on Docker Hub registry

Prebuilt Docker images are available on [Docker Hub](https://hub.docker.com/). These images are are created via [automated builds](https://docs.docker.com/docker-hub/builds/).

These images are not 'trusted' and are provided with no warranty. You may find these prebuilt images useful for trying out the containers, but for any serious work I recommend you fork the GitHub repository and use your fork to build your own images. Everything needed to build 

You can find the prebuilt images in the following repositories:

[Railo CFML engine](https://registry.hub.docker.com/u/boomfish/railo-engine/)

## License

The Docker files and config files are available under the [MIT License](LICENSE.txt). The CFML engines are available under their respective licenses.