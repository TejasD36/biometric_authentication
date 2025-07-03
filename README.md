# Flutter Biometric Login

A Flutter application demonstrating secure biometric authentication (fingerprint/face) integrated with secure storage.  
This project is designed as an assignment to showcase:

✅ Biometric login  
✅ Secure token storage  
✅ Clean UI  
✅ Fallback to PIN/password

---

## 📱 Features

- Biometric authentication using [local_auth](https://pub.dev/packages/local_auth).
- Secure storage of authentication tokens and flags using [flutter_secure_storage](https://pub.dev/packages/flutter_secure_storage).
- Modern login UI with:
    - Lottie animations
    - Ripple effect on tap
- Fallback mechanisms when biometrics are unavailable.
- Proper error handling and user feedback.

---

## 🚀 Getting Started

Follow these steps to set up and run the project:

1. **Clone this repository:**
   ```bash
   git clone https://github.com/TejasD36/biometric_authentication.git
   ```

2. **Install dependencies:**
   ```bash
   flutter pub get
   ```

3. **(Optional) Use FVM to pin Flutter version:**
   ```bash
   fvm install stable
   fvm use stable
   ```

4. **Run the app:**
   ```bash
   flutter run
   ```

---

## ⚙️ Configuration

**Android:**

- Ensure the following permissions are set in `AndroidManifest.xml`:
  ```xml
  <uses-permission android:name="android.permission.USE_BIOMETRIC"/>
  <uses-permission android:name="android.permission.USE_FINGERPRINT"/>
  ```

**iOS:**

- In `Info.plist`, add:
  ```xml
  <key>NSFaceIDUsageDescription</key>
  <string>This app uses Face ID to authenticate you</string>
  ```

---

## 🔐 How Authentication Works

1. **First Login:**
    - User logs in with mobile and password.
    - On success, the app stores an `authToken` and `biometricEnabled` flag securely.

2. **Subsequent Logins:**
    - If `biometricEnabled` is true, biometric authentication is prompted automatically.
    - Upon success, the stored token is used to validate the session.

3. **Fallback:**
    - If biometrics are not available or authentication fails, the user can log in with credentials.

---

## 📂 Project Structure

```
lib/
├── core.dart                          # Shared core utilities
├── main.dart                          # App entry point
│
├── features/
│   ├── home.view/
│   │   └── home_view.dart             # Home screen
│   │
│   └── login.view/
│      └── login_view.dart             # Login UI
│
├── generated/
│   └── assets.dart                    # Generated assets references
│
├── services/
│   ├── biometric_service.dart         # Biometric authentication logic
│   ├── secure_storage_service.dart    # Secure storage wrapper
│   └── xcore.dart                     # Additional shared services/utilities
```


---

## 🧪 Testing

- **Manual Testing:**
    - Biometric auth flow
    - Fallback login
    - Secure storage persistence

- **Devices Tested:**
    - Real Android device (Samsung, Oppo)

---

## 📹 Demo Videos

| Description         | Link                                                           |
|---------------------|----------------------------------------------------------------|
| 🎯 Project Features | [Google Drive](https://drive.google.com/file/d/1N9-8JgJmHmSB_Zsswrh7GAO8ba8JtTr8/view?usp=sharing) |
| ⚙️ Test Apk         | [Google Drive](https://drive.google.com/file/d/1ndWXwvURK4scmvzITMt1di-UI8u4akQJ/view?usp=sharing) |

---

## ✅ Evaluation Criteria

- Completeness of biometric authentication.
- Clean, maintainable code.
- Secure handling of credentials.
- User experience and error handling.

---

## 📄 License

This project is for educational purposes and provided under the BSD license.

---

## 🙋 Questions?

Feel free to reach out if you need any help or clarifications.

