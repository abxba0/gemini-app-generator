#!/bin/bash
# app-generator.sh - Main application generator script

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to call Gemini API
call_gemini() {
    local prompt="$1"
    local temp_file
    
    # Validate input
    if [[ -z "$prompt" ]]; then
        echo "Error: Empty prompt provided" >&2
        return 1
    fi
    
    temp_file=$(mktemp) || return 1
    trap 'rm -f "$temp_file"' EXIT
    
    cat > /tmp/gemini-call.js << 'EOF'
const { GoogleGenerativeAI } = require("@google/generative-ai");

async function generateContent() {
    const genAI = new GoogleGenerativeAI(process.env.GEMINI_API_KEY);
    const model = genAI.getGenerativeModel({ 
        model: "gemini-pro",
        generationConfig: {
            temperature: 0.3,
            maxOutputTokens: 8192,
        }
    });
    
    const prompt = process.argv[2] || '';
    if (!prompt.trim()) {
        console.error("Error: No prompt provided");
        process.exit(1);
    }
    
    try {
        const result = await model.generateContent(prompt);
        const response = await result.response;
        console.log(response.text());
    } catch (error) {
        console.error("Error:", error.message);
        process.exit(1);
    }
}

generateContent();
EOF
    
    if ! node /tmp/gemini-call.js "$prompt" > "$temp_file" 2>/dev/null; then
        echo "Error: Failed to call Gemini API" >&2
        rm -f "$temp_file"
        return 1
    fi
    echo "$temp_file"
}

# Function to extract code blocks from Gemini response
extract_code() {
    local file="$1"
    local language="$2"
    
    # Extract code between ```language and ``` markers
    sed -n "/\`\`\`$language/,/\`\`\`/p" "$file" | sed '1d;$d'
}

generate_app() {
    local prompt="$1"
    local app_type="$2"
    local app_name="$3"
    
    echo -e "${BLUE}🤖 Generating application based on your prompt...${NC}"
    echo -e "${YELLOW}Prompt: $prompt${NC}"
    echo -e "${YELLOW}Type: $app_type${NC}"
    echo -e "${YELLOW}Name: $app_name${NC}"
    
    # Create project directory
    mkdir -p "/workspace/projects/$app_name"
    cd "/workspace/projects/$app_name" || exit 1
    
    # Generate application based on type
    case $app_type in
        "react")
            generate_react_app "$prompt" "$app_name"
            ;;
        "node")
            generate_node_app "$prompt" "$app_name"
            ;;
        "vue")
            generate_vue_app "$prompt" "$app_name"
            ;;
        "python")
            generate_python_app "$prompt" "$app_name"
            ;;
        "fullstack")
            generate_fullstack_app "$prompt" "$app_name"
            ;;
        *)
            echo -e "${BLUE}Auto-detecting application type...${NC}"
            auto_generate_app "$prompt" "$app_name"
            ;;
    esac
    
    echo -e "${GREEN}✅ Application generated successfully!${NC}"
    echo -e "${BLUE}📁 Location: /workspace/projects/$app_name${NC}"
}

generate_react_app() {
    local prompt="$1"
    local app_name="$2"
    
    echo -e "${BLUE}🔧 Creating React application...${NC}"
    
    # Gemini prompt for React app
    local gemini_prompt="Create a complete React application based on this request: '$prompt'

Please generate the following files with complete, production-ready code:

1. package.json - Include all necessary dependencies
2. App.js - Main application component with full functionality
3. App.css - Complete styling for the application
4. index.js - React entry point
5. Any additional components needed

Requirements:
- Use modern React hooks (useState, useEffect, etc.)
- Include proper error handling
- Add responsive design
- Include comments explaining the code
- Make it fully functional, not just a template

Format your response with clear file separations using:
=== filename.ext ===
[file content]

Start with package.json first."
    
    # Call Gemini API
    local response_file
    response_file=$(call_gemini "$gemini_prompt")
    
    # Parse and create files
    create_files_from_response "$response_file"
    
    # Install dependencies
    if [ -f "package.json" ]; then
        echo -e "${BLUE}📦 Installing dependencies...${NC}"
        npm install
    fi
    
    # Create additional necessary files
    create_react_extras
    
    echo -e "${GREEN}✅ React app created!${NC}"
    echo -e "${BLUE}🚀 To run: cd /workspace/projects/$app_name && npm start${NC}"
}

generate_node_app() {
    local prompt="$1"
    local app_name="$2"
    
    echo -e "${BLUE}🔧 Creating Node.js application...${NC}"
    
    local gemini_prompt="Create a complete Node.js application based on this request: '$prompt'

Please generate the following files with complete, production-ready code:

1. package.json - Include all necessary dependencies (express, cors, helmet, etc.)
2. server.js or app.js - Main server file with full functionality
3. routes/ files - API routes and controllers
4. models/ files - Data models (if needed)
5. middleware/ files - Custom middleware (if needed)
6. .env.example - Environment variables template
7. README.md - Setup and usage instructions

Requirements:
- Use Express.js framework
- Include proper error handling and logging
- Add security middleware (helmet, cors)
- Include input validation
- Add proper HTTP status codes
- Include comments explaining the code

Format your response with clear file separations using:
=== filename.ext ===
[file content]

Start with package.json first."
    
    local response_file
    response_file=$(call_gemini "$gemini_prompt")
    create_files_from_response "$response_file"
    
    if [ -f "package.json" ]; then
        echo -e "${BLUE}📦 Installing dependencies...${NC}"
        npm install
    fi
    
    echo -e "${GREEN}✅ Node.js app created!${NC}"
    echo -e "${BLUE}🚀 To run: cd /workspace/projects/$app_name && npm start${NC}"
}

generate_python_app() {
    local prompt="$1"
    local app_name="$2"
    
    echo -e "${BLUE}🔧 Creating Python application...${NC}"
    
    local gemini_prompt="Create a complete Python application based on this request: '$prompt'

Please generate the following files with complete, production-ready code:

1. requirements.txt - All necessary Python packages
2. app.py or main.py - Main application file
3. Additional .py files for modules/classes
4. config.py - Configuration settings
5. README.md - Setup and usage instructions

Requirements:
- Use appropriate frameworks (Flask for web apps, etc.)
- Include proper error handling
- Add type hints where appropriate
- Include docstrings for functions/classes
- Follow PEP 8 style guidelines
- Make it fully functional

Format your response with clear file separations using:
=== filename.ext ===
[file content]

Start with requirements.txt first."
    
    local response_file
    response_file=$(call_gemini "$gemini_prompt")
    create_files_from_response "$response_file"
    
    if [ -f "requirements.txt" ]; then
        echo -e "${BLUE}📦 Installing Python dependencies...${NC}"
        pip3 install -r requirements.txt
    fi
    
    echo -e "${GREEN}✅ Python app created!${NC}"
    echo -e "${BLUE}🚀 To run: cd /workspace/projects/$app_name && python3 app.py${NC}"
}

auto_generate_app() {
    local prompt="$1"
    local app_name="$2"
    
    echo -e "${BLUE}🤖 Auto-detecting best technology stack...${NC}"
    
    local analysis_prompt="Analyze this application request and determine the best technology stack: '$prompt'

Consider:
- Frontend vs Backend vs Full-stack requirements
- Complexity level
- Best practices for this type of application
- Performance requirements

Respond with ONLY one word from these options:
- react (for frontend/UI applications)
- node (for backend/API applications)
- python (for data processing/CLI tools)
- fullstack (for complete web applications)

Just the technology name, nothing else."
    
    local tech_file
    tech_file=$(call_gemini "$analysis_prompt")
    local tech
    tech=$(tr -d '\n' < "$tech_file" | tr -d ' ' | tr '[:upper:]' '[:lower:]')
    
    echo -e "${YELLOW}🎯 Selected technology: $tech${NC}"
    
    case $tech in
        *react*)
            generate_react_app "$prompt" "$app_name"
            ;;
        *node*)
            generate_node_app "$prompt" "$app_name"
            ;;
        *python*)
            generate_python_app "$prompt" "$app_name"
            ;;
        *fullstack*)
            generate_fullstack_app "$prompt" "$app_name"
            ;;
        *)
            echo -e "${YELLOW}⚠️  Couldn't auto-detect, defaulting to React...${NC}"
            generate_react_app "$prompt" "$app_name"
            ;;
    esac
}

create_files_from_response() {
    local response_file="$1"
    local current_file=""
    local in_file=false
    
    while IFS= read -r line; do
        if [[ $line =~ ^===\ (.+)\ ===$ ]]; then
            if [ "$in_file" = true ] && [ -n "$current_file" ]; then
                echo -e "${GREEN}Created: $current_file${NC}"
            fi
            current_file="${BASH_REMATCH[1]}"
            in_file=true
            # Create directory if needed
            mkdir -p "$(dirname "$current_file")"
            # Clear the file
            true > "$current_file"
        elif [ "$in_file" = true ]; then
            echo "$line" >> "$current_file"
        fi
    done < "$response_file"
    
    if [ "$in_file" = true ] && [ -n "$current_file" ]; then
        echo -e "${GREEN}Created: $current_file${NC}"
    fi
}

create_react_extras() {
    # Create public/index.html if it doesn't exist
    if [ ! -f "public/index.html" ]; then
        mkdir -p public
        cat > public/index.html << 'EOF'
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Generated React App</title>
</head>
<body>
    <div id="root"></div>
</body>
</html>
EOF
    fi
}

# Main command handler
case "$1" in
    "generate")
        if [ -z "$2" ]; then
            echo -e "${RED}❌ Please provide a prompt for your application${NC}"
            echo -e "${YELLOW}Usage: app-generator.sh generate \"your app description\" [app-type] [app-name]${NC}"
            exit 1
        fi
        
        prompt="$2"
        app_type="${3:-auto}"
        # Safely generate app name, ensuring no command injection
        app_name="${4:-$(printf '%s' "$prompt" | sed 's/[^a-zA-Z0-9]/-/g' | tr '[:upper:]' '[:lower:]' | cut -c1-20)}"
        
        # Remove trailing hyphens
        app_name=${app_name%-}
        
        generate_app "$prompt" "$app_type" "$app_name"
        ;;
    "list")
        echo -e "${BLUE}📁 Generated applications:${NC}"
        if [ -d "/workspace/projects" ]; then
            ls -la /workspace/projects/
        else
            echo "No applications generated yet"
        fi
        ;;
    "clean")
        echo -e "${YELLOW}🧹 Cleaning up generated applications...${NC}"
        read -p "Are you sure? This will delete all generated apps (y/N): " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            # Safer deletion with explicit path validation
            if [[ -d "/workspace/projects" ]]; then
                find /workspace/projects -mindepth 1 -maxdepth 1 -type d -exec rm -rf {} \;
                echo -e "${GREEN}✅ Cleaned up successfully!${NC}"
            else
                echo -e "${YELLOW}⚠️  Projects directory not found${NC}"
            fi
        fi
        ;;
    "help"|*)
        echo -e "${BLUE}🤖 Gemini App Generator${NC}"
        echo ""
        echo -e "${YELLOW}Usage:${NC}"
        echo "  app-generator.sh generate \"prompt\" [type] [name]"
        echo "  app-generator.sh list"
        echo "  app-generator.sh clean"
        echo "  app-generator.sh help"
        echo ""
        echo -e "${YELLOW}Types:${NC}"
        echo "  react     - React frontend application"
        echo "  node      - Node.js backend application"
        echo "  python    - Python application"
        echo "  vue       - Vue.js frontend application"
        echo "  fullstack - Full-stack application"
        echo "  auto      - Auto-detect (default)"
        echo ""
        echo -e "${YELLOW}Examples:${NC}"
        echo "  app-generator.sh generate \"Todo app with drag and drop\""
        echo "  app-generator.sh generate \"REST API for blog\" node blog-api"
        echo "  app-generator.sh generate \"Data visualization dashboard\" react dashboard"
        echo ""
        echo -e "${YELLOW}Tips:${NC}"
        echo "  - Be specific about features you want"
        echo "  - Mention UI/UX preferences"
        echo "  - Specify any particular libraries you prefer"
        ;;
esac