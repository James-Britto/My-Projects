from flask import Flask, render_template, request
import requests
import joblib
import numpy as np
app = Flask(__name__)
model = joblib.load(open('covidmodel.pickle','rb'))
@app.route('/',methods=['GET'])
def Home():
    return render_template('index.html')

@app.route("/predict", methods=['POST'])
def predict():
    if request.method == 'POST':
        Cough_symptoms = request.form['Cough_symptoms']
        Fever=request.form['Fever']
        Sore_throat=request.form['Sore_throat']
        Shortness_of_breath=request.form['Shortness_of_breath']
        Headache=request.form['Headache']
        Kc1=request.form['kc1']
        Kc2 = request.form['kc2']
        prediction=model.predict([[Cough_symptoms, Fever, Sore_throat, Shortness_of_breath, Headache, Kc1, Kc2]])
        if prediction[0]==0:
            return render_template('index.html',prediction_texts="Your Result is Negative")
        else:
            return render_template('index.html',prediction_text="Your Result is Positive")
    else:
        return render_template('index.html')

if __name__=="__main__":
    app.run(debug=True)

