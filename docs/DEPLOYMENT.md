# Deployment Guide

This guide covers deployment options for both the Gemini App Generator itself and the applications it generates.

## 📋 Table of Contents

- [Generator Deployment](#generator-deployment)
- [Generated App Deployment](#generated-app-deployment)
- [Cloud Platforms](#cloud-platforms)
- [Container Deployment](#container-deployment)
- [CI/CD Integration](#cicd-integration)
- [Production Considerations](#production-considerations)

## 🚀 Generator Deployment

### Local Development Setup

**Prerequisites:**
- Docker and Docker Compose
- Gemini API key
- Git

**Setup:**
```bash
git clone https://github.com/abxba0/gemini-app-generator.git
cd gemini-app-generator
export GEMINI_API_KEY="your-api-key"
./setup.sh
```

### Cloud Server Deployment

#### AWS EC2 Deployment

**1. Launch EC2 Instance:**
- Ubuntu 20.04 LTS
- t3.medium or larger
- Security group with SSH (22) and HTTP (80/443)

**2. Server Setup:**
```bash
# Connect to instance
ssh -i your-key.pem ubuntu@your-ec2-ip

# Update system
sudo apt update && sudo apt upgrade -y

# Install Docker
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo usermod -aG docker ubuntu

# Install Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Clone repository
git clone https://github.com/abxba0/gemini-app-generator.git
cd gemini-app-generator

# Set up environment
echo "GEMINI_API_KEY=your-api-key" > .env

# Start services
./setup.sh
```

**3. Configure Security:**
```bash
# Set up UFW firewall
sudo ufw allow ssh
sudo ufw allow 3000  # React dev port
sudo ufw allow 5000  # Node.js port
sudo ufw enable

# Optional: Set up SSL with Let's Encrypt
sudo apt install certbot nginx
sudo certbot --nginx -d your-domain.com
```

#### Google Cloud Platform Deployment

**1. Create VM Instance:**
```bash
gcloud compute instances create gemini-generator \
  --image-family ubuntu-2004-lts \
  --image-project ubuntu-os-cloud \
  --machine-type e2-standard-2 \
  --zone us-central1-a \
  --tags gemini-generator
```

**2. Configure Firewall:**
```bash
gcloud compute firewall-rules create allow-gemini-ports \
  --allow tcp:3000,tcp:5000,tcp:8080 \
  --source-ranges 0.0.0.0/0 \
  --target-tags gemini-generator
```

**3. SSH and Setup:**
```bash
gcloud compute ssh gemini-generator --zone us-central1-a
# Follow same setup steps as EC2
```

#### Azure Deployment

**1. Create Resource Group and VM:**
```bash
az group create --name gemini-rg --location eastus

az vm create \
  --resource-group gemini-rg \
  --name gemini-vm \
  --image UbuntuLTS \
  --admin-username azureuser \
  --generate-ssh-keys \
  --size Standard_B2s
```

**2. Open Ports:**
```bash
az vm open-port --port 3000 --resource-group gemini-rg --name gemini-vm
az vm open-port --port 5000 --resource-group gemini-rg --name gemini-vm
```

### Docker Compose Production Setup

**Production docker-compose.yml:**
```yaml
version: '3.8'

services:
  gemini-dev:
    build: .
    container_name: gemini-app-generator
    volumes:
      - ./workspace:/workspace:cached
      - ./projects:/workspace/projects:cached
      - gemini_node_modules:/workspace/node_modules
    ports:
      - "3000:3000"
      - "5000:5000"
      - "8080:8080"
    environment:
      - GEMINI_API_KEY=${GEMINI_API_KEY}
      - NODE_ENV=production
      - PYTHONPATH=/workspace
    working_dir: /workspace
    restart: unless-stopped
    healthcheck:
      test: ["CMD", "node", "--version"]
      interval: 30s
      timeout: 10s
      retries: 3
    deploy:
      resources:
        limits:
          memory: 2G
          cpus: '1.0'

  nginx:
    image: nginx:alpine
    ports:
      - "80:80"
      - "443:443"
    volumes:
      - ./nginx.conf:/etc/nginx/nginx.conf
      - ./ssl:/etc/nginx/ssl
    depends_on:
      - gemini-dev
    restart: unless-stopped

volumes:
  gemini_node_modules:
```

**Nginx Configuration (nginx.conf):**
```nginx
events {
    worker_connections 1024;
}

http {
    upstream gemini-app {
        server gemini-dev:3000;
    }

    server {
        listen 80;
        server_name your-domain.com;
        
        location / {
            proxy_pass http://gemini-app;
            proxy_set_header Host $host;
            proxy_set_header X-Real-IP $remote_addr;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_set_header X-Forwarded-Proto $scheme;
        }
    }
}
```

## 📱 Generated App Deployment

### React Application Deployment

#### Netlify Deployment

**1. Build the App:**
```bash
cd /workspace/projects/your-react-app
npm run build
```

**2. Deploy to Netlify:**
```bash
# Install Netlify CLI
npm install -g netlify-cli

# Login and deploy
netlify login
netlify deploy --prod --dir=build
```

**3. Netlify Configuration (_redirects):**
```
# Handle client-side routing
/*    /index.html   200

# API proxy (if needed)
/api/*  https://your-api-domain.com/api/:splat  200
```

#### Vercel Deployment

**1. Install Vercel CLI:**
```bash
npm install -g vercel
```

**2. Deploy:**
```bash
cd /workspace/projects/your-react-app
vercel --prod
```

**3. Vercel Configuration (vercel.json):**
```json
{
  "rewrites": [
    {
      "source": "/api/(.*)",
      "destination": "https://your-api-domain.com/api/$1"
    },
    {
      "source": "/(.*)",
      "destination": "/index.html"
    }
  ]
}
```

#### GitHub Pages Deployment

**1. Install gh-pages:**
```bash
cd /workspace/projects/your-react-app
npm install --save-dev gh-pages
```

**2. Update package.json:**
```json
{
  "homepage": "https://yourusername.github.io/repository-name",
  "scripts": {
    "predeploy": "npm run build",
    "deploy": "gh-pages -d build"
  }
}
```

**3. Deploy:**
```bash
npm run deploy
```

### Node.js Application Deployment

#### Heroku Deployment

**1. Prepare the App:**
```bash
cd /workspace/projects/your-node-app

# Create Procfile
echo "web: node server.js" > Procfile

# Update package.json
# Add "start": "node server.js" to scripts
```

**2. Deploy to Heroku:**
```bash
# Install Heroku CLI and login
heroku login

# Create app
heroku create your-app-name

# Set environment variables
heroku config:set NODE_ENV=production
heroku config:set DATABASE_URL=your-database-url

# Deploy
git init
git add .
git commit -m "Initial commit"
git push heroku main
```

#### DigitalOcean App Platform

**1. Create app.yaml:**
```yaml
name: your-node-app
services:
- name: api
  source_dir: /
  github:
    repo: your-username/your-repo
    branch: main
  run_command: npm start
  environment_slug: node-js
  instance_count: 1
  instance_size_slug: basic-xxs
  envs:
  - key: NODE_ENV
    value: production
  - key: DATABASE_URL
    value: ${DATABASE_URL}
```

**2. Deploy:**
```bash
# Using doctl CLI
doctl apps create app.yaml

# Or use the web interface
```

#### Railway Deployment

**1. Connect Repository:**
- Link GitHub repository
- Select Node.js service

**2. Configure Environment:**
```bash
# Set environment variables in Railway dashboard
NODE_ENV=production
PORT=8080
DATABASE_URL=your-database-url
```

### Python Application Deployment

#### Heroku Python Deployment

**1. Prepare Files:**
```bash
cd /workspace/projects/your-python-app

# Create requirements.txt
pip freeze > requirements.txt

# Create Procfile
echo "web: gunicorn app:app" > Procfile

# Create runtime.txt
echo "python-3.9.0" > runtime.txt
```

**2. Deploy:**
```bash
heroku create your-python-app
git init
git add .
git commit -m "Initial commit"
git push heroku main
```

#### Google Cloud Run

**1. Create Dockerfile:**
```dockerfile
FROM python:3.9-slim

WORKDIR /app
COPY requirements.txt .
RUN pip install -r requirements.txt

COPY . .

CMD exec gunicorn --bind :$PORT --workers 1 --threads 8 app:app
```

**2. Deploy:**
```bash
gcloud builds submit --tag gcr.io/PROJECT-ID/your-python-app
gcloud run deploy --image gcr.io/PROJECT-ID/your-python-app --platform managed
```

### Vue.js Application Deployment

#### Firebase Hosting

**1. Build and Configure:**
```bash
cd /workspace/projects/your-vue-app
npm run build

# Install Firebase CLI
npm install -g firebase-tools
firebase login
firebase init hosting
```

**2. Deploy:**
```bash
firebase deploy
```

**Firebase Configuration (firebase.json):**
```json
{
  "hosting": {
    "public": "dist",
    "ignore": [
      "firebase.json",
      "**/.*",
      "**/node_modules/**"
    ],
    "rewrites": [
      {
        "source": "**",
        "destination": "/index.html"
      }
    ]
  }
}
```

## ☁️ Cloud Platforms

### AWS Deployment Options

#### AWS Elastic Beanstalk

**For Node.js Apps:**
```bash
# Install EB CLI
pip install awsebcli

# Initialize and deploy
eb init
eb create production
eb deploy
```

#### AWS Lambda + API Gateway

**Serverless Node.js (using Serverless Framework):**
```yaml
# serverless.yml
service: your-api

provider:
  name: aws
  runtime: nodejs18.x
  region: us-east-1

functions:
  api:
    handler: server.handler
    events:
      - http:
          path: /{proxy+}
          method: ANY
          cors: true
```

### Google Cloud Platform

#### Google App Engine

**app.yaml for Node.js:**
```yaml
runtime: nodejs18

env_variables:
  NODE_ENV: production
  DATABASE_URL: your-database-url

automatic_scaling:
  min_instances: 1
  max_instances: 10
```

#### Google Kubernetes Engine

**Deployment YAML:**
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: your-app
spec:
  replicas: 3
  selector:
    matchLabels:
      app: your-app
  template:
    metadata:
      labels:
        app: your-app
    spec:
      containers:
      - name: your-app
        image: gcr.io/project-id/your-app:latest
        ports:
        - containerPort: 8080
        env:
        - name: NODE_ENV
          value: "production"
```

### Microsoft Azure

#### Azure App Service

**1. Create App Service:**
```bash
az webapp create \
  --resource-group myResourceGroup \
  --plan myAppServicePlan \
  --name your-app-name \
  --runtime "NODE|18-lts"
```

**2. Deploy Code:**
```bash
az webapp deployment source config \
  --name your-app-name \
  --resource-group myResourceGroup \
  --repo-url https://github.com/your-username/your-repo \
  --branch main \
  --manual-integration
```

## 🐳 Container Deployment

### Docker Production Images

#### React App Dockerfile

```dockerfile
# Build stage
FROM node:18-alpine AS build
WORKDIR /app
COPY package*.json ./
RUN npm ci --only=production
COPY . .
RUN npm run build

# Production stage
FROM nginx:alpine
COPY --from=build /app/build /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
```

#### Node.js App Dockerfile

```dockerfile
FROM node:18-alpine
WORKDIR /app

# Copy package files
COPY package*.json ./
RUN npm ci --only=production && npm cache clean --force

# Copy source code
COPY . .

# Create non-root user
RUN addgroup -g 1001 -S nodejs
RUN adduser -S nextjs -u 1001
USER nextjs

EXPOSE 3000
CMD ["node", "server.js"]
```

#### Python App Dockerfile

```dockerfile
FROM python:3.9-slim
WORKDIR /app

# Install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy source code
COPY . .

# Create non-root user
RUN useradd --create-home --shell /bin/bash app
USER app

EXPOSE 5000
CMD ["gunicorn", "--bind", "0.0.0.0:5000", "app:app"]
```

### Kubernetes Deployment

#### Complete Kubernetes Manifest

```yaml
# Namespace
apiVersion: v1
kind: Namespace
metadata:
  name: gemini-apps

---
# Deployment
apiVersion: apps/v1
kind: Deployment
metadata:
  name: your-app
  namespace: gemini-apps
spec:
  replicas: 3
  selector:
    matchLabels:
      app: your-app
  template:
    metadata:
      labels:
        app: your-app
    spec:
      containers:
      - name: your-app
        image: your-registry/your-app:latest
        ports:
        - containerPort: 3000
        env:
        - name: NODE_ENV
          value: "production"
        resources:
          limits:
            memory: "512Mi"
            cpu: "500m"
          requests:
            memory: "256Mi"
            cpu: "250m"
        livenessProbe:
          httpGet:
            path: /health
            port: 3000
          initialDelaySeconds: 30
          periodSeconds: 10
        readinessProbe:
          httpGet:
            path: /ready
            port: 3000
          initialDelaySeconds: 5
          periodSeconds: 5

---
# Service
apiVersion: v1
kind: Service
metadata:
  name: your-app-service
  namespace: gemini-apps
spec:
  selector:
    app: your-app
  ports:
  - port: 80
    targetPort: 3000
  type: ClusterIP

---
# Ingress
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: your-app-ingress
  namespace: gemini-apps
  annotations:
    kubernetes.io/ingress.class: "nginx"
    cert-manager.io/cluster-issuer: "letsencrypt-prod"
spec:
  tls:
  - hosts:
    - your-domain.com
    secretName: your-app-tls
  rules:
  - host: your-domain.com
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: your-app-service
            port:
              number: 80
```

## 🔄 CI/CD Integration

### GitHub Actions

#### React App CI/CD

```yaml
# .github/workflows/deploy.yml
name: Deploy React App

on:
  push:
    branches: [ main ]

jobs:
  deploy:
    runs-on: ubuntu-latest
    
    steps:
    - uses: actions/checkout@v3
    
    - name: Setup Node.js
      uses: actions/setup-node@v3
      with:
        node-version: '18'
        cache: 'npm'
    
    - name: Install dependencies
      run: npm ci
    
    - name: Run tests
      run: npm test -- --coverage --passWithNoTests
    
    - name: Build
      run: npm run build
    
    - name: Deploy to Netlify
      uses: nwtgck/actions-netlify@v2.0
      with:
        publish-dir: './build'
        production-branch: main
      env:
        NETLIFY_AUTH_TOKEN: ${{ secrets.NETLIFY_AUTH_TOKEN }}
        NETLIFY_SITE_ID: ${{ secrets.NETLIFY_SITE_ID }}
```

#### Node.js API CI/CD

```yaml
name: Deploy Node.js API

on:
  push:
    branches: [ main ]

jobs:
  test:
    runs-on: ubuntu-latest
    
    steps:
    - uses: actions/checkout@v3
    - name: Setup Node.js
      uses: actions/setup-node@v3
      with:
        node-version: '18'
    
    - name: Install dependencies
      run: npm ci
    
    - name: Run tests
      run: npm test
  
  deploy:
    needs: test
    runs-on: ubuntu-latest
    
    steps:
    - uses: actions/checkout@v3
    
    - name: Deploy to Heroku
      uses: akhileshns/heroku-deploy@v3.12.12
      with:
        heroku_api_key: ${{ secrets.HEROKU_API_KEY }}
        heroku_app_name: "your-app-name"
        heroku_email: "your-email@example.com"
```

### GitLab CI/CD

```yaml
# .gitlab-ci.yml
stages:
  - test
  - build
  - deploy

variables:
  NODE_VERSION: "18"

test:
  stage: test
  image: node:$NODE_VERSION
  cache:
    paths:
      - node_modules/
  script:
    - npm ci
    - npm test

build:
  stage: build
  image: node:$NODE_VERSION
  cache:
    paths:
      - node_modules/
  script:
    - npm ci
    - npm run build
  artifacts:
    paths:
      - build/
    expire_in: 1 hour

deploy:
  stage: deploy
  image: alpine:latest
  before_script:
    - apk add --no-cache curl
  script:
    - curl -X POST -d {} $NETLIFY_DEPLOY_HOOK
  only:
    - main
```

## 🔒 Production Considerations

### Security

#### Environment Variables
```bash
# Production environment variables
NODE_ENV=production
DATABASE_URL=postgresql://user:pass@host:port/db
JWT_SECRET=your-super-secret-jwt-key
API_RATE_LIMIT=100
CORS_ORIGIN=https://your-domain.com
```

#### Security Headers (Express.js)
```javascript
const helmet = require('helmet');
const rateLimit = require('express-rate-limit');

app.use(helmet({
  contentSecurityPolicy: {
    directives: {
      defaultSrc: ["'self'"],
      styleSrc: ["'self'", "'unsafe-inline'"],
      scriptSrc: ["'self'"],
      imgSrc: ["'self'", "data:", "https:"],
    },
  },
}));

const limiter = rateLimit({
  windowMs: 15 * 60 * 1000, // 15 minutes
  max: 100 // limit each IP to 100 requests per windowMs
});

app.use('/api/', limiter);
```

### Performance Optimization

#### React Performance
```javascript
// Lazy loading
const LazyComponent = React.lazy(() => import('./LazyComponent'));

// Memoization
const MemoizedComponent = React.memo(ExpensiveComponent);

// Code splitting
import { loadable } from '@loadable/component';
const LoadableComponent = loadable(() => import('./Component'));
```

#### Node.js Performance
```javascript
// Connection pooling
const pool = new Pool({
  connectionString: process.env.DATABASE_URL,
  max: 20,
  idleTimeoutMillis: 30000,
  connectionTimeoutMillis: 2000,
});

// Caching
const redis = require('redis');
const client = redis.createClient(process.env.REDIS_URL);

// Compression
const compression = require('compression');
app.use(compression());
```

### Monitoring and Logging

#### Application Monitoring
```javascript
// Error tracking (Sentry)
const Sentry = require('@sentry/node');
Sentry.init({ dsn: process.env.SENTRY_DSN });

// Performance monitoring (New Relic)
require('newrelic');

// Custom metrics
const prometheus = require('prom-client');
const httpRequestDuration = new prometheus.Histogram({
  name: 'http_request_duration_seconds',
  help: 'Duration of HTTP requests in seconds',
  labelNames: ['method', 'route', 'status_code']
});
```

#### Health Checks
```javascript
// Health check endpoint
app.get('/health', (req, res) => {
  res.status(200).json({
    status: 'healthy',
    timestamp: new Date().toISOString(),
    uptime: process.uptime(),
    memory: process.memoryUsage()
  });
});

// Readiness check
app.get('/ready', async (req, res) => {
  try {
    await pool.query('SELECT 1');
    res.status(200).json({ status: 'ready' });
  } catch (error) {
    res.status(503).json({ status: 'not ready' });
  }
});
```

### Database Deployment

#### PostgreSQL on AWS RDS
```bash
# Create RDS instance
aws rds create-db-instance \
  --db-instance-identifier myapp-prod \
  --db-instance-class db.t3.micro \
  --engine postgres \
  --master-username admin \
  --master-user-password mypassword \
  --allocated-storage 20
```

#### MongoDB Atlas
```javascript
// Connection string for production
const mongoUri = `mongodb+srv://${username}:${password}@cluster.mongodb.net/${database}?retryWrites=true&w=majority`;

mongoose.connect(mongoUri, {
  useNewUrlParser: true,
  useUnifiedTopology: true,
  maxPoolSize: 10,
  serverSelectionTimeoutMS: 5000,
  socketTimeoutMS: 45000,
});
```

This deployment guide provides comprehensive coverage for deploying both the Gemini App Generator and the applications it creates across various platforms and environments.