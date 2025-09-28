# 🤖 Gemini App Generator

A powerful, AI-driven application generator that leverages Google's Gemini AI to create complete, production-ready applications from natural language prompts. Generate React frontends, Node.js backends, Python applications, and more with just a simple description of what you want to build.

## ✨ Features

- **AI-Powered Generation**: Uses Google Gemini AI to generate complete applications from natural language descriptions
- **Multiple Frameworks**: Supports React, Node.js, Vue.js, Python, and full-stack applications
- **Docker Environment**: Fully containerized development environment with all necessary tools pre-installed
- **Production-Ready Code**: Generates complete applications with proper error handling, security, and best practices
- **Automatic Dependencies**: Installs all required dependencies and sets up the project structure
- **Interactive Interface**: Easy-to-use command-line interface with helpful prompts and examples

## 🚀 Quick Start

### Prerequisites

- [Docker](https://docs.docker.com/get-docker/)
- [Docker Compose](https://docs.docker.com/compose/install/)
- [Google AI API Key](https://makersuite.google.com/app/apikey) (for Gemini AI)

### Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/abxba0/gemini-app-generator.git
   cd gemini-app-generator
   ```

2. **Run the automated setup:**
   ```bash
   ./setup.sh
   ```
   
   The setup script will:
   - Verify Docker installation
   - Prompt for your Gemini API key
   - Build the Docker container
   - Configure the Gemini AI integration
   - Set up the development environment

3. **Access the container:**
   ```bash
   docker-compose exec gemini-dev bash
   ```

## 📖 Usage

### Basic Command Structure

```bash
app-generator.sh generate "your app description" [type] [name]
```

- **prompt**: Natural language description of your application
- **type** (optional): Specific framework (`react`, `node`, `vue`, `python`, `fullstack`, `auto`)
- **name** (optional): Custom name for your application

### Examples

#### React Applications
```bash
# Simple todo app
app-generator.sh generate "Todo app with drag and drop"

# Data visualization dashboard
app-generator.sh generate "Data visualization dashboard with charts" react dashboard

# E-commerce frontend
app-generator.sh generate "Modern e-commerce frontend with shopping cart and checkout"
```

#### Node.js Applications
```bash
# REST API
app-generator.sh generate "REST API for blog posts with authentication" node blog-api

# Real-time chat API
app-generator.sh generate "Real-time chat API with WebSocket support" node chat-server

# File upload service
app-generator.sh generate "File upload service with image processing" node file-service
```

#### Python Applications
```bash
# Data analysis tool
app-generator.sh generate "Data analysis tool for CSV files" python data-analyzer

# Web scraper
app-generator.sh generate "Web scraper for product prices" python scraper

# Machine learning API
app-generator.sh generate "ML API for image classification" python ml-api
```

#### Full-Stack Applications
```bash
# Complete web application
app-generator.sh generate "Task management app with user authentication" fullstack task-manager

# Social media platform
app-generator.sh generate "Social media platform with posts and comments" fullstack social-app
```

### Additional Commands

```bash
# List generated applications
app-generator.sh list

# Clean up all generated applications
app-generator.sh clean

# Show help and examples
app-generator.sh help
```

## 🛠 Supported Application Types

| Type | Description | Technologies |
|------|-------------|--------------|
| `react` | Frontend applications | React, Create React App, modern CSS |
| `node` | Backend APIs and services | Express.js, security middleware, validation |
| `vue` | Vue.js frontend applications | Vue 3, Vue CLI, composition API |
| `python` | Python applications | Flask/FastAPI, proper project structure |
| `fullstack` | Complete web applications | Frontend + Backend integration |
| `auto` | Auto-detect based on prompt | AI determines best framework |

## 🔧 Configuration

### Environment Variables

The application uses the following environment variables:

- `GEMINI_API_KEY`: Your Google AI API key (required)
- `NODE_ENV`: Development environment setting (default: `development`)
- `PYTHONPATH`: Python path configuration (default: `/workspace`)

### API Key Setup

You can set your API key in several ways:

1. **During setup** (recommended):
   ```bash
   ./setup.sh
   # Follow the prompts to enter your API key
   ```

2. **Environment variable**:
   ```bash
   export GEMINI_API_KEY="your-api-key-here"
   ```

3. **`.env` file**:
   ```bash
   echo "GEMINI_API_KEY=your-api-key-here" > .env
   ```

## 🏗 Architecture

The Gemini App Generator consists of several key components:

### Core Scripts
- **`setup.sh`**: Automated setup and configuration
- **`scripts/app-generator.sh`**: Main application generation logic
- **`scripts/gemini-config.sh`**: Gemini AI configuration and testing

### Docker Environment
- **`Dockerfile`**: Container definition with all necessary tools
- **`docker-compose.yml`**: Multi-service orchestration
- Pre-installed tools: Node.js, Python, development frameworks

### Generated Applications
- Applications are created in the `projects/` directory
- Each app includes complete source code, dependencies, and documentation
- Ready-to-run with appropriate start commands

## 🐳 Docker Environment

The development environment includes:

### Pre-installed Tools
- Node.js 18 with npm
- Python 3 with pip
- Git and development utilities
- React, Angular, Vue CLI tools
- Express generator
- Python web frameworks (Flask, FastAPI)

### Exposed Ports
- `3000`: React development server
- `4200`: Angular development server
- `8080`: General web server
- `5000`: Flask/Express alternative
- `3001`: Additional Node.js port
- `8000`: Python web servers

### Volume Mounts
- `./workspace`: Main development workspace
- `./projects`: Generated applications
- `~/.gitconfig`: Git configuration (read-only)

## 🎯 Tips for Better Results

### Writing Effective Prompts

1. **Be Specific**: Include details about features, UI/UX preferences, and functionality
   ```bash
   # Good
   "Todo app with drag and drop, dark theme, and local storage"
   
   # Better
   "Modern todo application with drag-and-drop reordering, dark/light theme toggle, local storage persistence, and responsive design for mobile"
   ```

2. **Mention Technologies**: Specify preferred libraries or frameworks
   ```bash
   "REST API using Express.js with JWT authentication and MongoDB"
   ```

3. **Include Requirements**: Mention specific features or constraints
   ```bash
   "E-commerce frontend with shopping cart, user authentication, and payment integration"
   ```

### Best Practices

- Review generated code before running in production
- Test applications thoroughly in your environment
- Customize and extend generated code as needed
- Keep your API key secure and never commit it to version control

## 🐛 Troubleshooting

### Common Issues

#### API Key Problems
```bash
# Error: "GEMINI_API_KEY environment variable is not set"
# Solution: Set your API key
export GEMINI_API_KEY="your-key-here"
# Or run setup again
./setup.sh
```

#### Docker Issues
```bash
# Error: "Docker is not installed"
# Solution: Install Docker
# Visit: https://docs.docker.com/get-docker/

# Error: "Docker Compose is not installed"  
# Solution: Install Docker Compose
# Visit: https://docs.docker.com/compose/install/
```

#### Container Access Issues
```bash
# If you can't access the container
docker-compose down
docker-compose up -d
docker-compose exec gemini-dev bash
```

#### Generated App Issues
```bash
# If npm install fails in generated apps
cd /workspace/projects/your-app
rm -rf node_modules package-lock.json
npm install
```

### Getting Help

1. Check the help command: `app-generator.sh help`
2. Review generated application logs
3. Verify your API key is valid
4. Ensure Docker containers are running properly

## 🤝 Contributing

We welcome contributions! Here's how you can help:

### Development Setup

1. Fork the repository
2. Clone your fork
3. Make your changes
4. Test thoroughly
5. Submit a pull request

### Areas for Contribution

- Additional framework support
- Improved error handling
- Better prompt processing
- Documentation improvements
- Bug fixes and optimizations

### Code Style

- Follow existing shell script conventions
- Add comments for complex logic
- Test scripts with `bash -n` for syntax validation
- Use meaningful variable names

## 📄 License

This project is open source. Please check the repository for license details.

## 🙏 Acknowledgments

- Built with Google's Gemini AI
- Uses Docker for containerization
- Inspired by the need for rapid application prototyping

## 📚 Additional Resources

- [Google AI Documentation](https://ai.google.dev/docs)
- [Docker Documentation](https://docs.docker.com/)
- [React Documentation](https://react.dev/)
- [Node.js Documentation](https://nodejs.org/docs/)
- [Vue.js Documentation](https://vuejs.org/guide/)

---

**Happy Generating! 🚀**

For questions, issues, or suggestions, please open an issue on GitHub.