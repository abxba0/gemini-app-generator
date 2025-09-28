# Examples and Demos

This document provides comprehensive examples of using the Gemini App Generator to create various types of applications.

## 📚 Table of Contents

- [React Applications](#react-applications)
- [Node.js Applications](#nodejs-applications)
- [Vue.js Applications](#vuejs-applications)
- [Python Applications](#python-applications)
- [Full-Stack Applications](#full-stack-applications)
- [Advanced Examples](#advanced-examples)
- [Best Practices](#best-practices)

## ⚛️ React Applications

### Simple Todo App

**Command:**
```bash
app-generator.sh generate "Todo app with add, edit, delete functionality"
```

**Generated Features:**
- Add new todos
- Mark todos as complete
- Edit existing todos
- Delete todos
- Local storage persistence
- Responsive design

**Sample Generated Structure:**
```
todo-app-with-add-edit/
├── package.json
├── public/
│   └── index.html
├── src/
│   ├── App.js
│   ├── index.js
│   ├── components/
│   │   ├── TodoList.js
│   │   ├── TodoItem.js
│   │   └── AddTodo.js
│   └── styles/
│       └── App.css
```

### E-commerce Product Catalog

**Command:**
```bash
app-generator.sh generate "E-commerce product catalog with search and filters" react product-catalog
```

**Generated Features:**
- Product grid layout
- Search functionality
- Category filters
- Product detail view
- Shopping cart integration
- Responsive design

### Data Visualization Dashboard

**Command:**
```bash
app-generator.sh generate "Analytics dashboard with charts and real-time data" react analytics-dashboard
```

**Generated Features:**
- Multiple chart types (bar, line, pie)
- Real-time data updates
- Interactive filtering
- Export functionality
- Mobile-responsive layout

### Weather App

**Command:**
```bash
app-generator.sh generate "Weather app with current conditions and 5-day forecast"
```

**Generated Features:**
- Current weather display
- 5-day forecast
- Location search
- Geolocation support
- Weather icons and animations

## 🟢 Node.js Applications

### REST API for Blog

**Command:**
```bash
app-generator.sh generate "REST API for blog posts with authentication" node blog-api
```

**Generated Features:**
- User authentication (JWT)
- CRUD operations for posts
- User registration/login
- Password hashing
- Input validation
- Error handling middleware

**Sample Generated Structure:**
```
blog-api/
├── package.json
├── server.js
├── routes/
│   ├── auth.js
│   ├── posts.js
│   └── users.js
├── middleware/
│   ├── auth.js
│   └── validation.js
├── models/
│   ├── User.js
│   └── Post.js
└── .env.example
```

**API Endpoints:**
```
POST   /api/auth/register
POST   /api/auth/login
GET    /api/posts
POST   /api/posts
GET    /api/posts/:id
PUT    /api/posts/:id
DELETE /api/posts/:id
```

### File Upload Service

**Command:**
```bash
app-generator.sh generate "File upload service with image processing and storage" node file-service
```

**Generated Features:**
- Multipart file upload
- Image resizing and optimization
- File type validation
- Cloud storage integration
- Progress tracking
- Secure file access

### Real-time Chat API

**Command:**
```bash
app-generator.sh generate "Real-time chat API with WebSocket support" node chat-server
```

**Generated Features:**
- WebSocket connections
- Room-based messaging
- User authentication
- Message history
- Online user tracking
- Rate limiting

### E-commerce Backend

**Command:**
```bash
app-generator.sh generate "E-commerce backend with products, orders, and payments" node ecommerce-api
```

**Generated Features:**
- Product management
- Order processing
- Payment integration
- Inventory tracking
- User profiles
- Admin dashboard API

## 🟦 Vue.js Applications

### Task Management App

**Command:**
```bash
app-generator.sh generate "Task management app with projects and deadlines" vue task-manager
```

**Generated Features:**
- Project organization
- Task creation and editing
- Deadline tracking
- Priority levels
- Progress visualization
- Team collaboration

### Social Media Frontend

**Command:**
```bash
app-generator.sh generate "Social media frontend with posts, comments, and likes" vue social-app
```

**Generated Features:**
- User profiles
- Post creation and editing
- Comment system
- Like/unlike functionality
- Image uploads
- Infinite scrolling

### Educational Platform

**Command:**
```bash
app-generator.sh generate "Online learning platform with courses and quizzes" vue learning-platform
```

**Generated Features:**
- Course catalog
- Video player integration
- Quiz system
- Progress tracking
- User dashboard
- Certificate generation

## 🐍 Python Applications

### Data Analysis Tool

**Command:**
```bash
app-generator.sh generate "Data analysis tool for CSV files with charts" python data-analyzer
```

**Generated Features:**
- CSV file upload and parsing
- Statistical analysis
- Data visualization (matplotlib/plotly)
- Export reports
- Web interface (Flask)
- Data filtering and sorting

**Sample Generated Structure:**
```
data-analyzer/
├── app.py
├── requirements.txt
├── templates/
│   ├── index.html
│   └── results.html
├── static/
│   ├── css/
│   └── js/
└── utils/
    ├── analyzer.py
    └── visualizer.py
```

### Web Scraper

**Command:**
```bash
app-generator.sh generate "Web scraper for product prices with scheduling" python price-scraper
```

**Generated Features:**
- Website scraping (BeautifulSoup)
- Price comparison
- Scheduled scraping (cron jobs)
- Data storage (SQLite/PostgreSQL)
- Email notifications
- Web dashboard

### Machine Learning API

**Command:**
```bash
app-generator.sh generate "ML API for image classification with FastAPI" python ml-api
```

**Generated Features:**
- FastAPI framework
- Image preprocessing
- Pre-trained model integration
- Batch processing
- Result caching
- API documentation (Swagger)

### Automation Scripts

**Command:**
```bash
app-generator.sh generate "Automation scripts for file organization and backups" python automation-tools
```

**Generated Features:**
- File organization by type/date
- Automated backups
- System monitoring
- Log rotation
- Configuration management
- Command-line interface

## 🔄 Full-Stack Applications

### Complete Todo Application

**Command:**
```bash
app-generator.sh generate "Full-stack todo app with user accounts" fullstack todo-fullstack
```

**Generated Components:**

**Frontend (React):**
- User authentication UI
- Todo management interface
- Real-time synchronization
- Responsive design

**Backend (Node.js):**
- REST API
- User authentication
- Database integration
- WebSocket support

### E-commerce Platform

**Command:**
```bash
app-generator.sh generate "Complete e-commerce platform with admin panel" fullstack ecommerce-platform
```

**Generated Components:**

**Frontend:**
- Product catalog
- Shopping cart
- Checkout process
- User accounts

**Backend:**
- Product management API
- Order processing
- Payment integration
- Admin dashboard API

**Database Schema:**
- Users, Products, Orders
- Inventory management
- Payment records

### Blog Platform

**Command:**
```bash
app-generator.sh generate "Full-stack blog platform with CMS features" fullstack blog-platform
```

**Generated Components:**

**Frontend:**
- Blog reader interface
- Admin CMS interface
- Comment system
- Social sharing

**Backend:**
- Content management API
- User authentication
- File upload handling
- SEO optimization

## 🚀 Advanced Examples

### Microservices Architecture

**Command:**
```bash
app-generator.sh generate "Microservices architecture with API gateway and auth service" node microservices-demo
```

**Generated Services:**
- API Gateway
- Authentication Service
- User Service
- Product Service
- Order Service
- Docker Compose configuration

### Progressive Web App

**Command:**
```bash
app-generator.sh generate "Progressive web app with offline functionality" react pwa-demo
```

**Generated Features:**
- Service worker
- Offline caching
- Push notifications
- App manifest
- Responsive design
- Installation prompts

### Real-time Collaboration Tool

**Command:**
```bash
app-generator.sh generate "Real-time collaboration tool like Google Docs" fullstack collaboration-tool
```

**Generated Features:**
- Real-time text editing
- User cursors and selections
- Version history
- Comment system
- User presence indicators
- Document sharing

### IoT Dashboard

**Command:**
```bash
app-generator.sh generate "IoT dashboard for sensor data monitoring" fullstack iot-dashboard
```

**Generated Features:**
- Real-time sensor data display
- Historical data charts
- Alert system
- Device management
- Data export functionality
- Mobile responsiveness

## 💡 Prompt Engineering Tips

### Be Specific About Features

**Good:**
```bash
app-generator.sh generate "Todo app with drag-and-drop reordering, tags, due dates, and dark mode"
```

**Better:**
```bash
app-generator.sh generate "Todo application with drag-and-drop task reordering, color-coded tags, calendar date picker for due dates, dark/light theme toggle, and local storage persistence"
```

### Mention UI/UX Requirements

**Example:**
```bash
app-generator.sh generate "Modern expense tracker with Material Design, card-based layout, animated transitions, and mobile-first responsive design"
```

### Specify Technical Requirements

**Example:**
```bash
app-generator.sh generate "REST API using Express.js with JWT authentication, MongoDB database, input validation, error logging, and Swagger documentation"
```

### Include Integration Requirements

**Example:**
```bash
app-generator.sh generate "E-commerce frontend with Stripe payment integration, Google Maps for store locator, and social media login options"
```

## 🛠 Testing Generated Applications

### React Apps
```bash
cd /workspace/projects/your-react-app
npm start
# Open http://localhost:3000
```

### Node.js Apps
```bash
cd /workspace/projects/your-node-app
npm start
# API available at http://localhost:5000
```

### Python Apps
```bash
cd /workspace/projects/your-python-app
pip install -r requirements.txt
python app.py
# Open http://localhost:5000
```

### Vue Apps
```bash
cd /workspace/projects/your-vue-app
npm run serve
# Open http://localhost:8080
```

## 📊 Example Outputs

### React Todo App Output
```javascript
// src/App.js (excerpt)
import React, { useState, useEffect } from 'react';
import TodoList from './components/TodoList';
import AddTodo from './components/AddTodo';
import './styles/App.css';

function App() {
  const [todos, setTodos] = useState([]);
  
  useEffect(() => {
    const savedTodos = localStorage.getItem('todos');
    if (savedTodos) {
      setTodos(JSON.parse(savedTodos));
    }
  }, []);
  
  const addTodo = (text) => {
    const newTodo = {
      id: Date.now(),
      text,
      completed: false,
      createdAt: new Date().toISOString()
    };
    const updatedTodos = [...todos, newTodo];
    setTodos(updatedTodos);
    localStorage.setItem('todos', JSON.stringify(updatedTodos));
  };
  
  return (
    <div className="app">
      <h1>My Todo App</h1>
      <AddTodo onAdd={addTodo} />
      <TodoList todos={todos} setTodos={setTodos} />
    </div>
  );
}

export default App;
```

### Node.js API Output
```javascript
// server.js (excerpt)
const express = require('express');
const cors = require('cors');
const helmet = require('helmet');
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');

const app = express();

// Security middleware
app.use(helmet());
app.use(cors());
app.use(express.json({ limit: '10mb' }));

// Routes
app.use('/api/auth', require('./routes/auth'));
app.use('/api/posts', require('./routes/posts'));

// Error handling middleware
app.use((err, req, res, next) => {
  console.error(err.stack);
  res.status(500).json({ 
    error: 'Something went wrong!',
    message: process.env.NODE_ENV === 'development' ? err.message : undefined
  });
});

const PORT = process.env.PORT || 5000;
app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
```

## 🎯 Best Practices for Prompts

### 1. Structure Your Request
```
"[App Type] with [Core Features], [UI Requirements], and [Technical Specifications]"
```

### 2. Use Action Words
- "Create", "Build", "Generate"
- "Include", "Add", "Implement"
- "Support", "Enable", "Allow"

### 3. Specify Data Requirements
- "with user authentication"
- "using local storage"
- "connected to MongoDB"
- "with real-time updates"

### 4. Mention Design Preferences
- "modern Material Design"
- "dark theme support"
- "mobile-first responsive"
- "accessible interface"

### 5. Include Performance Requirements
- "fast loading"
- "optimized images"
- "lazy loading"
- "SEO friendly"

## 🔄 Iterating on Generated Apps

### Customize Generated Code
1. **Review Generated Structure**: Understand the code organization
2. **Modify Components**: Customize individual components
3. **Add Features**: Extend functionality as needed
4. **Update Styling**: Customize appearance and branding
5. **Optimize Performance**: Improve loading and responsiveness

### Common Customizations
- **Branding**: Logo, colors, fonts
- **Features**: Additional functionality
- **Styling**: Custom CSS/themes
- **API Integration**: External services
- **Deployment**: Production configuration

This examples guide demonstrates the versatility and power of the Gemini App Generator. Experiment with different prompts to discover what's possible!