# 🍽️ Menu Recommender App

A modern, premium Flutter application designed to solve the daily dilemma of "What should I eat?". Browse curated menus, discover recipes, and contribute your own culinary creations in a beautiful, immersive interface.

## ✨ Key Features

- **🎨 Premium UI/UX**:
  - Dark-themed design with "Deep Charcoal" and "Burnt Orange" accents.
  - Pinterest-style **Masonry Grid** feed.
  - **Glassmorphism** cards and smooth **Hero Animations**.
  - Custom typography using Google Fonts (`Playfair Display` & `Lato`).

- **🔐 Authentication**:
  - Secure **Email/Password** Sign Up & Login.
  - **Google Sign-In** integration (Android & Web).
  - Protected routes (App gated behind login).

- **🍳 Recipe Management**:
  - View detailed recipes with ingredients, instructions, and chef profiles.
  - **Real-time Reviews**: Star ratings and user comments.
  - **Search & Filter**: Find the perfect dish (Coming Soon).

- **☁️ Cloud Integration**:
  - **Firebase Firestore**: Real-time database for recipes and menus.
  - **Cloud Upload**: Users can upload their own recipes with images (via File Picker).

## 🛠️ Tech Stack

- **Framework**: Flutter (Dart 3.x)
- **State Management**: Provider
- **Backend Service**: Firebase (Auth, Firestore)
- **Navigation**: Material 3 Navigation
- **Crucial Packages**:
  - `firebase_auth`, `cloud_firestore`
  - `google_fonts`, `flutter_staggered_grid_view`
  - `cached_network_image`, `animations`

## 🚀 Getting Started

### Prerequisites
- Flutter SDK installed.
- Firebase Account.

### Installation

1.  **Clone the repository**:
    ```bash
    git clone https://github.com/your-username/menu_recommender.git
    cd menu_recommender
    ```

2.  **Install dependencies**:
    ```bash
    flutter pub get
    ```

3.  **Firebase Setup**:
    -   Create a project in the [Firebase Console](https://console.firebase.google.com/).
    -   **Web/Linux**:
        -   Copy your web config keys to `lib/firebase_options.dart` (Replace placeholders).
    -   **Android**:
        -   Add `google-services.json` to `android/app/`.
        -   Add your SHA-1 fingerprint to Firebase Project Settings (required for Google Sign-In).

4.  **Run the App**:
    -   **Linux**: `flutter run -d linux`
    -   **Android**: `flutter run -d android`

## 📂 Project Structure

```
lib/
├── core/
│   ├── theme/          # AppColors, ThemeData
│   ├── widgets/        # Reusable components (RecipeCard, etc.)
│   └── providers/      # State Management (MainProvider)
├── models/             # Data Models (Recipe, User, Review)
├── screens/
│   ├── auth/           # LoginScreen
│   ├── home/           # HomeScreen (Feed)
│   ├── details/        # RecipeDetailScreen
│   └── upload/         # UploadScreen
├── services/
│   ├── auth_service.dart
│   └── firestore_service.dart
└── main.dart           # Entry Point
```

## 📝 License

This project is licensed under the MIT License.
