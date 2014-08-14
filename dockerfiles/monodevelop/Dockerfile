FROM vpavlin/gui-base
MAINTAINER Vaclav Pavlin <vpavlin@redhat.com>

RUN dnf -y install monodevelop gtk-sharp2-devel

ADD ssh/authorized_keys /etc/ssh/keys/root/authorized_keys
RUN chown root:root /etc/ssh/keys/root/authorized_keys
