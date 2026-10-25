# 💬 Real-Time Chat Application

A feature-rich Flutter mobile application designed for real-time messaging, secure user authentication, and seamless communication. Powered by Firebase backend services and structured with BLoC/Cubit state management.

---

## 📱 App Screenshots

<p align="center">
  <img src="screenshots/welcome.png" width="40%" alt="Welcome Screen"/>
</p>
<br/>
<p align="center">
  <img src="screenshots/sign in.png" width="40%" alt="Sign In Screen"/>
</p>
<br/>
<p align="center">
  <img src="screenshots/signup.png" width="40%" alt="Sign Up Screen"/>
</p>
<br/>
<p align="center">
  <img src="screenshots/message.png" width="40%" alt="Message Screen"/>
</p>

---

## 📌 Features

* **User Authentication:** Secure Sign Up, Login, and Logout using Firebase Authentication.
* **Real-Time Messaging:** Instant message delivery and syncing via Cloud Firestore streams.
* **Chat Conversations:** Smooth user-to-user private messaging interface.
* **User Profiles & Status:** Customized profile management and status display.
* **Media Sharing:** Send images and attachments directly within the chat.

---

## 🔗 Backend Services

This application uses Google Firebase for serverless backend operations:
* **Firebase Authentication:** Handles user identity and session management.
* **Cloud Firestore:** Real-NoSQL database for messages and conversation updates.
* **Firebase Storage:** File storage for media attachments and user avatars.

---

## 🛠️ Tech Stack & Architecture

* **Framework:** Flutter (Dart)
* **Backend:** Firebase (Auth, Firestore, Storage)
* **State Management:** BLoC / Cubit
* **Architecture Pattern:** Clean Architecture / MVVM

---

## 👩‍💻 Key Technical Highlights

* Configured real-time Firestore stream listeners to stream messages continuously without UI delay.
* Managed complex asynchronous states (Sending, Sent, Error, Loading) using **BLoC/Cubit**.
* Implemented form validations and handled Firebase authentication exceptions gracefully.
* Built responsive and dynamic chat bubble UI components for optimum reading experience.
