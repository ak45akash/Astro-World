# User-Facing UI Guide

## 🎨 Complete User Interface Overview

All user-facing pages have been created with a **professional corporate design** using muted blue/gray colors, clean white cards, and subtle shadows.

## 📱 Available Pages & Routes

### 1. **Home Page** (`/home`)
**File:** `lib/features/home/presentation/pages/user_home_page.dart`

**Features:**
- Welcome section with user greeting
- Daily Horoscope carousel (swipeable)
  - Shows zodiac sign, prediction, lucky number, lucky color
- Quick Actions grid:
  - Find Astrologer
  - My Bookings
  - Call History
  - My Wallet
- Featured Astrologers horizontal list
  - Profile image, name, specialty, rating, price
  - Quick "Book" button

### 2. **Chat Page** (`/chat/:bookingId`)
**File:** `lib/features/chat/presentation/pages/chat_page.dart`

**Features:**
- Header with astrologer info (name, online status)
- Voice/Video call buttons in header
- Message bubbles (sent/received)
  - Different styling for sent vs received
  - Timestamps and read receipts
- Attachment options (Image, Document, Chart)
- Message input with send button
- Auto-scroll to latest messages

### 3. **Voice Call Page** (`/voice-call`)
**File:** `lib/features/calls/presentation/pages/voice_call_page.dart`

**Features:**
- Full-screen call interface with dark blue background
- Large profile picture of astrologer
- Call duration timer
- Call controls:
  - Mute/Unmute button
  - Speaker toggle
  - End call button (red)
- Connection status indicator

### 4. **Video Call Page** (`/video-call`)
**File:** `lib/features/calls/presentation/pages/video_call_page.dart`

**Features:**
- Full-screen remote video
- Picture-in-picture local video (top right)
- Call duration and status in header
- Call controls:
  - Mute/Unmute
  - Video on/off toggle
  - Switch camera (front/back)
  - End call button
- Bottom overlay with astrologer name

### 5. **Call History Page** (`/call-history`)
**File:** `lib/features/calls/presentation/pages/call_history_page.dart`

**Features:**
- Filter tabs: All, Voice, Video
- Call history list with:
  - Astrologer profile picture
  - Call type icon (phone/video)
  - Duration and date
  - Amount paid
  - Status (Completed/Missed)
  - Quick "Call Again" button
- Tap to view call details
- Bottom sheet with full call information

### 6. **User Profile Page** (`/profile`)
**File:** `lib/features/profile/presentation/pages/user_profile_page.dart`

**Features:**
- Profile header with:
  - Large profile picture
  - Camera icon to update photo
  - Name and email
- Personal Information section:
  - Name, Email, Phone (editable)
- Birth Details section:
  - Date of Birth
  - Time of Birth
  - Place of Birth
  - Zodiac Sign (auto-calculated)
- Account section:
  - Wallet
  - Consultation History
  - Call History
  - Referral Program
  - Settings
  - Logout

### 7. **Wallet Page** (`/wallet`)
**File:** `lib/features/wallet/presentation/pages/wallet_page.dart`

**Features:**
- Wallet balance card (gradient)
  - Current balance display
  - Add Money button
  - Withdraw button
- Transaction history list:
  - Credit/Debit indicators
  - Transaction description
  - Amount (green for credit, red for debit)
  - Date and status
  - Transaction type icons

### 8. **Bookings Page** (`/bookings`)
**File:** `lib/features/bookings/presentation/pages/bookings_page.dart`

**Features:**
- Filter tabs: All, Upcoming, Past, Cancelled
- Booking cards showing:
  - Astrologer profile picture
  - Consultation type (Chat/Voice/Video)
  - Date and time
  - Duration
  - Amount
  - Status badge
- Action buttons:
  - Upcoming: "Cancel" and "Start"
  - Completed: "View Details" and "Book Again"
- Navigation to chat/calls from booking

### 9. **Astrologers List Page** (`/astrologers`)
**File:** `lib/features/astrologers/presentation/pages/astrologers_list_page.dart`

**Features:**
- Search bar
- Filter chips: All, Vedic, Tarot, Numerology, Palmistry
- Astrologer cards with:
  - Profile picture
  - Verified badge
  - Availability status
  - Name, specialty, experience
  - Star rating and review count
  - Price per session
  - "Book Now" button
- Tap to view astrologer profile

## 🎨 Design System

### Colors
- **Primary:** Deep Blue (`#1E3A5F`)
- **Background:** Light Gray (`#F5F7FA`)
- **Surface:** White (`#FFFFFF`)
- **Text:** Dark Gray (`#2C3E50`)
- **Success:** Green (`#27AE60`)
- **Error:** Red (`#E74C3C`)
- **Accent:** Blue (`#3498DB`)

### Components
- **Cards:** White background, subtle shadow, rounded corners (8px)
- **Buttons:** Primary color with white text
- **Icons:** Consistent sizing and color usage
- **Typography:** Professional font weights and sizes

## 🧭 Navigation Flow

```
Login → Home
  ├─→ Find Astrologer → Astrologers List → Astrologer Profile → Book
  ├─→ My Bookings → Booking Details → Start Chat/Call
  ├─→ Call History → Call Details → View Chat / Call Again
  ├─→ My Wallet → Add Money / View Transactions
  └─→ Profile → Edit Details / Account Settings
```

## 🚀 Testing the UI

1. **Start the app:**
   ```bash
   flutter run -d chrome --web-port 8081 -t lib/test_app.dart
   ```

2. **Navigate from Login:**
   - Click "Sign In" → Goes to Home
   - Click "Go to Dashboard" → Role-based dashboards

3. **Test User Features:**
   - From Home, click any Quick Action
   - Browse astrologers
   - View bookings
   - Check call history
   - Manage wallet
   - Update profile

## 📝 Notes

- All pages use mock data for UI preview
- Navigation is fully functional
- Professional theme applied consistently
- Responsive design for all screen sizes
- Ready for backend integration

---

**All UI pages are complete and ready for testing!** 🎉

