from flask import Flask, jsonify, request, redirect
from flask_cors import CORS
import os
import vertexai
import json
from uuid import uuid4
from dotenv import load_dotenv
import os
import vertexai
import base64
import logging
from vertexai.generative_models import GenerativeModel, Part, FinishReason
import vertexai.preview.generative_models as generative_models
from vertexai.generative_models import (
    GenerationConfig,
    GenerativeModel,
    HarmBlockThreshold,
    HarmCategory,
    Part,
)


# Set environment variables to suppress TensorFlow and gRPC logs
os.environ['TF_CPP_MIN_LOG_LEVEL'] = '3'  # Suppress TensorFlow logs
os.environ['GRPC_VERBOSITY'] = 'ERROR'    # Suppress gRPC logs
os.environ['ABSL_LOG_LEVEL'] = '3'        # Suppress Abseil logs

# Initialize logging early
logging.basicConfig(level=logging.INFO, format='%(asctime)s %(levelname)s:%(message)s')

# Suppress Abseil and gRPC logs specifically
logging.getLogger('absl').setLevel(logging.ERROR)
logging.getLogger('grpc').setLevel(logging.ERROR)

app = Flask(__name__)
CORS(app)

load_dotenv()

PROJECT_ID = os.getenv("PROJECT_ID", "default_project_id")
LOCATION = os.getenv("LOCATION", "default_location")
MODEL_NAME = os.getenv("MODEL_NAME", "default_model_name")
GOOGLE_APPLICATION_CREDENTIALS = os.getenv("GOOGLE_APPLICATION_CREDENTIALS", "default_model_name")

mandatory_vars = {
    "PROJECT_ID": PROJECT_ID,
    "LOCATION": LOCATION,
    "MODEL_NAME": MODEL_NAME,
}

for var_name, var_value in mandatory_vars.items():
    if var_value == f"default_{var_name.lower()}":
        raise ValueError(f"Environment variable {var_name} must be set")
    
if GOOGLE_APPLICATION_CREDENTIALS:
    os.environ['GOOGLE_APPLICATION_CREDENTIALS'] = GOOGLE_APPLICATION_CREDENTIALS
    logging.info("Using google application credentials")
else:
    logging.info("Using application default credentials")

def get_prompt():
    with open('prompt.txt', 'r') as file:
        prompt = file.read()

    return prompt

text1 = get_prompt()

def generate(data):
    vertexai.init(project=PROJECT_ID, location=LOCATION)
    model = GenerativeModel(
        MODEL_NAME,
    )

    generation_config = {
        "max_output_tokens": 8192,
        "temperature": 0,
        "top_p": 0.95,
    }

    safety_settings = {
        generative_models.HarmCategory.HARM_CATEGORY_HATE_SPEECH: generative_models.HarmBlockThreshold.BLOCK_MEDIUM_AND_ABOVE,
        generative_models.HarmCategory.HARM_CATEGORY_DANGEROUS_CONTENT: generative_models.HarmBlockThreshold.BLOCK_MEDIUM_AND_ABOVE,
        generative_models.HarmCategory.HARM_CATEGORY_SEXUALLY_EXPLICIT: generative_models.HarmBlockThreshold.BLOCK_MEDIUM_AND_ABOVE,
        generative_models.HarmCategory.HARM_CATEGORY_HARASSMENT: generative_models.HarmBlockThreshold.BLOCK_MEDIUM_AND_ABOVE,
    }

    responses = model.generate_content(
        [text1, str(data)],
        generation_config=generation_config,
        safety_settings=safety_settings,
        stream=False,
    )

    try:
        text = responses.candidates[0].content.parts[0].text
    except Exception as e:
        print(responses)
        print(e)

    try:
        json_string = text.split("`json\n")[1].split("\n`")[0]
        json_string = json_string.replace("'", '"')
        data = json.loads(json_string)
    except (IndexError, json.JSONDecodeError) as e:
        print("Error parsing JSON:", e)
        raise
    
    return data

@app.route('/v1/analyze', methods=['POST'])
def analyze():
    try:
        driving_data = request.get_json()

        try:
            feedback = generate(driving_data)
            return json.dumps(feedback), 200
        except Exception as e:
            logging.error("Error processing data: %s", str(e))
            return json.dumps({"message": "Internal server error. Please try again later."}), 500
    
    except Exception as e:
        logging.error("Invalid data format: %s", str(e))
        return json.dumps({"message": "Invalid data format."}), 400

if __name__ == "__main__":
    app.run(debug=True, host="0.0.0.0", port=8080)
    