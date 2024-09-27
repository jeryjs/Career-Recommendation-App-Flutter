## Career Rec! - A Flutter Career Recommendation App

This is a Demo Flutter project for recommending Careers intelligently using the power of Google's Bard AI model. The app features a user-friendly interface that guides users through a series of questions to understand their interests and preferences. 

Based on the user's responses, the app leverages Bard AI to generate a personalized list of suitable career paths.  Each recommendation is accompanied by a concise explanation, highlighting why it aligns with the user's profile, and a breakdown of essential skills for success in that field. 

To enhance the user experience, Career Rec! also includes a built-in chatbot powered by Bard AI. This chatbot allows users to engage in further discussions about the recommended careers, providing valuable insights and answering any questions they might have. Additionally, users can conveniently export their chat history via email or WhatsApp for future reference or to share with others.

### Features

- **Personalized Career Recommendations:**  Receive tailored career suggestions based on your interests and preferences.
- **AI-Powered Insights:** Benefit from the intelligence of Google's Bard AI for accurate and relevant recommendations.
- **Interactive Chatbot:**  Engage in deeper conversations about recommended careers with a helpful chatbot.
- **Chat History Export:** Conveniently share your chat history via email or WhatsApp.

### Preview

https://github.com/jeryjs/Career-Recommendation-App-Flutter/assets/77010142/a2c33b85-8bd8-4143-9542-3aed1b8fee94

### Build Instructions

1. **Clone the repository:**

   ```bash
   git clone https://github.com/jeryjs/Career-Recommendation-App-Flutter.git
   ```

2. **Install dependencies:**

   ```bash
   flutter pub get
   ```

3. **Obtain a Google AI Studio API Key:**

   - Navigate to [https://aistudio.google.com/app/apikey](https://aistudio.google.com/app/apikey)
   - Click on "Create API key".
   - Copy the generated API key.

4. **Create `bard.key` file:**

   - In the project's `assets` directory, create a new file named `bard.key`.
   - Paste your Google AI Studio API key into this file and save.

5. **Run the app:**

   ```bash
   flutter run
   ```

### License

This project is licensed under the MIT License. 
