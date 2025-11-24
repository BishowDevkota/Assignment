# macOS Setup Guide for Stroke Prediction App

This guide will help you set up and run the Stroke Prediction App on your Mac machine.

## Prerequisites

Before starting, ensure you have the following installed on your Mac:

### 1. Install Homebrew (Package Manager)
Open Terminal and run:
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### 2. Install Python 3.9+
```bash
brew install python@3.11
# Verify installation
python3 --version
```

### 3. Install Node.js and npm
```bash
brew install node
# Verify installation
node --version
npm --version
```

### 4. Install Git
```bash
brew install git
# Verify installation
git --version
```

### 5. MongoDB Atlas Setup (Database)
1. Go to [MongoDB Atlas](https://cloud.mongodb.com/)
2. Create a free account
3. Create a new project
4. Create a free cluster (M0 tier)
5. Set up database access:
   - Go to "Database Access" in the left sidebar
   - Add a new database user
   - Choose "Password" authentication
   - Create a strong password and save it
6. Set up network access:
   - Go to "Network Access"
   - Add IP Address
   - Choose "Allow access from anywhere" (0.0.0.0/0) for development
7. Get connection string:
   - Go back to "Clusters"
   - Click "Connect" on your cluster
   - Choose "Connect your application"
   - Copy the connection string
   - Replace `<password>` with your database user password

## Project Setup

### 1. Clone the Repository
```bash
# Navigate to your desired directory
cd ~/Desktop

# Clone your repository (replace with your actual repository URL)
git clone <your-repository-url>
cd stroke_app
```

### Alternative: Automated Setup
```bash
# If you have the repository locally, you can run the automated setup script:
./setup_mac.sh
```

### 2. Backend Setup (Python)

#### Create Virtual Environment
```bash
# Navigate to backend directory
cd backend

# Create virtual environment
python3 -m venv venv

# Activate virtual environment
source venv/bin/activate
```

#### Install Dependencies
```bash
# Install required packages
pip install -r requirements.txt

# If you encounter any issues, install packages individually:
pip install flask flask-cors pandas scikit-learn numpy python-dotenv werkzeug bcrypt pymongo flask-login flask-wtf
```

**Note**: This project uses MongoDB Atlas (cloud database). You'll need to:
1. Create a free account at [MongoDB Atlas](https://cloud.mongodb.com/)
2. Create a new cluster
3. Get your connection string
4. Add your IP address to the whitelist

#### Environment Configuration
```bash
# Copy example environment file
cp .env.example .env

# Edit the .env file with your configuration
nano .env
```

**Required environment variables in `.env`:**
```env
# MongoDB Configuration
# Get your MongoDB Atlas connection string from https://cloud.mongodb.com/
# Format: mongodb+srv://<username>:<password>@<cluster>.mongodb.net/strokedb?retryWrites=true&w=majority
MONGO_URI=mongodb+srv://your-username:your-password@cluster0.xxxxx.mongodb.net/strokedb?retryWrites=true&w=majority

# Flask Secret Key
# Generate a secure random key using: python3 -c "import secrets; print(secrets.token_hex(32))"
SECRET_KEY=your-super-secret-key-change-this-in-production
```

### 3. Frontend Setup (React)

#### Open a new terminal window/tab for frontend
```bash
# Navigate to frontend directory
cd frontend

# Install dependencies
npm install
```

#### Start Development Server
```bash
# Start the frontend development server
npm start
```

The React app will start on `http://localhost:3000`

### 4. Running the Application

#### Start Backend (in backend terminal)
```bash
# Make sure you're in the backend directory with virtual environment activated
cd backend
source venv/bin/activate

# Run the Flask application
python app.py
```

The backend API will be available at `http://localhost:5000`

#### Access the Application
Open your web browser and go to `http://localhost:3000`

## Troubleshooting

### Common Issues on macOS

#### Python Path Issues
```bash
# If python3 command not found
brew install python@3.11

# If pip not found, try
python3 -m ensurepip --upgrade
```

#### Permission Issues
```bash
# If you get permission errors with pip
sudo pip install --upgrade pip
```

#### Node.js Issues
```bash
# If npm commands fail, try
sudo npm install -g npm@latest
```

#### Port Already in Use
```bash
# Check what's using port 5000
lsof -ti:5000

# Kill process using the port
kill -9 <PID>
```

### Development Tips

#### Environment Variables
Make sure your `.env` file in the backend directory contains all necessary variables. You can copy from `.env.example` and modify as needed.

**Important**: The project uses MongoDB Atlas (cloud database). You must:
1. Set up a MongoDB Atlas account and cluster
2. Configure your connection string in the `.env` file
3. Whitelist your IP address in MongoDB Atlas
4. Create database user credentials

#### Database
The application uses MongoDB Atlas (cloud database). No local database setup required.

#### Logs
Check terminal outputs for any error messages. Backend logs will appear in the backend terminal, frontend logs in the frontend terminal.

## Production Deployment (Optional)

For production deployment on macOS:

### Backend Production Setup
```bash
# Install production WSGI server
pip install gunicorn

# Run with gunicorn
gunicorn -w 4 -b 0.0.0.0:5000 app:app
```

### Frontend Production Build
```bash
# Build production version
npm run build

# Serve static files
npm install -g serve
serve -s build
```

## Project Structure Overview
```
stroke_app/
├── backend/          # Python Flask API
│   ├── app.py       # Main application file
│   ├── models/      # Database models
│   └── requirements.txt
├── frontend/         # React application
│   ├── src/         # Source code
│   └── public/      # Static files
├── setup_mac.sh     # Automated setup script for macOS
└── MAC_SETUP_GUIDE.md # Detailed setup instructions
```

## Next Steps

1. **Test the Application**: Visit `http://localhost:3000` and test all features
2. **Customize**: Modify configurations as needed for your use case
3. **Deploy**: Consider deploying to cloud platforms like Heroku, AWS, or Google Cloud

## Support

If you encounter any issues:
1. Check that all prerequisites are installed correctly
2. Verify environment variables are set
3. Ensure both backend and frontend are running
4. Check terminal error messages for specific issues