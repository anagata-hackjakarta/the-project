from flask import Flask, jsonify, request, redirect
from flask_cors import CORS
import os
import vertexai
import json
import mysql.connector
import requests
from datetime import datetime, timedelta
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
USER = os.getenv("USER", "default_user")
PASSWORD = os.getenv("PASSWORD", "default_password")
HOST = os.getenv("HOST", "default_host")
DATABASE = os.getenv("DATABASE", "default_database")
PORT = os.getenv("PORT", "default_port")

mandatory_vars = {
    "PROJECT_ID": PROJECT_ID,
    "LOCATION": LOCATION,
    "MODEL_NAME": MODEL_NAME,
    "GOOGLE_APPLICATION_CREDENTIALS": GOOGLE_APPLICATION_CREDENTIALS,
    "USER": USER,
    "PASSWORD": PASSWORD,
    "HOST": HOST,
    "DATABASE": DATABASE,
    "PORT": PORT
}

for var_name, var_value in mandatory_vars.items():
    if var_value == f"default_{var_name.lower()}":
        raise ValueError(f"Environment variable {var_name} must be set")
    
if GOOGLE_APPLICATION_CREDENTIALS:
    os.environ['GOOGLE_APPLICATION_CREDENTIALS'] = GOOGLE_APPLICATION_CREDENTIALS
    logging.info("Using google application credentials")
else:
    logging.info("Using application default credentials")

# Database configuration
db_config = {
    'user': USER,
    'password': PASSWORD,
    'host': HOST,
    'database': DATABASE,
    'port': PORT,
}

def get_db_connection():
    return mysql.connector.connect(**db_config)

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

def calculate_driver_score(uuid, trip_date):
    conn = mysql.connector.connect(**db_config)
    cursor = conn.cursor(dictionary=True)

    # Fetch trip data
    cursor.execute("""
        SELECT id, startTime, endTime, totalDistance, totalTime
        FROM trips
        WHERE uuid = %s AND DATE(startTime) = %s
        AND totalTime IS NOT NULL
    """, (uuid, trip_date))
    trips = cursor.fetchall()

    # Initialize score components
    speed_score = 0
    acceleration_score = 0
    braking_score = 0
    cornering_score = 0
    lane_discipline_score = 0
    tailgating_score = 0
    turn_signal_usage_score = 0

    for trip in trips:
        trip_id = trip['id']

        incident_details = []

        # Fetch sensor data for the trip
        cursor.execute("""
            SELECT currentSpeed, accelX, accelY, accelZ, decelerationCount, avgDeceleration, laneChangeCount, leftTurnCount, rightTurnCount, alerts
            FROM sensorData
            WHERE tripId = %s
        """, (trip_id,))
        sensor_data = cursor.fetchall()

        for data in sensor_data:
            # Speeding (Negative points for exceeding the speed limit)
            speed_limit = 80  # Example speed limit
            if data['currentSpeed'] > speed_limit:
                speed_score -= (data['currentSpeed'] - speed_limit)

            # Acceleration (Negative points for rapid acceleration)
            rapid_accel_threshold = 2.5  # Example threshold
            if data['accelX'] > rapid_accel_threshold or data['accelY'] > rapid_accel_threshold or data['accelZ'] > rapid_accel_threshold:
                acceleration_score -= max(data['accelX'], data['accelY'], data['accelZ'])

            # Braking (Negative points for hard braking)
            hard_brake_threshold = -2.5  # Example threshold
            if data['avgDeceleration'] < hard_brake_threshold:
                braking_score -= abs(data['avgDeceleration'])

            # Cornering (Negative points for sharp turns)
            sharp_turn_threshold = 2.0  # Example threshold for gyroscope data
            if abs(data['gyroRoll']) > sharp_turn_threshold or abs(data['gyroPitch']) > sharp_turn_threshold or abs(data['gyroYaw']) > sharp_turn_threshold:
                cornering_score -= max(abs(data['gyroRoll']), abs(data['gyroPitch']), abs(data['gyroYaw']))

            # Lane Discipline (Negative points for frequent lane changes)
            lane_discipline_score -= data['laneChangeCount']

            # Tailgating (This would typically require proximity sensors, assumed here for illustration)
            tailgating_threshold = 2.0  # Example threshold (not directly available from provided data)
            # Assuming alerts JSON contains tailgating incidents
            alerts = json.loads(data['alerts'])
            tailgating_incidents = alerts.get('tailgating', 0)
            tailgating_score -= tailgating_incidents

            # Turn Signal Usage (Assumed from alerts or sensor data)
            # Positive points for using turn signals properly, negative for not using
            turn_signal_usage_score += data['leftTurnCount'] + data['rightTurnCount']

    # Normalize scores and apply weights
    total_score = (
        (speed_score * 0.25) +
        (acceleration_score * 0.15) +
        (braking_score * 0.15) +
        (cornering_score * 0.15) +
        (lane_discipline_score * 0.10) +
        (tailgating_score * 0.10) +
        (turn_signal_usage_score * 0.10)
    )

    # Ensure the score is within 0 to 100 range
    total_score = max(0, min(100, total_score))

    cursor.close()
    conn.close()

    return {
        'date': trip_date,
        'daily_score': total_score,
        'speeding_score': speed_score,
        'acceleration_score': acceleration_score,
        'braking_score': braking_score,
        'cornering_score': cornering_score,
        'lane_discipline_score': lane_discipline_score,
        'tailgating_score': tailgating_score,
        'turn_signal_usage_score': turn_signal_usage_score
    }

def get_daily_average_score(trip_date):
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)

    # Fetch daily average score for all users
    cursor.execute("""
        SELECT AVG(daily_score) as average_score
        FROM scores
        WHERE DATE(date) = %s
    """, (trip_date,))
    average_score = cursor.fetchone()
    
    cursor.close()
    conn.close()

    return average_score['average_score']

@app.route('/')
def index():
    return "Hello World!"

@app.route('/v1/daily-behavior', methods=['GET'])
def daily_behavior():
    uuid = request.args.get('uuid')
    date = request.args.get('date', datetime.today().strftime('%Y-%m-%d'))  # Default to today if not provided

    daily_score = calculate_driver_score(uuid, date)
    # ai_analysis = forward_to_ai_api(uuid, date, basic_scores, incident_details)
    average_score = get_daily_average_score(date)

    summary = {
        'date': date,
        'summary': "Your braking was hard and sudden. Brake more smoothly."
    }

    response = {
        'daily_score': daily_score,
        'incidents': incident_details,
        'summary': summary,
        'average_score': average_score
    }

    return json.dumps(response), 200

@app.route('/v1/weekly-behavior', methods=['GET'])
def weekly_behavior():
    pass

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
    