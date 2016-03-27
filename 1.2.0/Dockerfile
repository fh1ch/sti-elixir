FROM openshift/base-centos7

# This image provides a Elixir environment you can use to run your Elixir
# applications.

MAINTAINER Fabio Huser <fabio@fh1.ch>

EXPOSE 8080

ENV ELIXIR_VERSION=1.2.0 \
    LC_ALL=en_US.UTF-8

LABEL io.k8s.description="Platform for building and running Elixir 1.2.0 applications" \
      io.k8s.display-name="Elixir 1.2.0" \
      io.openshift.expose-services="8080:http" \
      io.openshift.tags="builder,elixir,elixir120" \
      com.redhat.deployments-dir="/opt/app-root/src"

RUN wget http://packages.erlang-solutions.com/erlang-solutions-1.0-1.noarch.rpm && \
    rpm -Uvh erlang-solutions-1.0-1.noarch.rpm && \
    INSTALL_PKGS="erlang" && \
    yum install -y --setopt=tsflags=nodocs $INSTALL_PKGS && \
    rpm -V $INSTALL_PKGS && \
    yum clean all -y && \
    curl -fSL -o elixir-precompiled.zip https://github.com/elixir-lang/elixir/releases/download/v1.2.0/Precompiled.zip && \
    unzip -d /usr/local elixir-precompiled.zip && \
    rm elixir-precompiled.zip

# Copy the S2I scripts from the specific language image to $STI_SCRIPTS_PATH
COPY ./s2i/bin/ $STI_SCRIPTS_PATH

# Install additional modules
RUN mix local.hex --force && mix local.rebar --force

# Drop the root user and make the content of /opt/app-root owned by user 1001
RUN chown -R 1001:0 /opt/app-root
USER 1001

# Set the default CMD to print the usage of the language image
CMD $STI_SCRIPTS_PATH/usage
