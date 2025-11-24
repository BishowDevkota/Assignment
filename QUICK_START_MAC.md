# Quick Start Guide for Mac

## Prerequisites Check
Before starting, ensure you have:
- macOS 10.15+ 
- Administrator access
- Internet connection

## 1-Minute Setup

### Option A: Automated Setup (Recommended)
```bash
# Clone repo and run setup script
git clone <your-repo-url> stroke_app
cd stroke_app
./setup_mac.sh
```

### Option B: Manual Setup
```bash
# Install dependencies
brew install python@3.11 node git

# Backend setup
cd backend
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
cp .env.example .env

# Frontend setup
cd ../frontend
npm install
```

## Required Configuration

### MongoDB Atlas Setup
1. Go to [MongoDB Atlas](https://cloud.mongodb.com/)
2. Create free account and cluster
3. Get connection string
4. Update `backend/.env` with your MongoDB URI

### Generate Secret Key
```bash
python3 -c "import secrets; print(secrets.token_hex(32))"
```
Add this to `SECRET_KEY` in `backend/.env`

## Run the Application

### Terminal 1 - Backend
```bash
cd backend
source venv/bin/activate
python app.py
```

### Terminal 2 - Frontend  
```bash
cd frontend
npm start
```

## Access
- Frontend: http://localhost:3000
- Backend API: http://localhost:5000

## Troubleshooting
- Check that MongoDB Atlas IP whitelist includes your IP
- Ensure .env file has correct MongoDB connection string
- Verify both backend and frontend are running

For detailed instructions, see [MAC_SETUP_GUIDE.md](./MAC_SETUP_GUIDE.md)