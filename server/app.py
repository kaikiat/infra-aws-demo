import socket
from flask import Flask

app = Flask(__name__)

@app.route('/')
def hello_world():
	instance_id = socket.gethostname()
	return f'Hi from instance : {instance_id}\n'

@app.route('/healthz')
def get_healthz():
	return 'Ok'

if __name__ == '__main__':
	app.run(port=5000)
