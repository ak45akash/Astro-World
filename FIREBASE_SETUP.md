# Firebase Setup Guide

## Prerequisites

1. Create a Firebase project at https://console.firebase.google.com/
2. Enable the following services:
   - Authentication
   - Firestore Database
   - Storage
   - Cloud Functions
   - Cloud Messaging
   - Analytics

## Android Setup

1. Add Android app to Firebase project
2. Download `google-services.json`
3. Place it in `android/app/`
4. Update `android/build.gradle`:
   ```gradle
   dependencies {
       classpath 'com.google.gms:google-services:4.4.0'
   }
   ```
5. Update `android/app/build.gradle`:
   ```gradle
   apply plugin: 'com.google.gms.google-services'
   ```

## iOS Setup

1. Add iOS app to Firebase project
2. Download `GoogleService-Info.plist`
3. Place it in `ios/Runner/`
4. Update `ios/Runner/Info.plist` if needed

## Web Setup

1. Add Web app to Firebase project
2. Copy Firebase config to `lib/core/config/firebase_config.dart`
3. Update `web/index.html` with Firebase SDK scripts

## Firestore Security Rules

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Users collection
    match /users/{userId} {
      allow read: if request.auth != null;
      allow write: if request.auth != null && request.auth.uid == userId;
    }
    
    // Astrologers collection
    match /astrologers/{astrologerId} {
      allow read: if request.auth != null;
      allow write: if request.auth != null && 
        (request.auth.uid == astrologerId || 
         get(/databases/$(database)/documents/users/$(request.auth.uid)).data.role == 'admin');
    }
    
    // Bookings collection
    match /bookings/{bookingId} {
      allow read: if request.auth != null && 
        (resource.data.userId == request.auth.uid || 
         resource.data.astrologerId == request.auth.uid ||
         get(/databases/$(database)/documents/users/$(request.auth.uid)).data.role in ['admin', 'super_admin']);
      allow create: if request.auth != null;
      allow update: if request.auth != null && 
        (resource.data.userId == request.auth.uid || 
         resource.data.astrologerId == request.auth.uid ||
         get(/databases/$(database)/documents/users/$(request.auth.uid)).data.role in ['admin', 'super_admin']);
    }
    
    // Chats collection
    match /chats/{chatId} {
      allow read: if request.auth != null && 
        (resource.data.userId == request.auth.uid || 
         resource.data.astrologerId == request.auth.uid);
      allow create: if request.auth != null;
      allow update: if request.auth != null && 
        (resource.data.userId == request.auth.uid || 
         resource.data.astrologerId == request.auth.uid);
    }
    
    // Horoscopes collection
    match /horoscopes/{horoscopeId} {
      allow read: if request.auth != null;
      allow write: if false; // Only Cloud Functions can write
    }
    
    // Wallets collection
    match /wallets/{userId} {
      allow read: if request.auth != null && request.auth.uid == userId;
      allow write: if false; // Only Cloud Functions can write
    }
  }
}
```

## Storage Security Rules

```javascript
rules_version = '2';
service firebase.storage {
  match /b/{bucket}/o {
    match /profile_images/{userId}/{allPaths=**} {
      allow read: if request.auth != null;
      allow write: if request.auth != null && request.auth.uid == userId;
    }
    
    match /kundli_charts/{userId}/{allPaths=**} {
      allow read: if request.auth != null && 
        (request.auth.uid == userId || 
         resource.metadata.astrologerId == request.auth.uid);
      allow write: if false; // Only Cloud Functions can write
    }
    
    match /varshphal_charts/{userId}/{allPaths=**} {
      allow read: if request.auth != null && 
        (request.auth.uid == userId || 
         resource.metadata.astrologerId == request.auth.uid);
      allow write: if false; // Only Cloud Functions can write
    }
    
    match /chat_attachments/{bookingId}/{allPaths=**} {
      allow read: if request.auth != null;
      allow write: if request.auth != null;
    }
  }
}
```

## Authentication Setup

1. Enable Email/Password authentication
2. Enable Google Sign-In
3. Enable Phone authentication
4. Configure OAuth redirect URLs for Google Sign-In

## Environment Configuration

Update `lib/core/config/firebase_config.dart` with your Firebase config:

```dart
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    // Replace with your actual Firebase config
    return const FirebaseOptions(
      apiKey: 'YOUR_API_KEY',
      appId: 'YOUR_APP_ID',
      messagingSenderId: 'YOUR_MESSAGING_SENDER_ID',
      projectId: 'YOUR_PROJECT_ID',
      authDomain: 'YOUR_AUTH_DOMAIN',
      storageBucket: 'YOUR_STORAGE_BUCKET',
    );
  }
}
```

## Testing

1. Run `flutter pub get`
2. Configure Firebase in your project
3. Run `flutter run` to test the app

