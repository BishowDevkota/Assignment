# Installation and Setup Guide

## Stroke Patient Management System - Quick Start

This guide will help you set up and run the Stroke Patient Management System on your local machine.

---

## 📋 Prerequisites

Before you begin, ensure you have the following installed:

- **Python 3.8+** - [Download Python](https://www.python.org/downloads/)
- **Node.js 14+** - [Download Node.js](https://nodejs.org/)
- **MongoDB Atlas Account** - [Sign up for free](https://www.mongodb.com/cloud/atlas/register)
- **Git** - [Download Git](https://git-scm.com/downloads)

---

## 🚀 Step-by-Step Installation

### Step 1: Clone the Repository

```bash
# Clone from GitHub Classroom
git clone https://github.com/CS-LTU/com7033-assignment-XXXX.git
cd com7033-assignment-XXXX

# Or if already cloned, navigate to the project directory
cd stroke_app
```

---

### Step 2: Set Up MongoDB Atlas

1. **Create a MongoDB Atlas Account**
   - Go to [MongoDB Atlas](https://www.mongodb.com/cloud/atlas/register)
   - Sign up for a free account

2. **Create a New Cluster**
   - Click "Build a Database"
   - Choose "FREE" tier (M0 Sandbox)
   - Select a cloud provider and region (closest to you)
   - Click "Create Cluster"

3. **Configure Database Access**
   - Go to "Database Access" in the left sidebar
   - Click "Add New Database User"
   - Choose "Password" authentication
   - Create username and password (save these!)
   - Set privileges to "Read and write to any database"
   - Click "Add User"

4. **Configure Network Access**
   - Go to "Network Access" in the left sidebar
   - Click "Add IP Address"
   - Click "Allow Access from Anywhere" (for development)
   - Click "Confirm"

5. **Get Connection String**
   - Go to "Database" in the left sidebar
   - Click "Connect" on your cluster
   - Choose "Connect your application"
   - Copy the connection string (looks like):
     ```
     mongodb+srv://<username>:<password>@cluster0.xxxxx.mongodb.net/?retryWrites=true&w=majority
     ```
   - Replace `<username>` and `<password>` with your credentials

---

### Step 3: Backend Setup

```bash
# Navigate to backend directory
cd backend

# Create virtual environment
python3 -m venv venv

# Activate virtual environment
# On Linux/Mac:
source venv/bin/activate
# On Windows:
venv\Scripts\activate

# Install dependencies
pip install -r requirements.txt
```

---

### Step 4: Configure Environment Variables

Create a `.env` file in the `backend/` directory:

```bash
# In backend directory
touch .env
```

Add the following content to `.env`:

```env
# MongoDB Connection String
MONGO_URI=mongodb+srv://your-username:your-password@cluster0.xxxxx.mongodb.net/strokedb?retryWrites=true&w=majority

# Secret Key (generate a random string)
SECRET_KEY=your-super-secret-key-change-this-in-production
```

**Important**:
- Replace `your-username` and `your-password` with your MongoDB credentials
- Replace `cluster0.xxxxx` with your actual cluster address
- Generate a strong SECRET_KEY (you can use: `python3 -c "import secrets; print(secrets.token_hex(32))"`)

---

### Step 5: Load Initial Dataset (Optional)

```bash
# Make sure you're in the backend directory with venv activated
python3 load_data.py
```

This will load the healthcare stroke dataset into MongoDB. You should see:
```
Successfully loaded XXXX anonymized patient records.
```

---

### Step 6: Frontend Setup

Open a **new terminal** (keep backend terminal open):

```bash
# Navigate to frontend directory
cd frontend

# Install dependencies
npm install
```

---

### Step 7: Start the Application

#### Terminal 1 - Backend Server

```bash
# In backend directory with venv activated
python3 app.py
```

You should see:
```
 * Running on http://0.0.0.0:5000
 * Debug mode: on
```

#### Terminal 2 - Frontend Server

```bash
# In frontend directory
npm start
```

The application will automatically open in your browser at `http://localhost:3000`

---

## 🧪 Running Tests

### Backend Tests

```bash
# In backend directory with venv activated
pytest -v

# Run specific test file
pytest tests/test_auth.py -v
pytest tests/test_patients.py -v

# Run with coverage
pytest --cov=. --cov-report=html
```

### Frontend Tests

```bash
# In frontend directory
npm test

# Run with coverage
npm test -- --coverage
```

---

## 🎯 Using the Application

### 1. Register a New User

1. Open `http://localhost:3000` in your browser
2. Click "Register" tab
3. Enter a username (letters and numbers only)
4. Enter a password
5. Click "Register"

### 2. Login

1. Click "Login" tab
2. Enter your username and password
3. Click "Login"

### 3. Manage Patients

Once logged in, you can:
- **View all patients** - See paginated list of patient records
- **Add new patient** - Click "Add Patient" button
- **Edit patient** - Click edit icon on any patient row
- **Delete patient** - Click delete icon on any patient row
- **Search/Filter** - Use filter options to find specific patients
- **Sort** - Click column headers to sort data

---

## 🔧 Troubleshooting

### Issue: MongoDB Connection Error

**Error**: `pymongo.errors.ServerSelectionTimeoutError`

**Solutions**:
1. Check your MONGO_URI in `.env` file
2. Verify MongoDB Atlas IP whitelist includes your IP
3. Ensure username and password are correct
4. Check if cluster is active in MongoDB Atlas

### Issue: Port Already in Use

**Error**: `Address already in use` or `Port 5000/3000 is already in use`

**Solutions**:
```bash
# Kill process on port 5000 (backend)
# On Linux/Mac:
lsof -ti:5000 | xargs kill -9
# On Windows:
netstat -ano | findstr :5000
taskkill /PID <PID> /F

# Kill process on port 3000 (frontend)
# On Linux/Mac:
lsof -ti:3000 | xargs kill -9
# On Windows:
netstat -ano | findstr :3000
taskkill /PID <PID> /F
```

### Issue: Module Not Found

**Error**: `ModuleNotFoundError: No module named 'flask'`

**Solutions**:
1. Ensure virtual environment is activated
2. Run `pip install -r requirements.txt` again
3. Check you're in the correct directory

### Issue: CORS Error in Browser

**Error**: `Access to fetch at 'http://localhost:5000' from origin 'http://localhost:3000' has been blocked by CORS policy`

**Solutions**:
1. Ensure backend is running on port 5000
2. Check CORS configuration in `backend/app.py`
3. Clear browser cache and reload

### Issue: Tests Failing

**Error**: Tests not passing

**Solutions**:
1. Ensure MongoDB is accessible
2. Check `.env` file is configured correctly
3. Run `pytest -v` to see detailed error messages
4. Ensure all dependencies are installed

---

## 📁 Project Structure

```
stroke_app/
├── backend/                    # Flask backend
│   ├── app.py                 # Main application
│   ├── config.py              # Configuration
│   ├── utils.py               # Utilities
│   ├── load_data.py           # Dataset loader
│   ├── requirements.txt       # Python dependencies
│   ├── .env                   # Environment variables (create this)
│   ├── models/
│   │   ├── user.py           # User model
│   │   └── patient.py        # Patient model
│   └── tests/
│       ├── test_auth.py      # Auth tests
│       └── test_patients.py  # Patient tests
│
├── frontend/                   # React frontend
│   ├── package.json           # Node dependencies
│   ├── src/
│   │   ├── App.jsx           # Main component
│   │   ├── components/       # React components
│   │   └── pages/            # Page components
│   └── public/               # Static files
│
├── README.md                   # Project documentation
├── AI_USAGE_DISCLOSURE.md     # AI usage statement
└── ASSESSMENT_CHECKLIST.md    # Assessment requirements
```

---

## 🔒 Security Notes

1. **Never commit `.env` file** - It contains sensitive credentials
2. **Change SECRET_KEY** - Generate a new one for production
3. **MongoDB Security** - Use strong passwords and IP whitelisting
4. **HTTPS in Production** - Always use HTTPS for production deployment

---

## 📝 Environment Variables Reference

| Variable | Description | Example |
|----------|-------------|---------|
| `MONGO_URI` | MongoDB connection string | `mongodb+srv://user:pass@cluster.mongodb.net/strokedb` |
| `SECRET_KEY` | Flask secret key for sessions | `your-secret-key-here` |

---

## 🆘 Getting Help

If you encounter issues:

1. **Check the logs** - Look at terminal output for error messages
2. **Review documentation** - Check README.md for detailed information
3. **Verify setup** - Ensure all steps were followed correctly
4. **Check MongoDB Atlas** - Verify cluster is running and accessible
5. **Test connectivity** - Try connecting to MongoDB using MongoDB Compass

---

## ✅ Verification Checklist

Before submitting, verify:

- [ ] Backend starts without errors
- [ ] Frontend starts and opens in browser
- [ ] Can register a new user
- [ ] Can login with registered user
- [ ] Can view patient list
- [ ] Can add new patient
- [ ] Can edit existing patient
- [ ] Can delete patient
- [ ] Tests pass (`pytest -v`)
- [ ] No errors in browser console
- [ ] MongoDB connection works
- [ ] All dependencies installed

---

## 🎓 Assessment Submission

1. **Push to GitHub**:
   ```bash
   git add .
   git commit -m "Final submission"
   git push origin main
   ```

2. **Verify on GitHub**:
   - Check all files are uploaded
   - Verify .env is NOT committed
   - Review commit history

3. **Submit on Moodle**:
   - Upload as required by assessment brief
   - Include GitHub repository link

---

**Good luck with your assessment!** 🚀

For detailed API documentation and advanced features, see [`README.md`](README.md).
