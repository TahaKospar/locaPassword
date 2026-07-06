locaPassword 🔐
A secure, completely offline local password manager built with Flutter. locaPassword ensures absolute data privacy by storing user credentials exclusively on the local device, utilizing efficient serialization and local caching layers without relying on any external servers.

🚀 Key Features
Local Authentication: Multi-stage security including onboarding setup (setPass) and passcode verification (enterPass) on launch.

Reactive State Management: Powered by Cubit (Flutter BLoC) to decouple business logic from the UI and ensure reliable state transitions.

Secure Offline Storage: Built-in credentials caching using persistent local key-value storage.

Full CRUD Operations: Seamless workflow to create (addData), read/search, update (editData), and delete credentials through a clean interface.

Automated Data Serialization: Custom serialization logic translating credentials into persistent models.

🛠️ Architecture & Tech Stack
Framework: Flutter & Dart

State Management: Flutter BLoC / Cubit

Local Persistence: Shared Preferences (JSON String Caching)

📁 Codebase Structure
The project follows a clean, decoupled layer approach:

Plaintext
lib/
├── Screens/               
│   ├── WelcomeScreen.dart 
│   ├── setPass.dart       
│   ├── enterPass.dart     
│   ├── homePage.dart      
│   ├── addData.dart       
│   └── editData.dart      
│
├── data/                  
│   ├── cubitAuth/         
│   │   ├── auth_cubit.dart
│   │   └── auth_state.dart
│   └── cubitPass/         
│       ├── passwords_cubit.dart
│       └── passwords_state.dart
│
├── logic/                 
│   └── textField.dart     
└── main.dart              
📦 Dependencies Used
Here are the core packages utilized in this production:

flutter_bloc: For clean, predictable state management.

shared_preferences: To securely persist encoded master authentication and credential sets offline.

⚙️ Installation & Setup
Follow these steps to run the project locally:

Clone the Repository:

Bash
git clone https://github.com/TahaKospar/locaPassword.git
Navigate to Project Directory:

Bash
cd locaPassword
Install Dependencies:

Bash
flutter pub get
Run the Application:

Bash
flutter run
📄 License
This project is open-source and available under the MIT License.
