
#!/bin/bash

set -euxo pipefail
echo "################################"
echo "##### WSL Develop Environment Setup"
echo "################################"

# Install CUDA ToolKit & cuDNN
if ! which /usr/local/cuda/bin/nvcc >/dev/null 2>&1; then

  wget https://developer.download.nvidia.com/compute/cuda/repos/wsl-ubuntu/x86_64/cuda-keyring_1.1-1_all.deb
  sudo dpkg -i cuda-keyring_1.1-1_all.deb
  sudo apt-get update
  sudo apt-get -y install cuda-toolkit-12-4
  rm -rf cuda-keyring_1.1-1_all.deb

  wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/cuda-keyring_1.1-1_all.deb
  sudo dpkg -i cuda-keyring_1.1-1_all.deb
  sudo apt-get update
  sudo apt-get -y install cudnn
  sudo apt-get -y install cudnn-cuda-12
  rm -rf cuda-keyring_1.1-1_all.deb
fi

echo "################################"
echo "##### Done WSL Develop Environment Setup"
echo "################################"
