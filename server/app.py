from flask import request
from flask import Flask

app = Flask(__name__)

@app.route('/')
def hello_world():
	hostname = request.headers.get('Host')
	return f'{str(hostname)}'


@app.route('/healthz')
def get_healthz():
	return 'Ok'

if __name__ == '__main__':
	app.run(port=5000)
