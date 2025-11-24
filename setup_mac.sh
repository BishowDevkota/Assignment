#!/bin/bash

# macOS Setup Script for Stroke Prediction App
# This script automates the setup process

echo "🚀 Starting Stroke Prediction App setup on macOS..."

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${GREEN}✓${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}⚠${NC} $1"
}

print_error() {
    echo -e "${RED}✗${NC} $1"
}

# Check if Homebrew is installed
if ! command -v brew &> /dev/null; then
    print_warning "Homebrew not found. Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    print_status "Homebrew installed"
else
    print_status "Homebrew is already installed"
fi

# Install Python 3.11
if ! brew list python@3.11 &> /dev/null; then
    print_warning "Installing Python 3.11..."
    brew install python@3.11
    print_status "Python 3.11 installed"
else
    print_status "Python 3.11 is already installed"
fi

# Install Node.js
if ! brew list node &> /dev/null; then
    print_warning "Installing Node.js..."
    brew install node
    print_status "Node.js installed"
else
    print_status "Node.js is already installed"
fi

# Install Git
if ! brew list git &> /dev/null; then
    print_warning "Installing Git..."
    brew install git
    print_status "Git installed"
else
    print_status "Git is already installed"
fi

# Navigate to backend directory
if [ ! -d "backend" ]; then
    print_error "Backend directory not found. Please run this script from the project root directory."
    exit 1
fi

cd backend

# Create virtual environment if it doesn't exist
if [ ! -d "venv" ]; then
    print_warning "Creating Python virtual environment..."
    python3 -m venv venv
    print_status "Virtual environment created"
else
    print_status "Virtual environment already exists"
fi

# Activate virtual environment
print_warning "Activating virtual environment..."
source venv/bin/activate

# Install Python dependencies
print_warning "Installing Python dependencies..."
pip install -r requirements.txt
print_status "Python dependencies installed"

# Copy environment file if it doesn't exist
if [ ! -f ".env" ]; then
    print_warning "Creating .env file from template..."
    cp .env.example .env
    print_status ".env file created. Please edit it with your MongoDB Atlas credentials."
else
    print_warning ".env file already exists. Please ensure your MongoDB Atlas credentials are configured."
fi

cd ..

# Navigate to frontend directory
if [ ! -d "frontend" ]; then
    print_error "Frontend directory not found. Please run this script from the project root directory."
    exit 1
fi

cd frontend

# Install Node.js dependencies
print_warning "Installing Node.js dependencies..."
npm install
print_status "Node.js dependencies installed"

echo ""
echo "🎉 Setup completed successfully!"
echo ""
echo "Next steps:"
echo "1. Set up your MongoDB Atlas account and cluster"
echo "2. Edit the backend/.env file with your MongoDB connection string"
echo "3. Generate a secure SECRET_KEY: python3 -c \"import secrets; print(secrets.token_hex(32))\""
echo "4. Start the backend: cd backend && source venv/bin/activate && python app.py"
echo "5. Start the frontend (in another terminal): cd frontend && npm start"
echo ""
echo "For detailed instructions, see MAC_SETUP_GUIDE.md"