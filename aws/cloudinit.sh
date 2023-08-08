#!/bin/bash
echo "Hello World"
sudo apt-get -y update
touch hello12.txt
sudo apt-get install -qq -y python3-pip python3-flask nginx wget

git config --global user.name "kaikiat"
git config --global user.email "pohkaikiat98@gmail.com"

cd /home/ubuntu
git clone https://github.com/kaikiat/infra-aws-demo.git
cd infra-aws-demo/server
python3 -m pip install -r requirements.txt

cat << EOF | sudo tee /etc/systemd/system/server.service
[Unit]
Description=Gunicorn instance for a simple hello world app
After=network.target

[Service]
User=ubuntu
Group=www-data
WorkingDirectory=/home/ubuntu/infra-aws-demo/server
ExecStart=flask run
Restart=always

[Install]
WantedBy=multi-user.target
EOF

sudo systemctl daemon-reload
sudo systemctl start server
sudo systemctl enable server

sudo systemctl start nginx
sudo systemctl enable nginx

cat << EOF | sudo tee /etc/nginx/sites-available/default
server {
    listen 80;
    server_name localhost;

    location / {
        proxy_pass http://localhost:5000;
    }
}
EOF
# Not required
# sudo ln -s /etc/nginx/sites-available/default /etc/nginx/sites-enabled/
# For fun
# /var/log/cloud-init-output.log
############## sudo nginx -t
sudo systemctl reload nginx

cd /home/ubuntu
wget https://aws-codedeploy-ap-southeast-1.s3.ap-southeast-1.amazonaws.com/latest/install
chmod +x ./install
sudo ./install auto > /tmp/logfile
sudo service codedeploy-agent start