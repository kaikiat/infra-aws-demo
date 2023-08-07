cd $HOME
touch hello.txt
git clone git@github.com:kaikiat/infra-aws-demo.git
cd infra-aws-demo/server
python -m pip install -r requirements.txt
flask run