from flask import Flask

app = Flask(__name__)

@app.route('/')
def hello_world():
	return 'Hello World'


@app.route('/healthz')
def get_healthz():
	return 'Ok'

if __name__ == '__main__':
	app.run(port=5000)
