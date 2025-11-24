#!/bin/bash

# Verification script to check if the Stroke Prediction App is properly set up

echo "🔍 Checking Stroke Prediction App setup..."

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print status
print_ok() {
    echo -e "${GREEN}✓${NC} $1"
}

print_fail() {
    echo -e "${RED}✗${NC} $1"
}

print_warn() {
    echo -e "${YELLOW}⚠${NC} $1"
}

# Check if we're in the right directory
if [ ! -d "backend" ] || [ ! -d "frontend" ]; then
    print_fail "Please run this script from the project root directory"
    exit 1
fi

echo ""
echo "=== Prerequisites Check ==="

# Check Python
if command -v python3 &> /dev/null; then
    PYTHON_VERSION=$(python3 --version)
    print_ok "Python: $PYTHON_VERSION"
else
    print_fail "Python 3 is not installed"
fi

# Check Node.js
if command -v node &> /dev/null; then
    NODE_VERSION=$(node --version)
    print_ok "Node.js: $NODE_VERSION"
else
    print_fail "Node.js is not installed"
fi

# Check npm
if command -v npm &> /dev/null; then
    NPM_VERSION=$(npm --version)
    print_ok "npm: $NPM_VERSION"
else
    print_fail "npm is not installed"
fi

# Check Git
if command -v git &> /dev/null; then
    GIT_VERSION=$(git --version)
    print_ok "Git: $GIT_VERSION"
else
    print_fail "Git is not installed"
fi

echo ""
echo "=== Backend Check ==="

# Check virtual environment
if [ -d "backend/venv" ]; then
    print_ok "Python virtual environment exists"
    
    # Check if packages are installed
    cd backend
    if source venv/bin/activate && python -c "import flask" &> /dev/null; then
        print_ok "Flask is installed"
    else
        print_fail "Flask is not installed. Run: source venv/bin/activate && pip install -r requirements.txt"
    fi
    
    if source venv/bin/activate && python -c "import pymongo" &> /dev/null; then
        print_ok "PyMongo is installed"
    else
        print_fail "PyMongo is not installed. Run: source venv/bin/activate && pip install -r requirements.txt"
    fi
    
    cd ..
else
    print_fail "Python virtual environment not found. Run: cd backend && python3 -m venv venv"
fi

# Check environment file
if [ -f "backend/.env" ]; then
    print_ok "Environment file (.env) exists"
    
    # Check if it has the required variables
    if grep -q "MONGO_URI=mongodb" backend/.env && ! grep -q "your-username:your-password" backend/.env; then
        print_ok "MongoDB URI is configured"
    else
        print_warn "MongoDB URI may not be properly configured"
    fi
    
    if grep -q "SECRET_KEY=" backend/.env && ! grep -q "your-super-secret-key" backend/.env; then
        print_ok "SECRET_KEY is configured"
    else
        print_warn "SECRET_KEY may not be properly configured"
    fi
else
    print_fail "Environment file (.env) not found. Run: cd backend && cp .env.example .env"
fi

echo ""
echo "=== Frontend Check ==="

# Check Node modules
if [ -d "frontend/node_modules" ]; then
    print_ok "Node modules are installed"
else
    print_fail "Node modules not found. Run: cd frontend && npm install"
fi

# Check if React can start (without actually starting it)
cd frontend
if npm list react react-dom &> /dev/null; then
    print_ok "React dependencies are properly installed"
else
    print_fail "React dependencies may be missing. Run: npm install"
fi
cd ..

echo ""
echo "=== Network Check ==="

# Check if common ports are available
if ! lsof -ti:3000 &> /dev/null; then
    print_ok "Port 3000 is available (for frontend)"
else
    print_warn "Port 3000 is already in use"
fi

if ! lsof -ti:5000 &> /dev/null; then
    print_ok "Port 5000 is available (for backend)"
else
    print_warn "Port 5000 is already in use"
fi

echo ""
echo "=== Summary ==="
echo "If all checks pass, you can start the application:"
echo "1. Backend: cd backend && source venv/bin/activate && python app.py"
echo "2. Frontend: cd frontend && npm start"
echo "3. Visit: http://localhost:3000"
echo ""
echo "For detailed setup instructions, see MAC_SETUP_GUIDE.md"