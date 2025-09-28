# Quick Reference Guide

A handy reference for common Gemini App Generator commands and workflows.

## 🚀 Quick Setup

```bash
# 1. Clone and setup
git clone https://github.com/abxba0/gemini-app-generator.git
cd gemini-app-generator
./setup.sh

# 2. Access container
docker-compose exec gemini-dev bash

# 3. Generate your first app
app-generator.sh generate "Todo app with dark mode"
```

## 📋 Command Reference

### Basic Commands

| Command | Description | Example |
|---------|-------------|---------|
| `generate` | Create new application | `app-generator.sh generate "React todo app"` |
| `list` | List generated apps | `app-generator.sh list` |
| `clean` | Remove all generated apps | `app-generator.sh clean` |
| `help` | Show help information | `app-generator.sh help` |

### Generate Command Syntax

```bash
app-generator.sh generate "prompt" [type] [name]
```

- **prompt**: Description of your app (required)
- **type**: Framework type (optional)
- **name**: Custom app name (optional)

### Supported Types

| Type | Description | Example |
|------|-------------|---------|
| `react` | React frontend | `app-generator.sh generate "Dashboard" react` |
| `node` | Node.js backend | `app-generator.sh generate "API" node` |
| `vue` | Vue.js frontend | `app-generator.sh generate "SPA" vue` |
| `python` | Python application | `app-generator.sh generate "Web app" python` |
| `fullstack` | Complete web app | `app-generator.sh generate "Blog" fullstack` |
| `auto` | Auto-detect (default) | `app-generator.sh generate "My app"` |

## 💡 Prompt Examples

### React Applications
```bash
# Simple apps
app-generator.sh generate "Todo list with local storage"
app-generator.sh generate "Weather app with 5-day forecast"
app-generator.sh generate "Image gallery with lightbox"

# Complex apps
app-generator.sh generate "E-commerce frontend with cart and checkout"
app-generator.sh generate "Social media dashboard with real-time updates"
app-generator.sh generate "Data visualization app with multiple chart types"
```

### Node.js APIs
```bash
# Basic APIs
app-generator.sh generate "REST API for user management" node
app-generator.sh generate "Blog API with authentication" node
app-generator.sh generate "File upload service" node

# Advanced APIs
app-generator.sh generate "Real-time chat API with WebSocket" node
app-generator.sh generate "E-commerce backend with payment integration" node
app-generator.sh generate "Microservice for order processing" node
```

### Vue.js Applications
```bash
# Frontend apps
app-generator.sh generate "Task manager with drag and drop" vue
app-generator.sh generate "Music player with playlist support" vue
app-generator.sh generate "Admin dashboard with charts" vue
```

### Python Applications
```bash
# Web applications
app-generator.sh generate "Flask blog with user authentication" python
app-generator.sh generate "Data analysis tool for CSV files" python
app-generator.sh generate "Web scraper with scheduling" python

# APIs
app-generator.sh generate "FastAPI for machine learning models" python
app-generator.sh generate "REST API with SQLAlchemy" python
```

### Full-Stack Applications
```bash
# Complete applications
app-generator.sh generate "Social media platform" fullstack
app-generator.sh generate "Task management system" fullstack
app-generator.sh generate "E-learning platform" fullstack
```

## 🛠 Common Workflows

### Typical Development Flow

1. **Generate Application**
   ```bash
   app-generator.sh generate "My awesome app" react my-app
   ```

2. **Navigate to Project**
   ```bash
   cd /workspace/projects/my-app
   ```

3. **Start Development Server**
   ```bash
   # For React/Vue
   npm start
   
   # For Node.js
   npm run dev
   
   # For Python
   python app.py
   ```

4. **Access Application**
   - React: http://localhost:3000
   - Node.js: http://localhost:5000
   - Vue: http://localhost:8080
   - Python: http://localhost:5000

### Multiple Applications

```bash
# Generate frontend and backend
app-generator.sh generate "User dashboard" react frontend
app-generator.sh generate "User API with auth" node backend

# List all projects
app-generator.sh list

# Clean up when done
app-generator.sh clean
```

## 🔧 Troubleshooting Quick Fixes

### Common Issues

| Issue | Quick Fix |
|-------|-----------|
| API key not found | `export GEMINI_API_KEY="your-key"` |
| Container not running | `docker-compose up -d` |
| Generation fails | Check network connection |
| Port already in use | Change ports in docker-compose.yml |
| npm install fails | Clear cache: `npm cache clean --force` |

### Emergency Commands

```bash
# Restart everything
docker-compose down && docker-compose up -d

# Rebuild containers
docker-compose build --no-cache

# Access container directly
docker-compose exec gemini-dev bash

# Check container status
docker-compose ps

# View logs
docker-compose logs -f
```

## 📁 Project Structure

### Generated React App
```
my-react-app/
├── package.json
├── public/
│   └── index.html
├── src/
│   ├── App.js
│   ├── index.js
│   ├── components/
│   └── styles/
└── README.md
```

### Generated Node.js API
```
my-node-api/
├── package.json
├── server.js
├── routes/
├── middleware/
├── models/
├── .env.example
└── README.md
```

### Generated Python App
```
my-python-app/
├── app.py
├── requirements.txt
├── templates/
├── static/
└── README.md
```

## 🌐 Environment Variables

### Required
```bash
GEMINI_API_KEY=your-google-ai-api-key
```

### Optional
```bash
NODE_ENV=development
PYTHONPATH=/workspace
```

### Setting Variables
```bash
# Option 1: Export in shell
export GEMINI_API_KEY="your-key"

# Option 2: Add to .env file
echo "GEMINI_API_KEY=your-key" > .env

# Option 3: Set during setup
./setup.sh  # Will prompt for key
```

## 🚀 Performance Tips

### Faster Generation
- Use specific prompts (less ambiguous)
- Choose specific framework types
- Keep prompts focused and clear

### Resource Management
```bash
# Check container resources
docker stats

# Clean up unused containers
docker system prune

# Clean up generated apps
app-generator.sh clean
```

## 🔍 Debugging

### Verbose Output
```bash
# Enable debug mode
export DEBUG=1

# Run with verbose shell
bash -x scripts/app-generator.sh generate "test app"
```

### Check API Connection
```bash
# Test Gemini API
docker-compose exec gemini-dev node workspace/test-gemini.js
```

### Validate Scripts
```bash
# Check script syntax
bash -n setup.sh
bash -n scripts/app-generator.sh
```

## 📖 Best Practices

### Writing Better Prompts

✅ **Good:**
```bash
app-generator.sh generate "Todo app with drag-and-drop, dark mode, and local storage"
```

❌ **Avoid:**
```bash
app-generator.sh generate "Make me an app"
```

### Prompt Structure
```
"[App Type] with [Features], [UI Requirements], and [Technical Specs]"
```

### Examples
```bash
# Specific features
"React todo app with drag-and-drop reordering, priority levels, and dark theme"

# UI requirements
"Dashboard with Material Design, responsive layout, and mobile-first approach"

# Technical specs
"Node.js API with JWT authentication, PostgreSQL database, and rate limiting"
```

## 📚 Useful Resources

### Documentation
- [README.md](../README.md) - Main documentation
- [ARCHITECTURE.md](ARCHITECTURE.md) - System architecture
- [API.md](API.md) - Detailed API reference
- [TROUBLESHOOTING.md](TROUBLESHOOTING.md) - Problem solutions
- [EXAMPLES.md](EXAMPLES.md) - Comprehensive examples

### External Links
- [Google AI Studio](https://makersuite.google.com/app/apikey) - Get API key
- [Docker Documentation](https://docs.docker.com/) - Docker help
- [React Documentation](https://react.dev/) - React guide
- [Node.js Documentation](https://nodejs.org/docs/) - Node.js guide

## ⌨️ Keyboard Shortcuts

### Container Shell
- `Ctrl+C` - Stop running process
- `Ctrl+D` - Exit container shell
- `Ctrl+L` - Clear screen
- `Tab` - Auto-complete commands

### Vim (if editing files)
- `i` - Insert mode
- `Esc` - Command mode
- `:wq` - Save and exit
- `:q!` - Quit without saving

## 🏷 Version Information

### Check Versions
```bash
# Docker version
docker --version

# Node.js version (in container)
docker-compose exec gemini-dev node --version

# Python version (in container)
docker-compose exec gemini-dev python3 --version
```

### Update Project
```bash
# Pull latest changes
git pull origin main

# Rebuild containers
docker-compose build --no-cache

# Restart services
docker-compose up -d
```

## 💾 Backup and Export

### Export Generated Apps
```bash
# Create backup
tar -czf my-apps-backup.tar.gz projects/

# Copy from container
docker cp gemini-app-generator:/workspace/projects ./backup-projects
```

### Import/Restore
```bash
# Extract backup
tar -xzf my-apps-backup.tar.gz

# Copy to container
docker cp ./backup-projects gemini-app-generator:/workspace/
```

---

**💡 Pro Tip:** Bookmark this page for quick reference during development!

For more detailed information, check the full documentation in the [docs/](.) directory.