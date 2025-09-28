#!/bin/bash
# gemini-config.sh - Configuration script for Gemini CLI

echo "🚀 Configuring Gemini CLI..."

# Check if API key is provided
if [ -z "$GEMINI_API_KEY" ]; then
    echo "❌ GEMINI_API_KEY environment variable is not set!"
    echo "Please set your Google AI API key:"
    echo "export GEMINI_API_KEY='your-api-key-here'"
    exit 1
fi

# Create Gemini configuration directory
mkdir -p ~/.config/gemini

# Create Gemini configuration file
cat > ~/.config/gemini/config.json << EOF
{
  "apiKey": "$GEMINI_API_KEY",
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
EOF

# Create a simple Node.js script to test Gemini API
cat > /tmp/test-gemini.js << 'EOF'
const { GoogleGenerativeAI } = require("@google/generative-ai");

async function testGemini() {
    const genAI = new GoogleGenerativeAI(process.env.GEMINI_API_KEY);
    const model = genAI.getGenerativeModel({ model: "gemini-pro" });
    
    try {
        const result = await model.generateContent("Say hello world");
        const response = await result.response;
        console.log("✅ Gemini API test successful!");
        console.log("Response:", response.text());
        return true;
    } catch (error) {
        console.error("❌ Gemini API test failed:", error.message);
        return false;
    }
}

testGemini();
EOF

# Test the API connection
echo "🔍 Testing Gemini API connection..."
if node /tmp/test-gemini.js; then
    echo "✅ Gemini CLI configured successfully!"
    echo "🎉 Ready to generate applications!"
else
    echo "❌ Configuration failed. Please check your API key."
    exit 1
fi