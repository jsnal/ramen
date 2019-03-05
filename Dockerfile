FROM ubuntu:18.04
MAINTAINER Jason Long

RUN apt-get -qq update
RUN apt-get install vim jq curl zsh git sudo -qq -y
RUN apt-get install python3-pip -y -qq

RUN useradd -m -s /bin/zsh tester
RUN usermod -aG sudo tester
RUN echo "tester   ALL=(ALL:ALL) NOPASSWD: ALL" > /etc/sudoers

ADD . /home/tester/i3wm
RUN chown -R tester:tester /home/tester

USER tester
ENV HOME /home/tester

WORKDIR /home/tester/i3wm

RUN git submodule init && git submodule update
RUN ./install.sh --profile 1

CMD ["/bin/bash"]
