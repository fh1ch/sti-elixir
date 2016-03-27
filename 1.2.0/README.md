Elixir Docker image
===================

This repository contains the source for building various versions of
the Elixir application as a reproducible Docker image using
[source-to-image](https://github.com/openshift/source-to-image).
Users can choose between RHEL and CentOS based builder images.
The resulting image can be run using [Docker](http://docker.io).


Usage
---------------------
To build a simple [elixir-sample-app](https://github.com/fh1ch/sti-elixir/tree/master/1.2.0/test/test_app) application
using standalone [STI](https://github.com/openshift/source-to-image) and then run the
resulting image with [Docker](http://docker.io) execute:

*  **For RHEL based image**
    ```
    $ s2i build https://github.com/fh1ch/sti-elixir.git --context-dir=1.2.0/test/test_app/ openshift/elixir-120-rhel7 elixir-sample-app
    $ docker run -p 8080:8080 elixir-sample-app
    ```

*  **For CentOS based image**
    ```
    $ s2i build https://github.com/fh1ch/sti-elixir.git --context-dir=1.2.0/test/test_app/ openshift/elixir-120-centos7 elixir-sample-app
    $ docker run -p 8080:8080 elixir-sample-app
    ```

**Accessing the application:**
```
$ curl 127.0.0.1:8080
```


Repository organization
------------------------
* **`<elixir-version>`**

    * **Dockerfile**

        CentOS based Dockerfile.

    * **Dockerfile.rhel7**

        RHEL based Dockerfile. In order to perform build or test actions on this
        Dockerfile you need to run the action on a properly subscribed RHEL machine.

    * **`s2i/bin/`**

        This folder contains scripts that are run by [STI](https://github.com/openshift/source-to-image):

        *   **assemble**

            Used to install the sources into the location where the application
            will be run and prepare the application for deployment (eg. installing
            modules using npm, etc.)

        *   **run**

            This script is responsible for running the application, by using the
            application web server.

        *   **usage***

            This script prints the usage of this image.

    * **`test/`**

        This folder contains the [S2I](https://github.com/openshift/source-to-image)
        test framework with simple Elixir echo server.

        * **`test-app/`**

            A simple Elixir time server used for testing purposes by the [S2I](https://github.com/openshift/source-to-image) test framework.

        * **run**

            This script runs the [S2I](https://github.com/openshift/source-to-image) test framework.
