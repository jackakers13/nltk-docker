# Docker Environment for Emacs Org Mode and the Natural Language Toolkit (NLTK) 3
This is intended for use with Dr. Toni Kazic's CMP_SC-7740 "Interdisciplinary Introduction to Natural Language Processing (NLP)" course, as taught Fall 2023 at the University of Missouri.

This is a reproducable environment with pre-configured Emacs, LaTeX, NLTK (including ALL of its data/corpora), R, and other packages that are useful/required for this course. **While I am using this for my own work and believe it to be correctly configured, I could have easily missed something. Consider this to be provided as-is!**

The included scripts are designed primarily for use with Fedora Linux 38 Workstation (because that's what I use), but it should work with minimal modifications on other systems so long as you can get Docker Engine and an X11 server running on your host machine. **I am open to improving compatibility for other systems (particularly Windows) if there is sufficient interest.**

Docker: https://docs.docker.com/get-started/ (If you are unfamiliar with Docker, this is worth a quick read to understand what's going on.)

Emacs Org Mode: https://orgmode.org/

LaTeX: https://www.latex-project.org/

Natural Language Toolkit (version 3): https://www.nltk.org/

R: https://www.r-project.org/

# Installation/Usage Instructions
1) Install Docker Engine: https://docs.docker.com/engine/install/
    - If you happen to be running Fedora Linux 38 Workstation or similar, then you can do this automatically by running the included `./install-docker.sh` script.
2) Build the nltk-docker image by running `./docker-build.sh`
    - This will take a while. On a high-end PC with a fast internet connection, it took me around 15 minutes.
3) Run the nltk-docker image (creating a "container") by running `./docker-run.sh`
    - This will ask for your password, as it needs root permissions to run `sudo systemctl start docker` to make sure that Docker Engine is running. You can safely remove that line if you've already started the engine.
    - This repositoy will be mounted at `/root/nltk-docker` inside of the container. Any files that you create/edit in here will be reflected on your host machine. All other files are ephemeral and will be reset every time your restart

# Notes
- In general, the largest complication for getting this running on any machine is going to be making sure that the container is able to run GUI applications (Emacs). If you are willing to operate exclusively in the command line, you can avoid setting up an X11 server and remove a LOT of the bloat in `./docker-run.sh`.
- The included `./docker-run.sh` will run `xhost +SI:localuser:root`. This has some [security implications](https://unix.stackexchange.com/a/359244/586035), and there might be some [better solutions](https://github.com/mviereck/x11docker), but, given the generally insecure nature of other things I'm doing (such as running the container with `--net=host` and `--ipc=host`), I didn't think it was worth the trouble to investigate further.
