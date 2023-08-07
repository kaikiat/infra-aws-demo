sudo apt-get update
sudo apt-get install -y git
sudo apt-get install -y python3-pip
sudo apt-get install -y gunicorn
sudo apt install -y python3-flask

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

sudo apt install -y nginx
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
sudo nginx -t
sudo systemctl reload nginx



# https://medium.com/techfront/step-by-step-visual-guide-on-deploying-a-flask-application-on-aws-ec2-8e3e8b82c4f7
# cat /var/log/cloud-init-output.log
# cat /var/log/cloud-init.log
