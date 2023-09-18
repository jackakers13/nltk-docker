# This will install and configure Docker for Fedora Linux 38 Workstation.
# If you are running a different operating system, see here: https://docs.docker.com/engine/install/

# THIS IS THE ONLY LINE THAT ACTUALLY MATTERS
sudo dnf install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# The rest of this just removes the need to use `sudo` for a lot of operations. Nice to have.
sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker
sudo systemctl restart docker

echo "Installation complete! It is HIGHLY recommend that you restart your computer right now to make sure that everything takes effect!"
