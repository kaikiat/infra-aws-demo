sudo apt-get update
sudo apt-get install -y git
sudo apt-get install -y python3-pip
sudo apt-get install -y gunicorn
sudo apt install -y python3-flask
sudo apt install -y python3.10-venv

git config --global user.name "kaikiat"
git config --global user.email "pohkaikiat98@gmail.com"

cd $HOME
touch hello12.txt
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

# cat /var/log/cloud-init-output.log
# cat /var/log/cloud-init.log
