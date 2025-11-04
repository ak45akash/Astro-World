# Firebase Cloud Functions Documentation

This document outlines the required Firebase Cloud Functions for the Astrology App.

## Required Functions

### 1. generateAstrologyData
**Trigger:** HTTP Call (from booking creation)
**Purpose:** Generate Kundli and Varshphal data when a booking is created

```javascript
exports.generateAstrologyData = functions.https.onCall(async (data, context) => {
  const { userId, bookingId, birthDetails } = data;
  
  // Call astrology API (VedicRishi/Prokerala)
  // Store Kundli and Varshphal in Firestore
  // Store chart images in Firebase Storage
  // Set expiry date for Varshphal (1 year from generation)
  
  return { success: true, kundliData, varshphalData };
});
```

### 2. fetchDailyHoroscopes
**Trigger:** Scheduled (Every day at 5 AM)
**Purpose:** Fetch daily horoscopes for all 12 zodiac signs

```javascript
exports.fetchDailyHoroscopes = functions.pubsub
  .schedule('0 5 * * *')
  .timeZone('Asia/Kolkata')
  .onRun(async (context) => {
    const zodiacSigns = ['Aries', 'Taurus', 'Gemini', 'Cancer', 'Leo', 'Virgo', 
                         'Libra', 'Scorpio', 'Sagittarius', 'Capricorn', 'Aquarius', 'Pisces'];
    
    for (const sign of zodiacSigns) {
      // Fetch horoscope from API
      // Store in Firestore with today's date
    }
  });
```

### 3. deleteExpiredVarshphal
**Trigger:** Scheduled (Every day at midnight)
**Purpose:** Delete expired Varshphal data

```javascript
exports.deleteExpiredVarshphal = functions.pubsub
  .schedule('0 0 * * *')
  .timeZone('Asia/Kolkata')
  .onRun(async (context) => {
    const today = new Date();
    const expiredDocs = await admin.firestore()
      .collection('varshphal_data')
      .where('validTill', '<', today)
      .get();
    
    const batch = admin.firestore().batch();
    expiredDocs.forEach(doc => batch.delete(doc.ref));
    await batch.commit();
  });
```

### 4. verifyPayment
**Trigger:** HTTP Call (from Razorpay webhook)
**Purpose:** Verify and process payment after successful Razorpay payment

```javascript
exports.verifyPayment = functions.https.onRequest(async (req, res) => {
  const { orderId, paymentId, signature } = req.body;
  
  // Verify Razorpay signature
  // Update booking status
  // Credit astrologer wallet
  // Send notifications
});
```

### 5. generateAgoraToken
**Trigger:** HTTP Call (before joining call)
**Purpose:** Generate Agora RTC token for voice/video calls

```javascript
exports.generateAgoraToken = functions.https.onCall(async (data, context) => {
  const { channelName, uid, role } = data;
  
  // Generate Agora token
  // Return token to client
});
```

### 6. processAstrologerPayout
**Trigger:** HTTP Call (from admin dashboard)
**Purpose:** Process payout request from astrologer

```javascript
exports.processAstrologerPayout = functions.https.onCall(async (data, context) => {
  // Verify admin role
  // Transfer funds to astrologer
  // Update wallet balance
  // Create transaction record
});
```

### 7. processReferralBonus
**Trigger:** Firestore Trigger (when new user signs up)
**Purpose:** Award referral bonus when referred user completes registration

```javascript
exports.processReferralBonus = functions.firestore
  .document('users/{userId}')
  .onCreate(async (snap, context) => {
    const userData = snap.data();
    if (userData.referredBy) {
      // Award bonus to referrer
      // Update wallet
    }
  });
```

### 8. sendBookingNotification
**Trigger:** Firestore Trigger (when booking is created)
**Purpose:** Send push notifications for new bookings

```javascript
exports.sendBookingNotification = functions.firestore
  .document('bookings/{bookingId}')
  .onCreate(async (snap, context) => {
    const booking = snap.data();
    
    // Get user and astrologer FCM tokens
    // Send notifications to both parties
  });
```

## Setup Instructions

1. Install Firebase CLI:
   ```bash
   npm install -g firebase-tools
   ```

2. Initialize Firebase Functions:
   ```bash
   firebase init functions
   ```

3. Install dependencies:
   ```bash
   cd functions
   npm install
   ```

4. Deploy functions:
   ```bash
   firebase deploy --only functions
   ```

## Environment Variables

Set these in Firebase Console:
- `ASTROLOGY_API_KEY`: Your astrology API key
- `RAZORPAY_KEY_SECRET`: Razorpay secret key
- `AGORA_APP_ID`: Agora application ID
- `AGORA_APP_CERTIFICATE`: Agora app certificate

