# Start with Ubuntu 22.04 as a base image
FROM ubuntu:22.04

# Set Timezone (assuming CST to match the University of Missouri - sorry!)
ENV TZ=America/Chicago
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Set bash as the container's shell
SHELL ["/bin/bash", "-c"]

# Copy critical files into image
ADD ./provided/course_emacs /root/.emacs

# apt update
RUN apt update

# Install Python/PIP
RUN apt install -y python3-pip

# Install EMacs
RUN apt install -y emacs
RUN emacs -Q --batch --eval "(require 'package)" \
    --eval "(add-to-list 'package-archives '(\"melpa\" . \"https://melpa.org/packages/\") t)" \
    --eval "(package-refresh-contents)" \
    --eval "(package-install 'exec-path-from-shell)"

# Install NLTK
RUN pip install nltk
RUN python3 -m nltk.downloader all

# Install scikit-learn
RUN pip install scikit-learn

# Install LaTeX
RUN apt install -y texlive-full

# Install R (the programming language)
# Similar to https://linuxize.com/post/how-to-install-r-on-ubuntu-20-04/ but using newer repo for Ubuntu 22.04
RUN apt install -y apt-transport-https
RUN apt install -y ca-certificates
RUN apt install -y dirmngr
RUN apt install -y gnupg
RUN apt install -y software-properties-common
RUN apt install -y wget
RUN wget -qO- https://cloud.r-project.org/bin/linux/ubuntu/marutter_pubkey.asc | tee -a /etc/apt/trusted.gpg.d/cran_ubuntu_key.asc
RUN add-apt-repository -y 'deb https://cloud.r-project.org/bin/linux/ubuntu jammy-cran40/'
RUN apt install -y r-base
RUN apt install -y r-base-dev

# Install Extras (this is a collection of standard/popular packages - may or may not be useful/necessary in this context)
RUN apt install -y cmake
RUN apt install -y curl
RUN apt install -y ffmpeg
RUN apt install -y fonts-freefont-ttf
RUN apt install -y git
RUN apt install -y ifmetric
RUN apt install -y iproute2
RUN apt install -y iputils-ping
RUN apt install -y libqt5core5a
RUN apt install -y libqt5widgets5
RUN apt install -y man-db
RUN apt install -y mesa-utils
RUN apt install -y net-tools
RUN apt install -y qtbase5-dev
RUN apt install -y tcpdump
RUN apt install -y tmux
RUN apt install -y vim
RUN apt install -y x11-apps

# Open an interactive bash session when the container starts
WORKDIR /root
CMD ["bash"]
