<div align="center">
  <img src="assets/images/logo.png" alt="Qualiverse Logo" width="180"/>
  <h1>🌌 Qualiverse</h1>
  <p><b>Advanced AI-Powered Accreditation & Quality Management System</b><br>Designed for Higher Education & Faculties of Computers and Informatics</p>

  [![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white)](https://flutter.dev)
  [![Dart](https://img.shields.io/badge/dart-%230175C2.svg?style=for-the-badge&logo=dart&logoColor=white)](https://dart.dev)
  [![BLoC](https://img.shields.io/badge/State_Management-BLoC-blue?style=for-the-badge)](https://bloclibrary.dev)
  [![Clean Architecture](https://img.shields.io/badge/Architecture-Clean-success?style=for-the-badge)](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
</div>

---

## 📖 About The Project

**Qualiverse** is a comprehensive, enterprise-grade mobile and web application built with **Flutter**. It is designed to revolutionize the way educational institutions manage their accreditation processes, quality assurance, and academic tracking.

Developed as a standout **Graduation Project**, Qualiverse eliminates manual paperwork by automating the generation of complex academic reports using **Artificial Intelligence**. It provides a centralized hub for tracking courses, managing evidence files, and monitoring the overall performance of faculty members.

Whether you are an Admin overseeing the entire college's quality cycle, or a Doctor managing your assigned courses, Qualiverse provides a seamless, localized, and highly responsive experience.

---

## ✨ Key Features

- 🤖 **AI-Powered Report Generation:** Automatically generate comprehensive Course Descriptions, AI Reports, and Quality Files. Export them directly to **PDF** or **DOCX** formats with a single click.
- 🔐 **Role-Based Access Control (RBAC):** Secure, customized interfaces tailored for **Admins**, **Doctors**, and **Quality Assurance Users**.
- 📂 **Smart Evidence Management:** Upload, download, and organize accreditation files (Excel, Word, PDF, Images) into structured Evidence Folders with real-time tracking.
- 📊 **Interactive Dashboards & Analytics:** Visualize real-time metrics, academic cycles, and compliance indicators using advanced charting libraries.
- 👨‍🏫 **Task & Course Assignment:** Admins can assign specific academic courses and quality indicators to faculty members, complete with deadlines and progress tracking.
- 🌍 **Full Localization (i18n):** Native support for both **English (LTR)** and **Arabic (RTL)**, allowing users to switch languages instantly.
- 🎨 **Adaptive & Responsive UI:** Pixel-perfect layouts that adapt seamlessly across Mobile, Tablet, and Desktop using dynamic screen utilities.
- 🔔 **Real-Time Notifications:** Stay in the loop with automated alerts for assignments, approaching deadlines, and system updates.

---

## 🛠️ Technology Stack & Architecture

This project was built following industry best practices, emphasizing scalability, maintainability, and clean code principles.

### **Core Frameworks**
- **Framework:** [Flutter](https://flutter.dev/)
- **Language:** Dart
- **State Management:** `flutter_bloc` (Strict separation of Business Logic from UI)
- **Routing:** `go_router` (Advanced declarative routing)

### **Architecture**
- **Feature-Driven Architecture:** The codebase is modularized by feature, making it highly scalable and easy for multiple developers to collaborate.
- **Clean Architecture Principles:** Separation of concerns between Data (Services/Models), Domain, and Presentation (Views/Cubits).

### **Networking & Storage**
- **API Client:** `dio` (With custom interceptors for token management and error handling)
- **Local Storage:** `shared_preferences` (For caching user sessions and localization preferences)

### **UI & UX Libraries**
- **Responsiveness:** `flutter_screenutil`
- **Typography & Icons:** `google_fonts`, `easy_localization`
- **Data Visualization:** `syncfusion_flutter_charts`, `fl_chart`
- **File Handling:** `file_picker`, `url_launcher`

---

## 📱 App Previews & Screenshots

*(You can add screenshots of your application here to showcase the beautiful UI!)*

<p align="center">
  <img src="https://via.placeholder.com/200x400.png?text=Login+Screen" width="200" />
  <img src="https://via.placeholder.com/200x400.png?text=Admin+Dashboard" width="200" />
  <img src="https://via.placeholder.com/200x400.png?text=Evidence+Folders" width="200" />
  <img src="https://via.placeholder.com/200x400.png?text=AI+Report+Generator" width="200" />
</p>

---

## 📂 Project Structure

A glimpse into the scalable folder structure used in this application:

```text
lib/
├── core/
│   ├── errors/          # Global error handling and exceptions
│   ├── networking/      # API Clients, Endpoints, Dio Interceptors
│   ├── shared_widgets/  # Reusable UI components (Buttons, Dialogs, Loaders)
│   └── utils/           # Themes, Colors, Constants
├── features/
│   ├── admin_dashboard/ # Admin controls, cycles, user management
│   ├── edit_files/      # Evidence folders, File Uploads, AI Reports
│   ├── home/            # Main navigation and landing screens
│   ├── auth/            # Login, Registration, and Session handling
│   └── ...              # Other independent modules
├── routing/             # GoRouter configuration and route mapping
└── main.dart            # Application entry point
```

---

## 🚀 Getting Started

To get a local copy up and running, follow these simple steps.

### Prerequisites
- [Flutter SDK](https://docs.flutter.dev/get-started/install) (v3.10.0 or higher)
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

## 💡 Why This Project Stands Out (For Recruiters)

If you are reviewing this repository, here is why **Qualiverse** demonstrates strong software engineering skills:
- **Complex State Management:** Successfully utilized `flutter_bloc` to handle complex asynchronous operations, file uploads, and real-time UI updates without memory leaks.
- **API Integration:** Robust handling of RESTful APIs, including multipart file uploads, downloading binaries (PDF/DOCX), and complex JSON parsing.
- **Clean UI Implementation:** Hand-crafted, custom UI components with micro-animations and hover effects that rival premium enterprise software.
- **Problem Solving:** Implemented custom error parsing algorithms to safely extract and display localized backend error messages to the user.
- **Production Ready:** Includes robust error handling, loading states, localization, and responsive design methodologies.

---

## 🛡️ License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

<div align="center">
  <i>Designed and developed with ❤️ using Flutter.</i>
</div>
