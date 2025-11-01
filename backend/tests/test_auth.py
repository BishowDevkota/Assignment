import pytest
from app import app
from models.user import MongoUser, users_collection
from pymongo import MongoClient
from config import Config

@pytest.fixture
def client():
    app.config['TESTING'] = True
    app.config['WTF_CSRF_ENABLED'] = False  # Disable CSRF for tests
    with app.test_client() as client:
        yield client
    # Cleanup after each test
    mongo_client = MongoClient(Config.MONGO_URI)
    mongo_client['strokedb']['users'].delete_many({})

def test_register(client):
    """Test user registration."""
    data = {"username": "testuser", "password": "testpass123"}
    rv = client.post('/api/auth/register', json=data)
    assert rv.status_code == 201
    assert "registered" in rv.json["message"]

def test_login_success(client):
    """Test successful login."""
    # Register first
    client.post('/api/auth/register', json={"username": "loginuser", "password": "testpass123"})
    rv = client.post('/api/auth/login', json={"username": "loginuser", "password": "testpass123"})
    assert rv.status_code == 200

def test_login_fail(client):
    """Test failed login."""
    rv = client.post('/api/auth/login', json={"username": "nonexistent", "password": "wrong"})
    assert rv.status_code == 401