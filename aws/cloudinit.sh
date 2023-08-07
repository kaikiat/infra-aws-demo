sudo apt-get update
sudo apt-get install git
git config --global user.name "kaikiat"
git config --global user.email "pohkaikiat98@gmail.com"

cd $HOME
touch hello.txt
git clone https://github.com/kaikiat/infra-aws-demo.git
cd infra-aws-demo/server
python3 -m pip install -r requirements.txt
flask run


# cat /var/log/cloud-init-output.log