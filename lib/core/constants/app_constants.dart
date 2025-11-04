class AppConstants {
  // API Keys (to be configured)
  static const String razorpayKeyId = 'YOUR_RAZORPAY_KEY_ID';
  static const String agoraAppId = 'YOUR_AGORA_APP_ID';
  static const String astrologyApiKey = 'YOUR_ASTROLOGY_API_KEY';
  static const String astrologyApiUrl = 'https://api.vedicrishiastro.com/v1';
  
  // User Roles
  static const String roleSuperAdmin = 'super_admin';
  static const String roleAdmin = 'admin';
  static const String roleAstrologer = 'astrologer';
  static const String roleContentCreator = 'content_creator';
  static const String roleEndUser = 'end_user';
  
  // Collections
  static const String collectionUsers = 'users';
  static const String collectionAstrologers = 'astrologers';
  static const String collectionBookings = 'bookings';
  static const String collectionChats = 'chats';
  static const String collectionHoroscopes = 'horoscopes';
  static const String collectionBlogs = 'blogs';
  static const String collectionPayments = 'payments';
  static const String collectionKundli = 'kundli_data';
  static const String collectionVarshphal = 'varshphal_data';
  static const String collectionAIQuestions = 'ai_questions';
  static const String collectionWallets = 'wallets';
  static const String collectionNotifications = 'notifications';
  
  // Storage Paths
  static const String storageProfileImages = 'profile_images';
  static const String storageKundliCharts = 'kundli_charts';
  static const String storageVarshphalCharts = 'varshphal_charts';
  static const String storageBlogImages = 'blog_images';
  static const String storageChatAttachments = 'chat_attachments';
  
  // Limits
  static const int freeAIQuestions = 3;
  static const int maxChatAttachmentSize = 10 * 1024 * 1024; // 10MB
  static const int varshphalValidityDays = 365;
  
  // Payment
  static const double minimumPayoutAmount = 100.0;
  static const double referralBonus = 50.0;
  
  // Pagination
  static const int itemsPerPage = 20;
}

