FROM ubuntu:18.04
MAINTAINER Jason Long

RUN apt-get -qq update
RUN apt-get install vim jq curl zsh git sudo -qq -y

RUN useradd -m -s /bin/zsh tester
RUN usermod -aG sudo tester
RUN echo "tester   ALL=(ALL:ALL) NOPASSWD: ALL" > /etc/sudoers

ADD . /home/tester/projects/i3wm
RUN chown -R tester:tester /home/tester

USER tester
ENV HOME /home/tester

WORKDIR /home/tester/projects/i3wm

RUN ./install.sh -v
RUN ./install.sh -ci

CMD ["/bin/bash"]
