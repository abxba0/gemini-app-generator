# Architecture Documentation

## Overview

The Gemini App Generator is built as a containerized development environment that leverages Google's Gemini AI to generate complete applications from natural language prompts. The system follows a modular architecture with clear separation of concerns.

## System Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                     Host System                             │
│  ┌─────────────────────────────────────────────────────────┐ │
│  │                Docker Container                         │ │
│  │  ┌─────────────────┐  ┌──────────────────────────────┐  │ │
│  │  │   Setup Script  │  │       Core Scripts           │  │ │
│  │  │   (setup.sh)    │  │  • app-generator.sh          │  │ │
│  │  │                 │  │  • gemini-config.sh          │  │ │
│  │  └─────────────────┘  └──────────────────────────────┘  │ │
│  │           │                        │                    │ │
│  │           ▼                        ▼                    │ │
│  │  ┌─────────────────┐  ┌──────────────────────────────┐  │ │
│  │  │  Environment    │  │       Gemini AI API          │  │ │
│  │  │  Configuration  │◄─┤       Integration            │  │ │
│  │  │                 │  │                              │  │ │
│  │  └─────────────────┘  └──────────────────────────────┘  │ │
│  │                                  │                      │ │
│  │                                  ▼                      │ │
│  │  ┌─────────────────────────────────────────────────────┐  │ │
│  │  │            Application Generator                    │  │ │
│  │  │  • Prompt Processing                                │  │ │
│  │  │  • Framework Detection                              │  │ │
│  │  │  • Code Generation                                  │  │ │
│  │  │  • File Creation                                    │  │ │
│  │  │  • Dependency Installation                          │  │ │
│  │  └─────────────────────────────────────────────────────┘  │ │
│  │                                  │                      │ │
│  │                                  ▼                      │ │
│  │  ┌─────────────────────────────────────────────────────┐  │ │
│  │  │             Generated Projects                      │  │ │
│  │  │  /workspace/projects/                               │  │ │
│  │  │  ├── project-1/                                     │  │ │
│  │  │  ├── project-2/                                     │  │ │
│  │  │  └── project-n/                                     │  │ │
│  │  └─────────────────────────────────────────────────────┘  │ │
│  └─────────────────────────────────────────────────────────┘ │
└─────────────────────────────────────────────────────────────┘
```

## Core Components

### 1. Setup System (`setup.sh`)

**Purpose**: Automated environment setup and configuration

**Responsibilities**:
- Docker environment validation
- API key configuration
- Container orchestration
- Initial system verification

**Key Features**:
- Checks for Docker and Docker Compose installation
- Handles API key input and storage
- Creates necessary directory structure
- Builds and starts Docker containers
- Validates Gemini API connectivity

### 2. Application Generator (`scripts/app-generator.sh`)

**Purpose**: Main application generation orchestrator

**Key Functions**:
- `call_gemini()`: Handles API communication
- `generate_app()`: Main generation orchestrator  
- `create_files_from_response()`: Parses and creates generated files
- Framework-specific generators (e.g., `generate_react_app()`)

### 3. Gemini Configuration (`scripts/gemini-config.sh`)

**Purpose**: Gemini AI API setup and validation

**Responsibilities**:
- API key validation
- Configuration file creation
- Connection testing
- Error diagnostics

### 4. Docker Environment

**Base Image**: `node:18`

**Installed Tools**:
- System tools: git, curl, bash, python3, build-essential
- Node.js tools: React CLI, Vue CLI, Express generator
- Python packages: Flask, FastAPI, requests, pandas

**Port Mapping**:
- `3000`: React development server
- `4200`: Angular development server
- `8080`: General web server
- `5000`: Flask/Express alternative
- `3001`: Additional Node.js port
- `8000`: Python web servers

## Data Flow

### Application Generation Process

1. **User Input**: `app-generator.sh generate "prompt" [type] [name]`
2. **Command Parsing**: Parse arguments and validate parameters
3. **Prompt Processing**: Framework-specific template enhancement
4. **Gemini API Call**: Enhanced prompt to structured response
5. **Response Parsing**: Structured response to individual files
6. **File Generation**: Create project structure
7. **Post-Processing**: Install dependencies and create extras

## Framework-Specific Generation

### React Applications
- Creates complete React app with modern hooks
- Includes responsive design and error handling
- Automatic dependency installation
- Development environment setup

### Node.js Applications
- Express.js framework with security middleware
- Proper error handling and logging
- API routes and controllers
- Environment configuration

## Security Considerations

### API Key Management
- Environment variable storage
- No hardcoding in source code
- Secure transmission to containers
- Temporary file cleanup

### Container Security
- Minimal exposed ports
- Read-only mounts for configuration
- Regular base image updates

## Performance Considerations

### Caching
- Docker layer caching
- npm/pip package caching

### Resource Management
- Container resource limits
- Temporary file cleanup
- Memory usage optimization

## Future Enhancements

### Planned Improvements
1. **Plugin System**: Extensible framework support
2. **Template Engine**: Customizable generation templates
3. **Web Interface**: GUI for easier interaction
4. **Version Control**: Git integration for generated projects
5. **Testing Framework**: Automated testing of generated applications

This architecture provides a solid foundation for the Gemini App Generator while maintaining flexibility for future enhancements.