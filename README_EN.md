# ZhiJian Video App Client - Flutter Version

[中文版本](README.md)

ZhiJian is a video and article content application client developed with Flutter, providing horizontal and vertical video playback, article reading, user system, and more.
This is a Flutter short video client written 2 years ago. Dependencies may be outdated, and if using newer versions, related code needs to be updated.

## Table of Contents
- [Features](#features)
- [Tech Stack](#tech-stack)
- [Project Structure](#project-structure)
- [Environment Requirements](#environment-requirements)
- [Installation and Running](#installation-and-running)
- [Project Configuration](#project-configuration)
- [Main Pages](#main-pages)
- [State Management](#state-management)
- [Third-party Libraries](#third-party-libraries)
- [Contributing](#contributing)
- [License](#license)

## Features

- 🎥 Horizontal and vertical video playback
- 📖 Article content browsing
- 👤 User system (login, registration, profile)
- 🌙 Dark mode support
- 👶 Youth mode
- 🔄 App update checking
- 🌍 Internationalization support (Chinese, English)
- 💾 Data caching and persistence
- 📱 Responsive design, adapting to different screen sizes

## Tech Stack

- [Flutter](https://flutter.dev/) - Google's UI toolkit for building cross-platform applications
- [Dart](https://dart.dev/) - Flutter's programming language
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
├── routes/              # Routing configuration
├── utils/               # Utility classes
├── view/                # Page components
├── viewmodel/           # View models
├── widget/              # Custom components
├── main.dart            # Application entry point
└── ...
```

## Environment Requirements

- Flutter 3.1.4 or higher
- Dart 3.1.4 or higher
- Android Studio / VS Code
- Android SDK / Xcode (for building platform-specific apps)

## Installation and Running

1. Clone the project
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
```
keytool -importkeystore -srckeystore C:\Users\Administrator\upload-keystore.jks -destkeystore C:\Users\Administrator\upload-keystore.jks -deststoretype pkcs12

keytool -genkey -v -keystore C:\Users\Administrator\upload-keystore.jks -storetype JKS -keyalg RSA -keysize 2048 -validity 10000 -alias xiaoyu
```

## Project Configuration

The main application configuration is in the `lib/utils/config.dart` file:

- `BASE_URL`: API base address
- `WEB_URL`: Website address
- `DEBUG`: Debug mode switch
- Network configuration like timeouts

## Main Pages

- **Home Page**: Contains horizontal videos, vertical videos, and articles
- **Video Details Page**: Video playback page
- **Article Details Page**: Article reading page
- **User Center**: Profile, favorites, history, etc.
- **Settings Page**: App settings, theme switching, youth mode, etc.
- **Search Page**: Content search functionality

## State Management

The project uses Riverpod for state management, with main Providers including:

- `appProvider`: Application-level state management
- `themeProvider`: Theme state management

## Third-party Libraries

The project uses the following main third-party libraries:

- `dio`: Network requests
- `flutter_screenutil`: Screen adaptation
- `video_player`: Video playback
- `cached_network_image`: Image caching
- `go_router`: Routing management
- `bot_toast`: Toast notifications
- `hive`: Local data storage
- `share_plus`: Sharing functionality
- `url_launcher`: Opening links
- `permission_handler`: Permission management

See the full dependency list in [pubspec.yaml](pubspec.yaml).

## App Screenshots

<div style="display: flex; flex-wrap: wrap; gap: 10px;">
  <img src="z-sucai/capture/Screenshot_20230130-151555.jpg" width="200" alt="App Screenshot 1">
  <img src="z-sucai/capture/Screenshot_20230130-151606.jpg" width="200" alt="App Screenshot 2">
  <img src="z-sucai/capture/Screenshot_20230130-151609.jpg" width="200" alt="App Screenshot 3">
  <img src="z-sucai/capture/Screenshot_20230130-151737.jpg" width="200" alt="App Screenshot 4">
  <img src="z-sucai/capture/Screenshot_20230130-151814.jpg" width="200" alt="App Screenshot 5">
</div>

## Contributing

Issues and Pull Requests are welcome to improve this project.

## License

(c) 2021 - 2023 @Shang Zhen
www.wodecun.com