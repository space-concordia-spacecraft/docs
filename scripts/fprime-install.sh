#!/bin/bash

# Install prerequisites
echo
echo Installing dependencies ...
echo
sudo apt update
sudo apt -y install build-essential cmake python3 python3-pip python3-venv git-all

# Create repository folder
echo
echo Where should the fprime repository be cloned? Specify a valid directory.
echo
read -r fprime_dir
mkdir -p "$fprime_dir"

# Go to specified directory
cd "$fprime_dir"
fprime_dir=$PWD

# Clone nasa/fprime repo into folder
echo
echo Cloning fprime repository ...
echo
git clone https://github.com/nasa/fprime "$fprime_dir"
cd "$fprime_dir/.." || exit

# Create and launch python virtual environment
echo 
echo Launching Python3 virtual environment ...
echo 
python3 -m venv ./fprime-venv
source ./fprime-venv/bin/activate

# Install fprime python packages
echo 
echo Installing fprime python packages ... 
echo 
cd "$fprime_dir" || exit
pip install --upgrade wheel setuptools pip
pip install ./Fw/Python
pip install ./Gds

# Build fprime
echo 
echo Building fprime application ... 
echo 
cd Ref || exit
fprime-util generate
fprime-util build --jobs 32

# Run HTML GUI
echo 
echo Starting HTML GUI ... 
echo 
fprime-gds -g html -r ./build-artifacts
