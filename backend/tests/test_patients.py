import pytest
from app import app
from models.patient import Patient, patients_collection
from models.user import MongoUser, users_collection
from pymongo import MongoClient
from config import Config
import json

@pytest.fixture
def client():
    app.config['TESTING'] = True
    app.config['WTF_CSRF_ENABLED'] = False
    with app.test_client() as client:
        # Create test user for auth
        test_user = MongoUser.create({"username": "test", "password": "test"})
        # Login (set cookie manually for test)
        with client.session_transaction():
            client.set_cookie('session', 'logged_in')
        yield client
    # Cleanup
    mongo_client = MongoClient(Config.MONGO_URI)
    mongo_client['strokedb']['patients'].delete_many({})
    mongo_client['strokedb']['users'].delete_many({})

@pytest.fixture(autouse=True)
def clear_db():
    """Clear patients before each test."""
    patients_collection.delete_many({})

def test_create_patient(client):
    """Test create patient."""
    data = {
        "gender": "Male", "age": 50, "hypertension": 0, "ever_married": "Yes",
        "work_type": "Private", "Residence_type": "Urban", "avg_glucose_level": 100.5,
        "bmi": 25.0, "smoking_status": "Never smoked", "stroke": 0
    }
    rv = client.post('/api/patients', json=data)
    assert rv.status_code == 201
    assert "id" in rv.json

def test_read_all_patients(client):
    """Test read all."""
    # Create one
    client.post('/api/patients', json={"gender": "Female", "age": 45, "hypertension": 1, "ever_married": "No",
                                       "work_type": "Govt_job", "Residence_type": "Rural", "avg_glucose_level": 90.0,
                                       "bmi": 22.0, "smoking_status": "Unknown", "stroke": 1})
    rv = client.get('/api/patients')
    assert rv.status_code == 200
    assert len(rv.json) == 1

def test_update_patient(client):
    """Test update."""
    # Create
    create_rv = client.post('/api/patients', json={"gender": "Male", "age": 50, "hypertension": 0, "ever_married": "Yes",
                                                   "work_type": "Private", "Residence_type": "Urban", "avg_glucose_level": 100.5,
                                                   "bmi": 25.0, "smoking_status": "Never smoked", "stroke": 0})
    pid = create_rv.json["id"]
    # Update
    update_data = {"age": 51}
    rv = client.put(f'/api/patients/{pid}', json=update_data)
    assert rv.status_code == 200
    assert rv.json["modified"] == 1

def test_delete_patient(client):
    """Test delete."""
    # Create
    create_rv = client.post('/api/patients', json={"gender": "Male", "age": 50, "hypertension": 0, "ever_married": "Yes",
                                                   "work_type": "Private", "Residence_type": "Urban", "avg_glucose_level": 100.5,
                                                   "bmi": 25.0, "smoking_status": "Never smoked", "stroke": 0})
    pid = create_rv.json["id"]
    # Delete
    rv = client.delete(f'/api/patients/{pid}')
    assert rv.status_code == 200
    # Verify gone
    get_rv = client.get(f'/api/patients/{pid}')
    assert get_rv.status_code == 404