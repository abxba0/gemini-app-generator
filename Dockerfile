FROM node:18

# Update package lists and install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    bash \
    python3 \
    python3-pip \
    build-essential \
    jq \
    python3-dev \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /workspace

# Install Google Generative AI package globally
RUN npm install -g @google/generative-ai

# Install other development tools
RUN npm install -g \
    create-react-app \
    @angular/cli \
    @vue/cli \
    express-generator \
    nodemon

# Install Python packages
RUN pip3 install \
    flask \
    fastapi \
    requests \
    pandas \
    numpy \
    uvicorn

# Copy scripts to container
COPY scripts/ /usr/local/bin/

# Make scripts executable
RUN chmod +x /usr/local/bin/*.sh

# Set up environment
ENV WORKSPACE=/workspace
ENV GEMINI_API_KEY=""
ENV NODE_PATH=/usr/local/lib/node_modules

# Expose common development ports
EXPOSE 3000 4200 8080 5000 3001 8000

# Create projects directory
RUN mkdir -p /workspace/projects

# Default command
CMD ["/bin/bash"]
