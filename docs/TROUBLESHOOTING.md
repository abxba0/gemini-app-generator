# Troubleshooting Guide

## Common Issues and Solutions

### Setup Issues

#### 1. Docker Not Installed
**Error Message:**
```bash
❌ Docker is not installed. Please install Docker first.
Visit: https://docs.docker.com/get-docker/
```

**Solution:**
1. Install Docker for your operating system:
   - **Windows**: Download Docker Desktop from [docker.com](https://www.docker.com/products/docker-desktop)
   - **macOS**: Download Docker Desktop from [docker.com](https://www.docker.com/products/docker-desktop)
   - **Linux (Ubuntu/Debian)**: 
     ```bash
     curl -fsSL https://get.docker.com -o get-docker.sh
     sudo sh get-docker.sh
     sudo usermod -aG docker $USER
     # Log out and log back in
     ```
   - **Linux (CentOS/RHEL)**:
     ```bash
     sudo yum install -y docker
     sudo systemctl start docker
     sudo systemctl enable docker
     sudo usermod -aG docker $USER
     ```

2. Verify installation:
   ```bash
   docker --version
   docker run hello-world
   ```

#### 2. Docker Compose Not Installed
**Error Message:**
```bash
❌ Docker Compose is not installed. Please install Docker Compose first.
Visit: https://docs.docker.com/compose/install/
```

**Solution:**
1. **Docker Desktop Users**: Docker Compose is included with Docker Desktop
2. **Linux Users**: Install Docker Compose separately:
   ```bash
   sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
   sudo chmod +x /usr/local/bin/docker-compose
   ```
3. Verify installation:
   ```bash
   docker-compose --version
   ```

#### 3. Permission Denied Error
**Error Message:**
```bash
permission denied while trying to connect to the Docker daemon socket
```

**Solution:**
```bash
# Add your user to the docker group
sudo usermod -aG docker $USER

# Log out and log back in, or run:
newgrp docker

# Alternatively, run with sudo (not recommended for regular use)
sudo ./setup.sh
```

### API Key Issues

#### 1. Missing API Key
**Error Message:**
```bash
❌ GEMINI_API_KEY environment variable is not set!
```

**Solution:**
1. **Get API Key**: Visit [Google AI Studio](https://makersuite.google.com/app/apikey) to create an API key
2. **Set API Key**:
   ```bash
   # Option 1: Export environment variable
   export GEMINI_API_KEY="your-api-key-here"
   
   # Option 2: Create .env file
   echo "GEMINI_API_KEY=your-api-key-here" > .env
   
   # Option 3: Run setup again
   ./setup.sh
   ```

#### 2. Invalid API Key
**Error Message:**
```bash
❌ Gemini API test failed: Invalid API key
```

**Solution:**
1. Verify your API key is correct
2. Check if the API key has proper permissions
3. Ensure the key hasn't expired
4. Generate a new API key if necessary:
   ```bash
   # Remove old key
   unset GEMINI_API_KEY
   rm .env
   
   # Run setup with new key
   ./setup.sh
   ```

#### 3. API Rate Limits
**Error Message:**
```bash
❌ Gemini API test failed: Rate limit exceeded
```

**Solution:**
1. Wait a few minutes before retrying
2. Check your API quota in Google AI Studio
3. Consider upgrading your API plan if needed
4. Implement retry logic in custom scripts:
   ```bash
   # Retry with exponential backoff
   for i in {1..3}; do
     if app-generator.sh generate "your prompt"; then
       break
     fi
     sleep $((i * 30))
   done
   ```

### Container Issues

#### 1. Container Won't Start
**Error Message:**
```bash
ERROR: for gemini-app-generator  Cannot start service gemini-dev
```

**Solution:**
1. Check Docker daemon status:
   ```bash
   sudo systemctl status docker
   ```
2. Restart Docker if needed:
   ```bash
   sudo systemctl restart docker
   ```
3. Clean up and rebuild:
   ```bash
   docker-compose down
   docker-compose build --no-cache
   docker-compose up -d
   ```

#### 2. Container Access Issues
**Error Message:**
```bash
Error response from daemon: No such container: gemini-app-generator
```

**Solution:**
1. Check container status:
   ```bash
   docker-compose ps
   ```
2. Start the container:
   ```bash
   docker-compose up -d
   ```
3. If still failing, rebuild:
   ```bash
   docker-compose down
   docker-compose up -d --build
   ```

#### 3. Port Conflicts
**Error Message:**
```bash
ERROR: for gemini-dev  Cannot start service gemini-dev: Ports are not available
```

**Solution:**
1. Check which process is using the port:
   ```bash
   # Check port 3000 (example)
   lsof -i :3000
   netstat -tulpn | grep :3000
   ```
2. Stop the conflicting process or change ports in `docker-compose.yml`:
   ```yaml
   ports:
     - "3001:3000"  # Change host port from 3000 to 3001
   ```
3. Restart the container:
   ```bash
   docker-compose down
   docker-compose up -d
   ```

### Generation Issues

#### 1. Empty Prompt Error
**Error Message:**
```bash
❌ Please provide a prompt for your application
```

**Solution:**
```bash
# Ensure you provide a descriptive prompt
app-generator.sh generate "Todo app with drag and drop functionality"

# Use quotes around your prompt
app-generator.sh generate "My app idea here"
```

#### 2. Generation Fails
**Error Message:**
```bash
❌ Failed to generate application
```

**Solution:**
1. Check API connectivity:
   ```bash
   # Test API connection
   docker-compose exec gemini-dev node /tmp/test-gemini.js
   ```
2. Verify disk space:
   ```bash
   df -h /workspace/projects
   ```
3. Check container logs:
   ```bash
   docker-compose logs gemini-dev
   ```
4. Try a simpler prompt:
   ```bash
   app-generator.sh generate "Simple hello world app"
   ```

#### 3. Dependency Installation Fails
**Error Message:**
```bash
npm ERR! network timeout
```

**Solution:**
1. **Network Issues**: Check internet connection
2. **Registry Issues**: Try different npm registry:
   ```bash
   docker-compose exec gemini-dev bash
   npm config set registry https://registry.npmjs.org/
   cd /workspace/projects/your-app
   npm install
   ```
3. **Clear Cache**:
   ```bash
   docker-compose exec gemini-dev bash
   npm cache clean --force
   cd /workspace/projects/your-app
   rm -rf node_modules package-lock.json
   npm install
   ```

#### 4. File Permission Issues
**Error Message:**
```bash
EACCES: permission denied, mkdir '/workspace/projects/app-name'
```

**Solution:**
1. Check directory permissions:
   ```bash
   ls -la /workspace/
   ```
2. Fix permissions:
   ```bash
   sudo chown -R $(whoami):$(whoami) workspace projects
   ```
3. Restart container:
   ```bash
   docker-compose restart
   ```

### Generated Application Issues

#### 1. React App Won't Start
**Error Message:**
```bash
Module not found: Can't resolve 'react'
```

**Solution:**
1. Install dependencies:
   ```bash
   cd /workspace/projects/your-react-app
   npm install
   ```
2. Check Node.js version:
   ```bash
   node --version  # Should be 18.x
   ```
3. Clear cache and reinstall:
   ```bash
   rm -rf node_modules package-lock.json
   npm cache clean --force
   npm install
   ```

#### 2. Node.js Server Issues
**Error Message:**
```bash
Error: Cannot find module 'express'
```

**Solution:**
1. Install dependencies:
   ```bash
   cd /workspace/projects/your-node-app
   npm install
   ```
2. Check package.json:
   ```bash
   cat package.json  # Ensure express is listed in dependencies
   ```
3. Manual installation if needed:
   ```bash
   npm install express cors helmet dotenv
   ```

#### 3. Python App Issues
**Error Message:**
```bash
ModuleNotFoundError: No module named 'flask'
```

**Solution:**
1. Install Python dependencies:
   ```bash
   cd /workspace/projects/your-python-app
   pip3 install -r requirements.txt
   ```
2. Create virtual environment:
   ```bash
   python3 -m venv venv
   source venv/bin/activate
   pip install -r requirements.txt
   ```

### Network Issues

#### 1. API Connection Timeout
**Error Message:**
```bash
❌ Gemini API test failed: connect ETIMEDOUT
```

**Solution:**
1. Check internet connection
2. Verify firewall settings
3. Try using a VPN or different network
4. Check if corporate firewall is blocking the API

#### 2. DNS Resolution Issues
**Error Message:**
```bash
❌ Gemini API test failed: getaddrinfo ENOTFOUND
```

**Solution:**
1. Check DNS settings:
   ```bash
   nslookup generativelanguage.googleapis.com
   ```
2. Try alternative DNS servers:
   ```bash
   # Add to /etc/resolv.conf (Linux)
   nameserver 8.8.8.8
   nameserver 8.8.4.4
   ```
3. Restart network service or container

### Performance Issues

#### 1. Slow Generation
**Symptoms**: Generation takes very long time

**Solution:**
1. Check system resources:
   ```bash
   docker stats
   htop
   ```
2. Increase Docker resource limits:
   - **Docker Desktop**: Settings → Resources → Advanced
   - **Linux**: Modify container resources in docker-compose.yml
3. Clear Docker cache:
   ```bash
   docker system prune -a
   ```

#### 2. High Memory Usage
**Symptoms**: System becomes slow, out of memory errors

**Solution:**
1. Monitor memory usage:
   ```bash
   docker stats gemini-app-generator
   ```
2. Limit container memory:
   ```yaml
   # In docker-compose.yml
   services:
     gemini-dev:
       mem_limit: 2g
   ```
3. Clean up old containers and images:
   ```bash
   docker system prune -a
   ```

## Advanced Debugging

### Enable Debug Logging
```bash
# Set debug environment variable
export DEBUG=1

# Run with verbose output
bash -x ./setup.sh
bash -x scripts/app-generator.sh generate "test app"
```

### Container Debugging
```bash
# Access container shell
docker-compose exec gemini-dev bash

# Check container logs
docker-compose logs -f gemini-dev

# Inspect container
docker inspect gemini-app-generator
```

### API Debugging
```bash
# Test API manually
docker-compose exec gemini-dev bash
node -e "
const { GoogleGenerativeAI } = require('@google/generative-ai');
const genAI = new GoogleGenerativeAI(process.env.GEMINI_API_KEY);
const model = genAI.getGenerativeModel({ model: 'gemini-pro' });
model.generateContent('Hello').then(result => console.log(result.response.text()));
"
```

### File System Debugging
```bash
# Check disk space
df -h

# Check file permissions
ls -la /workspace/projects/

# Check file system type
mount | grep workspace
```

## Getting Help

### Before Seeking Help
1. Check this troubleshooting guide
2. Review error messages carefully
3. Test with a simple prompt first
4. Check system requirements
5. Verify all dependencies are installed

### Information to Include
When reporting issues, include:
- Error messages (full text)
- Operating system and version
- Docker and Docker Compose versions
- Steps to reproduce the issue
- Generated application type
- Prompt used (if relevant)

### Support Channels
1. **GitHub Issues**: Report bugs and feature requests
2. **Documentation**: Check README and docs/ folder
3. **Community**: Share experiences and solutions

### Useful Commands for Support
```bash
# System information
uname -a
docker --version
docker-compose --version

# Container status
docker-compose ps
docker-compose logs

# Environment information
env | grep -E "(GEMINI|NODE|PYTHON)"

# Generated apps
ls -la /workspace/projects/
```

This troubleshooting guide covers the most common issues users encounter with the Gemini App Generator. Keep it handy for quick problem resolution!