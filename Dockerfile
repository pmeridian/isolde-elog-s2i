# isolde-elog-centos7
FROM openshift/base-centos7

# TODO: Put the maintainer name in the image metadata
MAINTAINER Liam Gaffney <liam.gaffney@cern.ch>

# TODO: Rename the builder environment variable to inform users about application you provide them
# ENV BUILDER_VERSION 1.0

# TODO: Set labels used in OpenShift to describe the builder image
LABEL io.k8s.description="Platform for building PSI elog for ISOLDE" \
      io.k8s.display-name="isolde-elog" \
      io.openshift.expose-services="8080:http,9090:https" \
      io.openshift.tags="builder,isolde-elog,elog"

# TODO: Install required packages here:
RUN yum install -y epel-release
RUN yum install -y emacs-nox && yum clean all -y
RUN yum install -y ghostscript && yum clean all -y
RUN yum install -y ImageMagick && yum clean all -y
RUN yum install -y openssl-devel && yum clean all -y
RUN yum install -y stunnel && yum clean all -y
#RUN yum -y --enablerepo=epel-testing install elog
RUN yum install -y ckeditor && yum clean all -y
RUN yum install -y elog-client && yum clean all -y
RUN rpm -ivh https://kojipkgs.fedoraproject.org//packages/elog/3.1.3/2.el7/x86_64/elog-3.1.3-2.el7.x86_64.rpm

# TODO (optional): Copy the builder files into /opt/app-root
#COPY ./elog-src /opt/app-root/

# TODO: Copy the S2I scripts to /usr/libexec/s2i, since openshift/base-centos7 image
# sets io.openshift.s2i.scripts-url label that way, or update that label
#COPY ./s2i/bin/ /usr/libexec/s2i

# TODO: Drop the root user and make the content of /opt/app-root owned by user 1001
RUN chown -R 1001:1001 /opt/app-root
RUN chown -R 1001:1001 /var/lib/elog
RUN HOME=/tmp

# Copy the stunnel.conf and stunnel.service files
COPY ./stunnel.conf /etc/stunnel/
COPY ./stunnel.service /etc/systemd/system/stunnel.service

# This default user is created in the openshift/base-centos7 image
USER 1001

# TODO: Set the default port for applications built using this image
EXPOSE 8080

# Copy the entry point startup command script
COPY ./entrypoint.sh /opt/app-root/entrypoint.sh

# TODO: Set the default ENTRYPOINT and CMD for the image
ENTRYPOINT ["/opt/app-root/entrypoint.sh"]
