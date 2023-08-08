#!/bin/bash

touch code_deploy.txt
git config --global user.name "kaikiat"
git config --global user.email "pohkaikiat98@gmail.com"

cd /home/ubuntu
cd infra-aws-demo
git pull
cd server
python3 -m pip install -r requirements.txt

sudo systemctl reload server
sudo systemctl reload nginx