# UI Preview Guide

This document describes the beautiful, premium UI design of the Astrology App.

## 🎨 Design Philosophy

The app features a **premium, spiritual, and calming** design with:
- Soft gradient backgrounds (Purple to Pink gradients)
- Smooth animations and transitions
- Elegant typography (Poppins font family)
- Glassmorphism effects
- Intuitive navigation
- Responsive layouts

## 📱 Screen Previews

### 1. Login Page (`/login`)

**Features:**
- Full-screen gradient background (Purple to Pink)
- Centered authentication card with glassmorphism effect
- Email/Password login form
- Google Sign-In button
- Phone OTP option
- "Sign Up" link for new users
- Smooth form validation
- Loading indicators

**Design Elements:**
- White card with shadow and rounded corners
- Gradient button for primary actions
- Clean input fields with icons
- Password visibility toggle

### 2. Register Page (`/register`)

**Features:**
- Similar design to login page
- Extended form with:
  - Full Name
  - Email
  - Phone (Optional)
  - Password
  - Confirm Password
- Password strength validation
- Social sign-up options

### 3. Home Page (`/home`)

**Key Sections:**

#### Header
- "Welcome Back" greeting
- "Astro World" app name
- Notification bell icon
- Animated gradient background

#### Daily Horoscope Carousel
- 12 zodiac signs in a swipeable carousel
- Each card shows:
  - Zodiac sign name with icon
  - Daily prediction text
  - Lucky Number and Lucky Color
  - Beautiful gradient card design
- Page indicators at the bottom

#### Quick Actions Grid
- 4 action cards:
  1. **Astrologers** - Browse available astrologers
  2. **Bookings** - View your appointments
  3. **Profile** - Manage your account
  4. **AI Chat** - Ask astrology questions
- Each card has unique gradient color
- Tap to navigate

#### Featured Astrologers
- Horizontal scrolling list
- Astrologer cards with:
  - Profile picture
  - Name
  - 5-star rating
- Gradient background cards

### 4. Profile Page (`/profile`)

**Sections:**

#### Profile Header
- Large circular avatar
- User name
- Email address
- Centered at top

#### Profile Options (Cards)
- **Personal Information** - Edit personal details
- **Birth Details** - Add/update birth information
- **Wallet** - View balance and transactions
- **Consultation History** - Past bookings
- **Referrals** - Referral program
- **Settings** - App preferences
- **Logout** - Sign out (red gradient)

Each card features:
- Icon on the left
- Title and subtitle
- Chevron arrow on right
- Glassmorphism effect
- Tap feedback

### 5. Astrologers List Page (`/astrologers`)

**Features:**

#### Search Bar
- White search field at top
- Search icon
- Real-time search functionality

#### Filter Chips
- Horizontal scrollable filters:
  - All
  - Vedic
  - Tarot
  - Numerology
  - Palmistry
- Selected filter highlighted in white

#### Astrologer Cards
Each card displays:
- Profile picture (circular avatar)
- **Name** with "Verified" badge
- **Specialization** and **Experience**
- **5-star rating** with review count
- **Pricing** per session
- Gradient background
- Tap to view details

### 6. Phone Auth Page (`/phone-auth`)

**Features:**
- Phone number input
- OTP verification
- 6-digit OTP input field
- "Change Phone Number" option
- Similar design to login/register

## 🎨 Color Palette

- **Primary Gradient**: Purple (#6C5CE7) to Light Purple (#A29BFE)
- **Secondary Gradient**: Pink (#FD79A8) to Yellow (#FDCB6E)
- **Accent Purple**: #9B59B6
- **Accent Pink**: #E91E63
- **Accent Gold**: #FFD700
- **Background**: Gradient overlays with transparency
- **Text**: White with varying opacity levels

## ✨ Animations & Interactions

1. **Gradient Animations**: Smooth shimmer effects on backgrounds
2. **Card Transitions**: Subtle scale and fade animations
3. **Page Transitions**: Smooth navigation between screens
4. **Loading States**: Circular progress indicators
5. **Tap Feedback**: Ripple effects on interactive elements
6. **Carousel Swipe**: Smooth page transitions in horoscope carousel

## 📐 Layout Principles

- **Consistent Padding**: 16px standard padding
- **Rounded Corners**: 12-16px border radius
- **Card Elevation**: Subtle shadows for depth
- **Spacing**: 8px, 16px, 24px, 32px rhythm
- **Typography Hierarchy**: Clear size and weight differences

## 🚀 How to View the UI

1. **Run the app**:
   ```bash
   flutter run
   ```

2. **Navigate through screens**:
   - Start at login page
   - Register or login (you can use test credentials)
   - Explore home page features
   - Check profile options
   - Browse astrologers list

3. **Test on different devices**:
   - Android phone/emulator
   - iOS simulator
   - Web browser

## 📱 Responsive Design

The UI adapts to:
- Different screen sizes
- Portrait and landscape orientations
- Dark mode (when implemented)
- Various device types

## 🎯 Key UI Components

1. **GradientCard**: Reusable card with gradient background
2. **GradientButton**: Primary action button with gradient
3. **AuthContainer**: Centered container for auth forms
4. **AnimatedGradient**: Animated gradient background wrapper
5. **LoadingOverlay**: Loading indicator overlay

All components are in `lib/shared/widgets/`

---

**Note**: The UI is fully functional and ready for testing. Some features may require backend integration to show real data, but the design and navigation are complete.

