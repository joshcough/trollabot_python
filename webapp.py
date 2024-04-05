from flask import Flask, render_template

app = Flask(__name__)

@app.route('/')
def home():
    # Use render_template to serve the home.html template
    return render_template('home.html')

if __name__ == '__main__':
    app.run(debug=True)