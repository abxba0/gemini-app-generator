#!/bin/bash
# setup.sh - Automated setup script for Gemini App Generator

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}🚀 Gemini App Generator Setup${NC}"
echo "=================================="

# Check if Docker is installed
if ! command -v docker &> /dev/null; then
    echo -e "${RED}❌ Docker is not installed. Please install Docker first.${NC}"
    echo "Visit: https://docs.docker.com/get-docker/"
    exit 1
fi

# Check if Docker Compose is installed
if ! command -v docker-compose &> /dev/null; then
    echo -e "${RED}❌ Docker Compose is not installed. Please install Docker Compose first.${NC}"
    echo "Visit: https://docs.docker.com/compose/install/"
    exit 1
fi

echo -e "${GREEN}✅ Docker and Docker Compose are installed${NC}"

# Check if API key is provided
if [ -z "$GEMINI_API_KEY" ]; then
    echo -e "${YELLOW}⚠️  GEMINI_API_KEY not found in environment${NC}"
    echo -e "${BLUE}Please enter your Google AI API key:${NC}"
    read -r -s -p "API Key: " api_key
    echo
    
    if [ -z "$api_key" ]; then
        echo -e "${RED}❌ API key is required to continue${NC}"
        exit 1
    fi
    
    export GEMINI_API_KEY="$api_key"
    
    # Save to .env file for future use
    echo "GEMINI_API_KEY=$api_key" > .env
    echo -e "${GREEN}✅ API key saved to .env file${NC}"
fi

# Create necessary directories
echo -e "${BLUE}📁 Creating directories...${NC}"
mkdir -p workspace projects scripts

# Check if files exist
if [ ! -f "Dockerfile" ]; then
    echo -e "${RED}❌ Dockerfile not found. Please create all files first.${NC}"
    echo "Make sure you have:"
    echo "- Dockerfile"
    echo "- docker-compose.yml"
    echo "- scripts/gemini-config.sh"
    echo "- scripts/app-generator.sh"
    exit 1
fi

# Build the Docker image
echo -e "${BLUE}🔨 Building Docker image...${NC}"
if ! docker-compose build; then
    echo -e "${RED}❌ Docker build failed${NC}"
    exit 1
fi

echo -e "${GREEN}✅ Docker image built successfully${NC}"

# Start the container
echo -e "${BLUE}🚀 Starting container...${NC}"
if ! docker-compose up -d; then
    echo -e "${RED}❌ Failed to start container${NC}"
    exit 1
fi

# Wait for container to be ready
echo -e "${BLUE}⏳ Waiting for container to be ready...${NC}"
sleep 5

# Configure Gemini inside the container
echo -e "${BLUE}⚙️  Configuring Gemini...${NC}"
if docker-compose exec gemini-dev gemini-config.sh; then
    echo -e "${GREEN}🎉 Setup completed successfully!${NC}"
    echo ""
    echo -e "${YELLOW}Quick Start:${NC}"
    echo "1. Access the container: docker-compose exec gemini-dev bash"
    echo "2. Generate an app: app-generator.sh generate \"your app idea\""
    echo ""
    echo -e "${YELLOW}Examples:${NC}"
    echo "app-generator.sh generate \"Todo app with drag and drop\""
    echo "app-generator.sh generate \"Weather dashboard with charts\" react weather-app"
    echo "app-generator.sh generate \"REST API for blog posts\" node blog-api"
    echo ""
    echo -e "${BLUE}📖 Run 'app-generator.sh help' for more options${NC}"
else
    echo -e "${RED}❌ Gemini configuration failed${NC}"
    echo "Please check your API key and try again"
    exit 1
fi