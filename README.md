# MyPitch Live Tagging App

This is a basic Flutter application for the MyPitch project, designed to allow coaches to view live games and tag events in real time. The app uses Firebase Authentication for user authentication.

## Features

- **Authentication**: Simple authentication setup (e-mail + password) or use Sign up to create an account (username + e-mail + password).
- **Home Page**: Displays a list of live games with club names and start times.
- **Live Game Screen**: Allows users to start the game and add tags with time stamps.

## Project Structure

- `lib/main.dart`: The entry point of the application.
- `lib/components/`:
  - `background_image.dart`: Handles background image styling.
  - `custom_appbar.dart`: Defines a custom app bar for the app.
- `lib/controllers/`:
  - `login_controller.dart`: Manages the login functionality.
  - `signup_controller.dart`: Manages the signup functionality.
- `lib/screens/`:
  - `forgot_password_screen.dart`: Screen for password recovery.
  - `game_screen.dart`: The screen for tagging live games.
  - `home_screen.dart`: Displays the list of live games.
  - `login_screen.dart`: Screen for user login.
  - `signup_screen.dart`: Screen for user signup.
  - `splash_screen.dart`: Splash screen displayed at app startup.
- `lib/services/`:
  - `auth_service.dart`: Service for handling authentication.
  - `firebase_options.dart`: Firebase configuration options.
- `lib/theme.dart`: Manages the theme settings for the application.

## Prerequisites

- [Flutter](https://flutter.dev/docs/get-started/install) installed on your machine.
- A compatible IDE such as [Visual Studio Code](https://code.visualstudio.com/) or [Android Studio](https://developer.android.com/studio).

## Installation

1. **Clone the Repository**:

   ```bash
   git clone https://github.com/Bimsara132/MyPitch_New_Project.git
   cd mypitch_app

## Installation

2. **Clone the Repository**:

   ```bash
   flutter pub get
   
3. **Run the App**:
  
  ```bash
   flutter run

