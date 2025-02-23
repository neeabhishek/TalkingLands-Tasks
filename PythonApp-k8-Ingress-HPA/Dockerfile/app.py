#Using flask module to create a simple web application; also including a single route/context-path
from flask import Flask

app = Flask(__name__)

@app.route('/talking-lands-task')
def homePage():
    return "Hello, Talking Lands!"

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
