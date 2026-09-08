# ZhiJian Video App Client (Flutter Version)

```markdown
# ZhiJian Video App Client (Flutter Version)
[English Version](README_EN.md)

ZhiJian is a Flutter‑based client application for video and article content. It provides features including landscape and portrait video playback, article reading, and user system.

This is a Flutter short‑video client written several years ago. Dependencies may be outdated. You will need to update relevant code if you intend to use newer library versions.

Backend Server: [https://github.com/jessejii/flutter-video-server](https://github.com/jessejii/flutter-video-server)

## Table of Contents
- [Features](#features)
- [Tech Stack](#tech-stack)
- [Project Structure](#project-structure)
- [Environment Requirements](#environment-requirements)
- [Installation & Running](#installation--running)
- [Project Configuration](#project-configuration)
- [Main Pages](#main-pages)
- [State Management](#state-management)
- [Third‑party Libraries](#third‑party-libraries)
- [Contributing](#contributing)
- [License](#license)

## Features
- 🎥 Landscape & portrait video playback
- 📖 Article content browsing
- 👤 User system (Login, Register, User Profile)
- 🌙 Dark mode support
- 👶 Teen mode
- 🔄 Application update check
- 🌍 Internationalization support (Chinese, English)
- 💾 Data caching and persistence
- 📱 Responsive design for multiple screen sizes

## Tech Stack
- [Flutter](https://flutter.dev/) - Google’s UI toolkit for cross‑platform application development
- [Dart](https://dart.dev/) - Programming language for Flutter
- [Riverpod](https://riverpod.dev/) - State management solution
- [GoRouter](https://pub.dev/packages/go_router) - Flutter routing management
- [Freezed](https://pub.dev/packages/freezed) - Data model code generation
- [Hive](https://pub.dev/packages/hive) - Lightweight local database

## Project Structure
```

lib/
├── api/                 # Network request interfaces
├── model/               # Data models
├── provider/            # State management
├── routes/              # Route configurations
├── utils/               # Utility classes
├── view/                # Page components
├── viewmodel/           # View models
├── widget/              # Custom widgets
├── main.dart            # Application entry point
└── ...

```Plain Text
## Environment Requirements
- Flutter 3.1.4 or higher
- Dart 3.1.4 or higher
- Android Studio / VS Code
- Android SDK / Xcode (for building platform‑specific applications)

## Installation & Running
1. Clone the repository
```bash
git clone <repository-url>
```

2. Install dependencies

```bash
flutter pub get
```

3. Run the application

```bash
flutter run
```

Signing:

```bash
keytool -importkeystore -srckeystore C:UsersAdministratorupload-keystore.jks -destkeystore C:UsersAdministratorupload-keystore.jks -deststoretype pkcs12
keytool -genkey -v -keystore C:UsersAdministratorupload-keystore.jks -storetype JKS -keyalg RSA -keysize 2048 -validity 10000 -alias xiaoyu
```

## Project Configuration

Core application configurations are located in `lib/utils/config.dart`:

- `BASE_URL`: Base API endpoint

- `WEB_URL`: Website address

- `DEBUG`: Toggle debug mode

- Network configurations such as timeout settings

## Main Pages

- **Home Page**: Landscape videos, portrait videos and article content

- **Video Detail Page**: Video playback screen

- **Article Detail Page**: Article reading screen

- **User Center**: Profile, favorites, viewing history, etc.

- **Settings Page**: App settings, theme switching, teen mode, etc.

- **Search Page**: Content search functionality

## State Management

The project uses Riverpod for state management. Key providers include:

- `appProvider`: Application‑level state

- `themeProvider`: Theme state

## Third‑party Libraries

Major third‑party libraries used in this project:

- `dio`: Network requests

- `flutter_screenutil`: Screen adaptation

- `video_player`: Video playback

- `cached_network_image`: Image caching

- `go_router`: Routing management

- `bot_toast`: Toast notifications

- `hive`: Local data storage

- `share_plus`: Sharing functionality

- `url_launcher`: Open external links

- `permission_handler`: Permission management

See [pubspec.yaml](pubspec.yaml) for the full dependency list.

## Contributing

Issues and Pull Requests are welcome to improve this project.

## License

Apache‑2.0

## App Screenshots


<div style="display: flex; flex-wrap: wrap; gap: 10px;">
<img src="z-sucai/capture/Screenshot_20230130-151555.jpg" width="200" alt="App Screenshot 1">
<img src="z-sucai/capture/Screenshot_20230130-151606.jpg" width="200" alt="App Screenshot 2">
<img src="z-sucai/capture/Screenshot_20230130-151609.jpg" width="200" alt="App Screenshot 3">
<img src="z-sucai/capture/Screenshot_20230130-151737.jpg" width="200" alt="App Screenshot 4">
<img src="z-sucai/capture/Screenshot_20230130-151814.jpg" width="200" alt="App Screenshot 5">
</div>
  
  
  

Related
[https://wodecun.com](https://wodecun.com)


