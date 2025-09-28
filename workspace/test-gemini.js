const { GoogleGenerativeAI } = require("@google/generative-ai");

async function testGemini() {
    const genAI = new GoogleGenerativeAI(process.env.GEMINI_API_KEY);
    const model = genAI.getGenerativeModel({ model: "gemini-pro" });
    
    try {
        const result = await model.generateContent("Say hello world");
        const response = await result.response;
        console.log("✅ Gemini API test successful!");
        console.log("Response:", response.text());
    } catch (error) {
        console.error("❌ Gemini API test failed:", error.message);
    }
}

testGemini();
