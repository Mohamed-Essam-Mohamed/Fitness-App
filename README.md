# FITNESS APP

**Fitness** is a full-featured fitness companion app designed to help users achieve their health and body goals—whether it's fat loss, muscle gain, or general fitness improvement.
Through a personalized onboarding process, users define their goals and current level. Based on that, the app becomes a smart fitness coach offering:
- 🧠 An AI-powered assistant that answers all your fitness questions
- 🏋️‍♂️ Workout programs tailored to your level
- 🎥 High-quality exercise videos with correct form demonstrations
- 🍽️ Healthy meal plans with cooking video tutorials
- 🔥 Full control over calorie tracking and nutritional intake
- 💬 Interactive chat with a fitness-specific AI coach
- ✅ Easy-to-use interface with a smooth and friendly experience
- 🧑‍🏫 Replaces the need for a personal trainer
- 🔔 Daily reminders to keep you on track if you skip workouts
- 📈 Progress tracking until you reach your fitness goals
- 🗓️ Daily personalized workout and nutrition recommendations to keep things fresh and exciting


## Skills
- Clean and modular **MVI Architecture**,  **Clean Architecture** **Microservices**
- **State Management:** using Cubit and Bloc (flutter_bloc)
- **API Integration:** via Dio + Retrofit
- **Firebase Integration:** App Distribution + Crashlytics + Dashboard + Cloud Messaging
- **Unit Testing** , **Bloc Testing** and **Widget Testing**
- **Secure & Local Storage:** shared_preferences + flutter_secure_storage
- **CI/CD:** GitHub Actions to Automation Linting, Unit Testing, Bloc Testing, Integration Testing, Build APK, Distribute APK, and Code Coverage.
- **Agile Process:** Jira + Scrum + Git Workflow + Github workflow
- **Internationalization** using `easy_localization`
- Responsive UI for all mobile devices
- SonarQube and codecov
- Dio cache interceptor `dio_cache_interceptor`
- Best Performance App
- Teamwork

## 📂 Project Structure
```lib/
├── core/
│   ├── base_state/
│   ├── common/
│   ├── constants/
│   ├── di/
│   ├── dialogs/
│   ├── dummy/
│   ├── enum/
│   ├── extensions/
│   ├── logger/
│   ├── network/
│   ├── routes/
│   ├── storage_helper/
│   ├── theme/
│   └── utils/
├── feature/
│   ├── app_section/
│   ├── auth/
│   ├── chat_ai/
│   ├── Exercise/
│   ├── home/
│   ├── meals/
│   ├── onboarding/
│   ├── profile/
│   └── workouts/
├── generated/
├── firebase_options.dart
└── main.dart

test/
└── feature/
    ├── auth/
    └── Exercise/
```

## Technologies & Tools Used

| Category        | Tools & Packages |
|----------------|------------------|
| **State Management** | `flutter_bloc`, `equatable` |
| **Networking**        | `dio`, `retrofit`, `pretty_dio_logger`,  `dio_cache_interceptor` |
| **UI & UX**           | `flutter_svg`, `shimmer`, `lottie`, `toastification`, `youtube_player_flutter` |
| **Storage**           | `shared_preferences`, `flutter_secure_storage` |
| **Localization**      | `easy_localization` |
| **Dependency Injection** | `get_it`, `injectable` |
| **Firebase**          | `firebase_core`, `firebase_crashlytics`, `firebase_messaging`, `cloud_firestore` |
| **Testing**           | `bloc_test`, `mockito`, `mocktail`, `flutter_test` |
| **Utilities**         | `logger`, `json_serializable`, `url_launcher`, `image_picker`, `permission_handler` |
| **CI/CD & Quality**   | GitHub Actions, SonarQube, Codecov, Linting |



## UI APP
<img width="1920" height="1080" alt="Fit" src="https://github.com/user-attachments/assets/ce34b532-ab45-424a-82c5-e8b471532967" />


## Demo APP


## 📲 Download APK

> [🔗 Download the latest APK release](https://your-link-to-apk.com)  
*(You can host this on Firebase App Distribution, GitHub Releases, or any public URL.)*



## 👥 Flutter Team

We are a team of Flutter developers who collaborated on this project with shared responsibilities in architecture, UI/UX, backend integration, testing, and deployment.

| Name           | Role                          | GitHub Profile                     |
|----------------|-------------------------------|------------------------------------|
| **ENG: Mohamed Esam** | Flutter Developer           | [@Mohamed Essam Eid](https://github.com/Mohamed-Essam-Mohamed) |
| **ENG: Rana Osama** | Flutter Developer             | [@Rana Osama](https://github.com/RanaUsama20) |
| **ENG: Amira Khaled** | Flutter Developer           | [@Amira Khaled](https://github.com/Amira098) |
| **ENG: Amr Nabil** | Flutter Developer              | [@Amr Nabil](https://github.com/3mmrrrNabil) |
| **ENG: Bakri** | Flutter Developer                  | [@Bakri](https://github.com/BakriCB9) |



## 🧑‍💻 How to Run the App

```bash
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
flutter run




