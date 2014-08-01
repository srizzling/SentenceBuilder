import os, yaml, requests
from bottle import route, run, template, request

with open('users.yml', 'r') as f:
	config = yaml.load(f)

@route('/receive', method='POST')
def receive():
	postdata = request.body.read()
	data_array = postdata.split(" ")
	with open("data.txt", "a") as f:
		for word in data_array:
			f.write(word + "\n")


@route('/send')
def send():
	data = ''
	if (os.path.isfile("data.txt")):
		with open("data.txt") as f:
			content = f.readlines()
			content = [word.strip() for word in content]
			data = ' '.join(content)
	return ''' 
	<h1> Sending Data To </h1>
		<form action="send" method="post">
			To: <input name="to" type="text"> </input>
			Data: <input name="data" type="text" value="{0}"> </input>
			 <input value="Submit" type="submit" />
		</form>
	'''.format(data)

@route('/send', method='POST')
def do_send():
	to = request.forms.get('to').lower()
	data = request.forms.get('data')
	endpoint = config["users"][to]
	requests.post(endpoint, data)
	return "Your Data has been sent"

@route('/hello')
def hello():
	return "Your Data has been sent"

@route('/clear')
def clear():
	if (os.path.isfile("data.txt")):
		os.remove("data.txt")
	return '''
	<p> Sentence Cleared </p>
	'''

run(host='0.0.0.0', port=8900, debug=True)