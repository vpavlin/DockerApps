FROM fedora
MAINTAINER Vaclav Pavlin <vpavlin@redhat.com>

RUN yum -y update

#Inclusion of DNF directly to the image will fix this
RUN yum -y install dnf


RUN dnf -y install openssh-server
RUN dnf -y install xorg-x11-xauth pwgen dbus-x11
RUN dnf -y group install fonts
RUN dnf -y install wget
RUN dnf -y install e2fsprogs xfsprogs libXrender libtiff libpng libjpeg pulseaudio-libs gvfs libXi libgnome

RUN sshd-keygen

RUN mkdir /var/run/sshd

RUN sed -i 's#AuthorizedKeysFile.*#AuthorizedKeysFile /etc/ssh/keys/%u/authorized_keys#' /etc/ssh/sshd_config

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]

