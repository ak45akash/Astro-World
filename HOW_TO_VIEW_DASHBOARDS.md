# How to View Different User Dashboards

This guide explains how to run the app on web and view dashboards for different user roles.

## 🚀 Running the App on Web

### Prerequisites

1. **Install Flutter** (if not already installed):
   ```bash
   # Download Flutter from https://flutter.dev/docs/get-started/install
   # Add Flutter to your PATH
   ```

2. **Enable Web Support**:
   ```bash
   flutter config --enable-web
   ```

3. **Get Dependencies**:
   ```bash
   cd "path/to/Astro-World"
   flutter pub get
   ```

### Run the App

```bash
# Run on Chrome
flutter run -d chrome

# Or specify a port
flutter run -d chrome --web-port 8080
```

The app will open in your default browser at `http://localhost:8080` (or the default port).

## 👥 Viewing Different Dashboards

### Method 1: Using Role Switcher (Recommended for Testing)

1. **Run the app** and navigate through login/register
2. **After logging in**, you'll see the **Home Page**
3. **Scroll down** to find the **Role Switcher** widget (yellow border, debug mode)
4. **Click any role button** to switch:
   - **Super Admin** - Shows SuperAdminDashboard
   - **Admin** - Shows AdminDashboard
   - **Astrologer** - Shows AstrologerDashboard
   - **Content Creator** - Shows ContentCreatorDashboard
   - **End User** - Shows HomePage (default user view)

### Method 2: Direct Navigation

Once logged in, you can navigate directly to dashboards:
- Go to `/dashboard` - Will show dashboard based on your current role

### Method 3: Manual Role Update (For Development)

If you need to manually set a role in Firestore:

1. Open Firebase Console
2. Go to Firestore Database
3. Find your user document in `users` collection
4. Update the `role` field to one of:
   - `super_admin`
   - `admin`
   - `astrologer`
   - `content_creator`
   - `end_user`
5. Refresh the app

## 📊 Dashboard Features by Role

### 1. Super Admin Dashboard

**Features:**
- **Total Users** - System-wide user count
- **Total Revenue** - Overall platform revenue
- **Astrologers** - Total astrologer count
- **Bookings** - Total booking count
- **Revenue Trend Chart** - Line chart showing revenue over time
- **Quick Actions:**
  - Manage Admins
  - System Settings
  - Analytics
  - Reports

**Access:** Role = `super_admin`

### 2. Admin Dashboard

**Features:**
- **Pending Verifications** - Astrologers waiting approval
- **Disputes** - Open dispute cases
- **Refunds** - Refund requests to process
- **Support Tickets** - Customer support queue
- **Pending Actions:**
  - Astrologer Verification
  - Refund Requests
  - Dispute Resolution
- **Quick Actions:**
  - Verify Astrologers
  - Handle Refunds

**Access:** Role = `admin`

### 3. Astrologer Dashboard

**Features:**
- **Total Earnings** - Lifetime earnings
- **Wallet Balance** - Current wallet amount
- **Total Consultations** - Total sessions conducted
- **Rating** - Average rating
- **Earnings Overview Chart** - Bar chart of earnings
- **Upcoming Bookings** - Next scheduled sessions
- **Quick Actions:**
  - Manage Schedule
  - View Clients
  - Request Payout
  - View Reviews

**Access:** Role = `astrologer`

### 4. Content Creator Dashboard

**Features:**
- **Total Posts** - Blog/horoscope posts created
- **Total Views** - Combined views across all posts
- **Total Likes** - Total likes received
- **Engagement** - Engagement percentage
- **Recent Posts** - Latest published content
- **Quick Actions:**
  - Create Post
  - Analytics

**Access:** Role = `content_creator`

### 5. End User Dashboard (Home Page)

**Features:**
- Daily Horoscope Carousel
- Quick Actions (Astrologers, Bookings, Profile, AI Chat)
- Featured Astrologers
- Role Switcher (for testing)

**Access:** Role = `end_user` (default)

## 🔧 Testing Different Roles

### Quick Test Setup

1. **Register/Login** as a regular user
2. **Go to Home Page**
3. **Use Role Switcher** to switch between roles
4. **Navigate to Dashboard** to see role-specific views

### Expected Behavior

- **Super Admin & Admin** → See `/dashboard` with admin controls
- **Astrologer** → See `/dashboard` with earnings and bookings
- **Content Creator** → See `/dashboard` with post analytics
- **End User** → See `/home` (default user experience)

## 🌐 Web-Specific Notes

- **Hot Reload**: Press `r` in terminal to hot reload
- **Hot Restart**: Press `R` in terminal to hot restart
- **Quit**: Press `q` in terminal to quit

## 🐛 Troubleshooting

### App won't run on web

1. Check Flutter installation:
   ```bash
   flutter doctor
   ```

2. Enable web support:
   ```bash
   flutter config --enable-web
   ```

3. Clean and rebuild:
   ```bash
   flutter clean
   flutter pub get
   flutter run -d chrome
   ```

### Role Switcher not showing

- Make sure you're logged in
- Check if you're on the Home Page
- Scroll down to see the Role Switcher widget

### Dashboard not changing

- Wait a moment after switching roles
- Try refreshing the page (F5)
- Check browser console for errors

## 📝 Notes

- **Role Switcher** is visible in development mode for easy testing
- In production, roles should be managed through proper admin controls
- All dashboards are fully functional with mock data
- Real data will be displayed when Firebase is configured

## 🎯 Quick Start

```bash
# 1. Navigate to project
cd "path/to/Astro-World"

# 2. Get dependencies
flutter pub get

# 3. Run on web
flutter run -d chrome

# 4. In browser:
#    - Register/Login
#    - Go to Home Page
#    - Use Role Switcher to test different dashboards
```

---

**Happy Testing!** 🚀

