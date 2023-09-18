script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

launch_command="
sudo systemctl start docker && \
xhost +SI:localuser:root && \
docker run \
-it \
--rm \
--net=host \
--ipc=host \
-e DISPLAY=$DISPLAY \
--mount type=bind,source=\"${script_dir}\",target=/root/nltk-docker \
nltk-docker"
echo ""
echo "Launching with the following command: ${launch_command}"
echo ""
eval ${launch_command}
