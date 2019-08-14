FROM python:3
MAINTAINER Jason Long

RUN apt-get -qq update
RUN apt-get install vim jq curl zsh git sudo -qq -y
RUN apt-get install python3-pip -y -qq

RUN useradd -m -s /bin/zsh jenkins
RUN usermod -aG sudo jenkins
RUN echo "jenkins   ALL=(ALL:ALL) NOPASSWD: ALL" > /etc/sudoers

ADD . /home/jenkins/i3wm
RUN chown -R jenkins:jenkins /home/jenkins

USER jenkins
ENV HOME /home/jenkins

WORKDIR /home/jenkins/i3wm

CMD ["/bin/bash"]
