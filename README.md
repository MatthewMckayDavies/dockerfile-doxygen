# dockerfile-doxygen
Dockerfile for Doxygen with JRE and plantuml.jar.

* [Doxygen releases](https://github.com/doxygen/doxygen/releases)
* [PlantUML releases](https://github.com/plantuml/plantuml/releases)

# Build

```
docker build -t local/doxygen .
```

# Usage

In the Doxygen configuraiton file, set HAVE_DOT to YES and PLANTUML_JAR_PATH to /usr/local/bin.

```
docker run --rm -it -v ${PWD}:/home/workspace local/doxygen /bin/bash -c 'cd some_app/docs; doxygen some_app.doxyfile'
```