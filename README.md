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
- Git hooks precommit 
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
> [🔗 Google Drive](https://drive.google.com/file/d/1w7n_G1C9dGr_CCgVXy_LjdwYKdPjT82e/view?usp=sharing)  
*(You can open demo app in google drive)*

https://github.com/user-attachments/assets/d83bc58f-0234-4687-b387-d1087f12d868



## 📲 Download APK

> [🔗 Download the latest APK release](https://your-link-to-apk.com)  
*(You can host this on Firebase App Distribution, GitHub Releases, or any public URL.)*


## 🚀 GitHub Actions Workflow
# check-test file
```
name: Unit Tests

on:
  push:
  pull_request:

jobs:
  flutter-test-cation:
    runs-on: ubuntu-latest

    steps:
      - uses: actions/checkout@v4

      - name: Set up Flutter
        uses: subosito/flutter-action@v2
        with:
          channel: 'stable'
          flutter-version: '3.27.4'

      - name: Install dependencies
        run: flutter pub get

      - name: Generate files (build_runner)
        run: flutter packages pub run build_runner build --delete-conflicting-outputs

      - name: Run tests
        run: flutter test
```
# distribution-firebase
```
name: Flutter Test Action

on:
  push:
  pull_request:

jobs:
  flutter-test-action:
    runs-on: ubuntu-latest

    steps:
      - uses: actions/checkout@v4

      - name: Set up Flutter
        uses: subosito/flutter-action@v2
        with:
          channel: 'stable'
          flutter-version: 3.27.4


      - run: flutter --version
      - run: flutter pub get


      # Build APK
      - name: Build release APK
        run: flutter build apk --release

      # Upload to Firebase App Distribution
      - name: Upload to Firebase App Distribution
        uses: wzieba/Firebase-Distribution-Github-Action@v1
        with:
          appId: ${{ secrets.FIREBASE_APP_ID }}
          serviceCredentialsFileContent: ${{ secrets.CREDENTIAL_FILE_CONTENT }}
          file: build/app/outputs/flutter-apk/app-release.apk
          groups: tester-github-action
          releaseNotes: "Auto-release from GitHub Actions"
```
# flutter-lint
```
name: Flutter Lint Check

on:
  push:
    branches: [master, dev]
  pull_request:
    branches: [master, dev]

jobs:
  analyze:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout code
        uses: actions/checkout@v4

      - name: Set up Flutter
        uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.27.4'
          channel: 'stable'

      - name: Install dependencies
        run: flutter pub get

      - name: Run Flutter analyze
        run: flutter analyze
```
# validate-branch-name
```
name: Validate Branch Name

on:
  push:
  pull_request:

jobs:
  validate-branch-name:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - name: Validate branch name
        uses: actions/github-script@v7
        with:
          script: |
            const branchName = context.payload.pull_request.head.ref;
            const regex = /^(feature|fix|chore|docs|refactor|test|style|perf)\/[a-z0-9-]+$/;

            if (!regex.test(branchName)) {
              core.setFailed(`Invalid branch name: "${branchName}"
Branch name must follow this format:
 <type>/<slug>
Examples:
  feature/login-page
  fix/api-timeout
  docs/readme-update`);
            } else {
              console.log("Branch name is valid.");
            }
```
# validate-pr-title
```
name: Validate PR Title

on:
  pull_request:
    types:
      - opened
      - edited
      - synchronize
      - labeled
      - unlabeled

jobs:
  check:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: PR Title Verify
        uses: satvik-s/pr-title-check
        with:
          pattern: '^(fix|feat|chore|docs|style|refactor|perf|test)(\\([\\w\\-]+\\))?: .+$'

```

# Git hook Precommit
```
#!/bin/sh

echo "Running pre-commit checks..."

# Format check
flutter format --set-exit-if-changed .

# Lint check
flutter analyze

# Unit tests
flutter test

if [ $? -ne 0 ]; then
  echo "Pre-commit checks failed. Commit aborted."
  exit 1
fi

```

# analysis_options
```
# Flutter Linting for Teams - Professional Setup

include: package:flutter_lints/flutter.yaml

linter:
  rules:
    avoid_print: true                       
    always_use_package_imports: true        
    prefer_single_quotes: true              
    prefer_const_constructors: true         
    prefer_final_locals: true                
    unnecessary_this: true                    
    sort_constructors_first: true             
    avoid_unnecessary_containers: true        
    sized_box_for_whitespace: true            
    avoid_field_initializers_in_const_classes: true
    use_key_in_widget_constructors: true     
    always_declare_return_types: true         
    annotate_overrides: true                 
    constant_identifier_names: true          
    file_names: true                          

analyzer:
  exclude:
    - "**/*.g.dart"         
    - "**/*.freezed.dart"
    - "**/*.gr.dart"
    - "**/*.config.dart"

```

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




