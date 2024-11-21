# CS5520FinalProject_Group6

## Mental Health Assessment App

#### 📖 Overview
The **Mental Health Assessment App** is designed to help users assess their mental well-being through quizzes on topics like stress, depression, anxiety, and more. The app provides personalized feedback based on quiz results, offers real-time updates to the test history, and allows users to manage their profiles. It aims to promote mental health awareness and self-reflection in a private and accessible way.

### 🛠 Features
- **User Authentication**:
Secure login and registration with Firebase Authentication.
- **Mental Health Quizzes**:
Multiple assessments (e.g., Stress, Anxiety, ADHD, etc.) with results based on user inputs.
- **Test History**:
View and manage previous quiz results.
Real-time updates for newly completed quizzes or deleted entries.
- **Profile Management**:
Users can update their username, profile picture, and log out of their account.
- **Consistent UI Design**:
Custom color themes for a polished and user-friendly interface.

### 🚀 Getting Started

#### Prerequisites
- iOS Device or Simulator: The app is developed for iOS using Swift and UIKit.
- Xcode: Install the latest version of Xcode to build and run the app.
- Firebase Account: Set up a Firebase project and enable Authentication and Firestore Database.

#### Installation

1. Clone the Repository:


```
git clone https://github.com/jhan125/CS5520FinalProject_Group6.git

cd MentalHealthApp
```

2. Install Dependencies:

- Open the `.xcodeproj` file in Xcode.
- Run `pod install` if you're using CocoaPods for Firebase integration.

3. Configure Firebase:

- Download the `GoogleService-Info.plist` from your Firebase project.
- Add it to your Xcode project under the `Resources` folder.

4. Run the App:

- Select your target device or simulator in Xcode.
- Press `Cmd + R` to build and run the app.

### 📝 Usage
1. Sign Up:
- Register with your email and password. 
- Optionally, upload a profile picture.
2. Take Quizzes:
- Navigate to the Quiz tab and select an assessment.
- Answer 10 questions using a scale from "Strongly Agree" to "Strongly Disagree."
- View personalized feedback based on your responses.
3. View Test History:
- Go to the Results tab to see your previous quiz results.
- Delete records if needed.
4. Manage Profile:
- Update your username or profile picture in the Profile tab.
- Log out securely when you're done.

###  📂 Project Structure
```
.
├── AppDelegate.swift
├── Assets.xcassets
│   ├── AccentColor.colorset
│   │   └── Contents.json
│   ├── AppIcon.appiconset
│   │   ├── Contents.json
│   │   └── appstore.png
│   ├── Contents.json
│   ├── DarkColor.colorset
│   │   └── Contents.json
│   ├── MindYourMind.imageset
│   │   ├── Contents.json
│   │   ├── MindYourMind.png
│   │   ├── appstore 1.png
│   │   └── appstore.png
│   └── PrimaryColor.colorset
│       └── Contents.json
├── Base.lproj
│   ├── LaunchScreen.storyboard
│   └── Main.storyboard
├── BottomBar
│   └── MainTabBarController.swift
├── GoogleService-Info.plist
├── Info.plist
├── Model.xcdatamodeld
│   └── Model.xcdatamodel
│       └── contents
├── SceneDelegate.swift
├── Screens
│   ├── AssessmentScreen
│   │   └── AssessmentViewController.swift
│   ├── HomeScreen
│   │   ├── HomeView.swift
│   │   └── HomeViewController.swift
│   ├── LoginScreen
│   │   ├── LoginView.swift
│   │   └── LoginViewController.swift
│   ├── ProfileScreen
│   │   ├── ProfileView.swift
│   │   └── ProfileViewController.swift
│   ├── RegisterScreen
│   │   ├── RegisterView.swift
│   │   └── RegisterViewController.swift
│   ├── ResultScreen
│   │   ├── ResultView.swift
│   │   └── ResultViewController.swift
│   ├── SummaryScreen
│   │   ├── SummaryView.swift
│   │   ├── SummaryViewController.swift
│   │   └── TestRecordCell.swift
│   ├── TestSelectionScreen
│   │   └── TestSelectionViewController.swift
│   └── WelcomeScreen
│       ├── WelcomeView.swift
│       └── WelcomeViewController.swift
└── ViewController.swift

21 directories, 36 files
```

### 📚 Lessons Learned
1. Firebase Integration: Learned to manage user authentication, Firestore databases, and real-time updates.
2. UI Design: Developed consistent UI themes using custom colors and styles.
3. Navigation Management: Improved handling of navigation between multiple screens, including custom back buttons and root controller changes.
4. Team Collaboration: Used Git for version control, resolving conflicts, and merging changes effectively.

### 🛠 Future Enhancements
1. Progress Tracking: Allow users to monitor changes in mental health over time.
2. Recommendations: Provide personalized resources based on quiz results.
3. Multi-Language Support: Expand accessibility for a global audience.
4. Integration with Support Services: Offer external resources like helplines and therapy connections.

### 🤝 Contributors
- Jiali Han
- Rushan Liang
- Yanqiong Ma
- Zhiqian Zhang


### 🌟 Acknowledgments
- Special thanks to our mentors and instructors for their guidance.
- Built using Swift, UIKit, and Firebase technologies.
