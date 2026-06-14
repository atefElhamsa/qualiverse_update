<div align="center">
  <img src="assets/images/logo.png" alt="Qualiverse Logo" width="150"/>
  <h1>Qualiverse</h1>
  <p><b>Accreditation & Quality System</b><br>Faculty of Computers and Informatics</p>

  [![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white)](https://flutter.dev)
  [![Dart](https://img.shields.io/badge/dart-%230175C2.svg?style=for-the-badge&logo=dart&logoColor=white)](https://dart.dev)
  [![BLoC](https://img.shields.io/badge/State_Management-BLoC-blue?style=for-the-badge)](https://bloclibrary.dev)
</div>

---

## 📖 Overview

**Qualiverse** is a comprehensive, AI-powered Accreditation & Quality Management System built with Flutter. It streamlines the evaluation, tracking, and reporting processes for educational faculties (specifically designed for the Faculty of Computers and Informatics). 

The application provides specialized dashboards for different roles (Admin, Doctor, User) to seamlessly manage academic cycles, assign courses and quality indicators, and dynamically generate detailed accreditation reports using AI.

---

## ✨ Key Features

- 🔐 **Role-Based Access Control (RBAC):** Tailored interfaces and permissions for Admins, Doctors, and Standard Users.
- 📊 **Interactive Dashboards:** Real-time metrics and data visualization using `syncfusion_flutter_charts` and `fl_chart`.
- 🤖 **AI Report Generation:** Automatically generate, edit, and download Course Descriptions and Quality files in **PDF** and **DOCX** formats.
- 🔄 **Accreditation Lifecycle Management:** Create and manage Cycles, Criterions, and Indicators.
- 👨‍🏫 **Task Assignment:** Assign courses and indicators to specific doctors with defined deadlines.
- 🌍 **Localization:** Fully localized in both **English** and **Arabic** (RTL support) using `easy_localization`.
- 🔔 **Real-time Notifications:** Keep users updated with automated polling and unread badge counts.
- 🎨 **Responsive UI:** Adaptive layouts spanning mobile, tablet, and desktop viewports using `flutter_screenutil`.

---

## 🛠️ Tech Stack & Libraries

### Core Architecture
- **Framework:** [Flutter](https://flutter.dev/) (SDK ^3.9.2)
- **Language:** Dart
- **State Management:** `flutter_bloc`
- **Routing:** `go_router` (for deep linking and declarative routing)
- **Architecture Pattern:** Feature-Based Folder Structure

### Networking & Data
- **HTTP Client:** `dio`
- **Caching & Local Storage:** `shared_preferences`

### UI & UX
- **Responsive Design:** `flutter_screenutil`
- **Typography & Icons:** `google_fonts`, `cupertino_icons`, `phosphor_flutter`
- **Charts:** `fl_chart`, `syncfusion_flutter_charts`, `syncfusion_flutter_gauges`
- **Animations:** `flutter_animate`
- **File Handling:** `file_picker`, `open_filex`

---

## 📂 Project Structure

The project follows a scalable, feature-first folder structure:

```text
lib/
├── core/
│   ├── utils/           # App colors, images, themes, endpoints
│   ├── shared_widgets/  # Reusable UI components
│   └── networking/      # API Clients, Dio Interceptors
├── features/
│   ├── admin_dashboard/ # Admin controls, cycles, user management
│   ├── ai_description/  # AI prompt and file generation logic
│   ├── home/            # Drawer and main landing screens
│   ├── auth/            # Login and session handling
│   └── ...              # Other independent feature modules
├── routing/             # GoRouter configuration and route strings
└── main.dart            # Application entry point
```

---

## 🚀 Getting Started

### Prerequisites
- [Flutter SDK](https://docs.flutter.dev/get-started/install) (v3.9.2 or higher)
- Android Studio / VS Code
- Git

### Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/yourusername/qualiverse.git
   cd qualiverse
   ```

2. **Install dependencies:**
   ```bash
   flutter pub get
   ```

3. **Run the app:**
   ```bash
   flutter run
   ```

---

## 🤝 Contributing

Contributions, issues, and feature requests are welcome! 
Feel free to check the [issues page](https://github.com/yourusername/qualiverse/issues) if you want to contribute.

---

## 🛡️ License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

<div align="center">
  <i>Built with ❤️ using Flutter</i>
</div>
