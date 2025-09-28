# API Documentation

## Overview

This document describes the command-line interface and internal API structure of the Gemini App Generator.

## Command Line Interface

### Main Command: `app-generator.sh`

The primary interface for generating applications.

#### Syntax
```bash
app-generator.sh <command> [arguments]
```

### Commands

#### `generate`
Generate a new application from a natural language prompt.

**Syntax:**
```bash
app-generator.sh generate "prompt" [type] [name]
```

**Parameters:**
- `prompt` (required): Natural language description of the application
- `type` (optional): Application framework type
- `name` (optional): Custom application name

**Supported Types:**
- `react` - React frontend application
- `node` - Node.js backend application
- `vue` - Vue.js frontend application
- `python` - Python application
- `fullstack` - Full-stack application
- `auto` - Auto-detect based on prompt (default)

**Examples:**
```bash
# Basic React app
app-generator.sh generate "Todo app with dark mode"

# Specific Node.js API
app-generator.sh generate "REST API for user management" node user-api

# Custom named Vue app
app-generator.sh generate "Dashboard with charts" vue analytics-dashboard
```

**Output:**
- Creates application in `/workspace/projects/{app-name}/`
- Installs dependencies automatically
- Provides run instructions

#### `list`
List all generated applications.

**Syntax:**
```bash
app-generator.sh list
```

**Output:**
```bash
📁 Generated applications:
total 12
drwxr-xr-x 3 root root 4096 Oct 15 10:30 todo-app
drwxr-xr-x 3 root root 4096 Oct 15 11:15 user-api
drwxr-xr-x 3 root root 4096 Oct 15 12:00 dashboard
```

#### `clean`
Remove all generated applications.

**Syntax:**
```bash
app-generator.sh clean
```

**Interactive Confirmation:**
```bash
🧹 Cleaning up generated applications...
Are you sure? This will delete all generated apps (y/N):
```

#### `help`
Display help information and examples.

**Syntax:**
```bash
app-generator.sh help
```

**Output:**
- Usage instructions
- Supported application types
- Example commands
- Tips for better results

## Internal API Functions

### Core Functions

#### `call_gemini(prompt)`
Interfaces with the Gemini AI API.

**Parameters:**
- `prompt`: Enhanced prompt string for code generation

**Returns:**
- Path to temporary file containing the API response

**Error Handling:**
- Validates API key presence
- Handles network timeouts
- Manages API rate limits
- Returns error codes for different failure modes

**Implementation:**
```bash
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
    
    # Node.js script execution for API call
    # ... (see source code for full implementation)
}
```

#### `generate_app(prompt, type, name)`
Main application generation orchestrator.

**Parameters:**
- `prompt`: User's natural language description
- `type`: Application framework type
- `name`: Application name

**Process:**
1. Creates project directory
2. Calls framework-specific generator
3. Handles dependencies and configuration
4. Provides completion feedback

#### `create_files_from_response(response_file)`
Parses Gemini API response and creates files.

**Parameters:**
- `response_file`: Path to file containing API response

**Process:**
1. Parses structured response format
2. Extracts individual files
3. Creates directory structure
4. Writes file contents

**Expected Response Format:**
```
=== package.json ===
{
  "name": "my-app",
  "version": "1.0.0",
  ...
}

=== src/App.js ===
import React from 'react';
...

=== src/index.js ===
import React from 'react';
import ReactDOM from 'react-dom';
...
```

### Framework-Specific Generators

#### `generate_react_app(prompt, name)`
Generates React applications.

**Enhanced Prompt Template:**
```javascript
Create a complete React application based on this request: '${prompt}'

Please generate the following files with complete, production-ready code:
1. package.json - Include all necessary dependencies
2. src/App.js - Main application component
3. src/index.js - Entry point
4. src/components/ - Reusable components
5. src/styles/ - CSS files

Requirements:
- Use modern React with hooks
- Include proper error handling
- Add responsive design
- Include comments explaining the code
- Make it fully functional, not just a template
```

**Post-Processing:**
- Creates `public/index.html` if missing
- Installs npm dependencies via `npm install`
- Sets up development environment

#### `generate_node_app(prompt, name)`
Generates Node.js applications.

**Enhanced Prompt Template:**
```javascript
Create a complete Node.js application based on this request: '${prompt}'

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
```

**Post-Processing:**
- Installs npm dependencies
- Creates environment configuration
- Sets up development scripts

#### `generate_vue_app(prompt, name)`
Generates Vue.js applications.

**Features:**
- Vue 3 with Composition API
- Modern development setup
- Component structure
- Responsive design

#### `generate_python_app(prompt, name)`
Generates Python applications.

**Features:**
- Flask or FastAPI framework
- Proper project structure
- Virtual environment setup
- Requirements management

#### `generate_fullstack_app(prompt, name)`
Generates full-stack applications.

**Features:**
- Frontend and backend integration
- API communication setup
- Database configuration
- Deployment considerations

### Utility Functions

#### `create_react_extras()`
Creates additional React application files.

**Purpose:**
- Ensures `public/index.html` exists
- Sets up basic HTML template
- Configures React mounting point

#### `extract_code_block(file, language)`
Extracts code blocks from markdown responses.

**Parameters:**
- `file`: Path to file containing markdown
- `language`: Programming language identifier

**Usage:**
```bash
# Extract JavaScript code block
js_code=$(extract_code_block "$response_file" "javascript")
```

## Environment Variables

### Required Variables

#### `GEMINI_API_KEY`
Your Google AI API key for accessing Gemini services.

**Setup Options:**
```bash
# Option 1: Export in shell
export GEMINI_API_KEY="your-api-key-here"

# Option 2: Add to .env file
echo "GEMINI_API_KEY=your-api-key-here" > .env

# Option 3: Set during setup
./setup.sh  # Will prompt for API key
```

### Optional Variables

#### `NODE_ENV`
Node.js environment setting.
- Default: `development`
- Options: `development`, `production`, `test`

#### `PYTHONPATH`
Python path configuration.
- Default: `/workspace`

## Error Codes

### Exit Codes

- `0` - Success
- `1` - General error
- `2` - Invalid arguments
- `3` - API key missing
- `4` - API call failed
- `5` - File creation failed

### Error Messages

#### API Key Errors
```bash
# Missing API key
"❌ GEMINI_API_KEY environment variable is not set!"

# Invalid API key
"❌ Gemini API test failed: Invalid API key"
```

#### Generation Errors
```bash
# Empty prompt
"❌ Please provide a prompt for your application"

# Network issues
"❌ Failed to connect to Gemini API"

# File creation issues
"❌ Failed to create project directory"
```

## Response Formats

### Successful Generation
```bash
🤖 Generating application based on your prompt...
📝 Prompt: Todo app with dark mode
🎯 Type: react
📁 Name: todo-app-with-dark-mo

🔧 Creating React application...
📦 Installing dependencies...
✅ React app created!
🚀 To run: cd /workspace/projects/todo-app-with-dark-mo && npm start
```

### Error Response
```bash
❌ Please provide a prompt for your application
💡 Usage: app-generator.sh generate "your app description" [app-type] [app-name]
```

## Configuration Files

### Gemini Configuration (`~/.config/gemini/config.json`)
```json
{
  "apiKey": "your-api-key-here",
  "model": "gemini-pro",
  "temperature": 0.7,
  "maxOutputTokens": 8192,
  "safetySettings": [
    {
      "category": "HARM_CATEGORY_HARASSMENT",
      "threshold": "BLOCK_MEDIUM_AND_ABOVE"
    }
  ]
}
```

### Environment File (`.env`)
```bash
GEMINI_API_KEY=your-api-key-here
NODE_ENV=development
PYTHONPATH=/workspace
```

## Integration Examples

### Custom Scripts
```bash
#!/bin/bash
# Custom generation script

# Generate multiple related apps
app-generator.sh generate "User authentication API" node auth-service
app-generator.sh generate "User dashboard frontend" react user-dashboard

# List all generated apps
app-generator.sh list
```

### CI/CD Integration
```yaml
# GitHub Actions example
- name: Generate Application
  run: |
    export GEMINI_API_KEY=${{ secrets.GEMINI_API_KEY }}
    ./setup.sh
    docker-compose exec -T gemini-dev app-generator.sh generate "Test application" react test-app
```

## Best Practices

### Prompt Writing
1. **Be Specific**: Include detailed feature requirements
2. **Mention Technologies**: Specify preferred libraries
3. **Include Constraints**: Mention design requirements
4. **Use Examples**: Reference similar applications

### Error Handling
1. **Check Exit Codes**: Always verify command success
2. **Validate Inputs**: Ensure prompts are not empty
3. **Handle API Limits**: Implement retry logic for rate limits
4. **Clean Up**: Remove temporary files on errors

### Performance
1. **Cache Dependencies**: Reuse Docker layers
2. **Batch Operations**: Generate multiple apps efficiently
3. **Monitor Resources**: Watch container memory usage
4. **Clean Regularly**: Remove unused generated apps

This API documentation provides comprehensive guidance for using and extending the Gemini App Generator system.