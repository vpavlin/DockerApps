FROM vpavlin/gui-base
MAINTAINER Vaclav Pavlin <vpavlin@redhat.com>

RUN dnf -y install gedit

ADD ssh/authorized_keys /etc/ssh/keys/root/authorized_keys
RUN chown root:root /etc/ssh/keys/root/authorized_keys
