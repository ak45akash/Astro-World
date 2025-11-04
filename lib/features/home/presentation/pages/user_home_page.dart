import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/professional_theme.dart';

class UserHomePage extends ConsumerStatefulWidget {
  const UserHomePage({super.key});

  @override
  ConsumerState<UserHomePage> createState() => _UserHomePageState();
}

class _UserHomePageState extends ConsumerState<UserHomePage> {
  // Mock user data - in real app, this would come from user profile/state
  final String? _userZodiacSign = 'Taurus'; // null if user hasn't added DOB
  final bool _hasBirthDetails = true; // false if user hasn't added DOB

  final Map<String, Map<String, String>> _horoscopes = {
    'Aries': {
      'prediction': 'A day of new beginnings and opportunities. Your energy is high, making it perfect for starting new projects.',
      'luckyNumber': '7',
      'luckyColor': 'Red',
    },
    'Taurus': {
      'prediction': 'Focus on stability and comfort today. Financial matters look promising. Trust your instincts and stay grounded.',
      'luckyNumber': '4',
      'luckyColor': 'Green',
    },
    'Gemini': {
      'prediction': 'Communication is key today. Express your thoughts clearly and listen actively. Social connections bring positive energy.',
      'luckyNumber': '3',
      'luckyColor': 'Yellow',
    },
    'Cancer': {
      'prediction': 'Nurture your emotional well-being. Spend time with loved ones. Your intuition is strong today.',
      'luckyNumber': '2',
      'luckyColor': 'Silver',
    },
    'Leo': {
      'prediction': 'Shine bright and lead with confidence. Your charisma is at its peak. Take center stage.',
      'luckyNumber': '5',
      'luckyColor': 'Gold',
    },
    'Virgo': {
      'prediction': 'Attention to detail brings rewards. Organize and plan your day. Practical approach leads to success.',
      'luckyNumber': '6',
      'luckyColor': 'Brown',
    },
    'Libra': {
      'prediction': 'Seek balance and harmony in all areas of life. Relationships take center stage today.',
      'luckyNumber': '9',
      'luckyColor': 'Pink',
    },
    'Scorpio': {
      'prediction': 'Embrace transformation and deep connections. Your intensity serves you well today.',
      'luckyNumber': '8',
      'luckyColor': 'Maroon',
    },
    'Sagittarius': {
      'prediction': 'Adventure awaits. Explore new horizons and expand your knowledge. Optimism guides your path.',
      'luckyNumber': '5',
      'luckyColor': 'Purple',
    },
    'Capricorn': {
      'prediction': 'Hard work pays off. Focus on your goals and maintain discipline. Success is within reach.',
      'luckyNumber': '10',
      'luckyColor': 'Black',
    },
    'Aquarius': {
      'prediction': 'Innovate and connect with like-minded individuals. Your unique perspective is valued today.',
      'luckyNumber': '11',
      'luckyColor': 'Blue',
    },
    'Pisces': {
      'prediction': 'Trust your intuition and creative instincts. Compassion and empathy guide your actions.',
      'luckyNumber': '12',
      'luckyColor': 'Sea Green',
    },
  };

  final List<Map<String, dynamic>> featuredAstrologers = [
    {
      'id': '1',
      'name': 'Dr. Elena Petrova',
      'specialty': 'Vedic Astrology',
      'rating': 4.9,
      'reviews': 1200,
      'price': 500,
      'imageUrl': 'https://randomuser.me/api/portraits/women/1.jpg',
      'isVerified': true,
      'languages': ['English', 'Hindi'],
    },
    {
      'id': '2',
      'name': 'Prof. Rahul Sharma',
      'specialty': 'Tarot Reading',
      'rating': 4.8,
      'reviews': 950,
      'price': 450,
      'imageUrl': 'https://randomuser.me/api/portraits/men/2.jpg',
      'isVerified': true,
      'languages': ['Hindi', 'English'],
    },
    {
      'id': '3',
      'name': 'Ms. Anya Singh',
      'specialty': 'Numerology',
      'rating': 4.7,
      'reviews': 800,
      'price': 400,
      'imageUrl': 'https://randomuser.me/api/portraits/women/3.jpg',
      'isVerified': false,
      'languages': ['English'],
    },
  ];


  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: ProfessionalColors.background,
      appBar: AppBar(
        title: const Text('Astro World'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {
              // Navigate to notifications
            },
          ),
          IconButton(
            icon: const Icon(Icons.account_circle_outlined),
            onPressed: () => context.go('/profile'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: ProfessionalColors.primary,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome Back!',
                    style: theme.textTheme.headlineMedium?.copyWith(
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Discover your cosmic guidance today',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),

            // Daily Horoscope
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Your Daily Horoscope',
                    style: theme.textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 16),
                  _hasBirthDetails && _userZodiacSign != null
                      ? _buildUserHoroscopeCard(context, _userZodiacSign!)
                      : _buildAddBirthDetailsPrompt(context),
                ],
              ),
            ),

            // Quick Actions
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Quick Actions',
                    style: theme.textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 12),
                  Card(
                    child: Column(
                      children: [
                        _buildQuickActionListItem(
                          context,
                          icon: Icons.person_search,
                          title: 'Find Astrologer',
                          subtitle: 'Browse experts',
                          onTap: () => context.go('/astrologers'),
                        ),
                        const Divider(height: 1),
                        _buildQuickActionListItem(
                          context,
                          icon: Icons.calendar_today,
                          title: 'My Bookings',
                          subtitle: 'View appointments',
                          onTap: () => context.go('/bookings'),
                        ),
                        const Divider(height: 1),
                        _buildQuickActionListItem(
                          context,
                          icon: Icons.phone,
                          title: 'Call History',
                          subtitle: 'Past consultations',
                          onTap: () => context.go('/call-history'),
                        ),
                        const Divider(height: 1),
                        _buildQuickActionListItem(
                          context,
                          icon: Icons.wallet,
                          title: 'My Wallet',
                          subtitle: 'Balance & transactions',
                          onTap: () => context.go('/wallet'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // Featured Astrologers
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Featured Astrologers',
                        style: theme.textTheme.headlineMedium,
                      ),
                      TextButton(
                        onPressed: () => context.go('/astrologers'),
                        child: const Text('View All'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 250,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: featuredAstrologers.length,
                      itemBuilder: (context, index) {
                        final astrologer = featuredAstrologers[index];
                        return _buildAstrologerCard(context, astrologer);
                      },
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildUserHoroscopeCard(BuildContext context, String zodiacSign) {
    final theme = Theme.of(context);
    final horoscope = _horoscopes[zodiacSign];

    if (horoscope == null) {
      return _buildAddBirthDetailsPrompt(context);
    }

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: ProfessionalColors.accent.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.auto_awesome,
                    color: ProfessionalColors.accent,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        zodiacSign,
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Today\'s Prediction',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: ProfessionalColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              horoscope['prediction']!,
              style: theme.textTheme.bodyLarge,
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: _buildLuckyInfo(
                    context,
                    'Lucky Number',
                    horoscope['luckyNumber']!,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildLuckyInfo(
                    context,
                    'Lucky Color',
                    horoscope['luckyColor']!,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddBirthDetailsPrompt(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Icon(
              Icons.calendar_today_outlined,
              size: 48,
              color: ProfessionalColors.textSecondary,
            ),
            const SizedBox(height: 16),
            Text(
              'Personalize Your Horoscope',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Add your date of birth in your profile settings to receive personalized daily horoscope predictions tailored to your zodiac sign.',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: ProfessionalColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                context.go('/profile');
              },
              icon: const Icon(Icons.settings_outlined),
              label: const Text('Update Profile Settings'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLuckyInfo(BuildContext context, String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall,
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: ProfessionalColors.primary,
          ),
        ),
      ],
    );
  }

  Widget _buildQuickActionListItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: ProfessionalColors.primary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: ProfessionalColors.primary, size: 20),
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.chevron_right, color: ProfessionalColors.textSecondary),
      onTap: onTap,
    );
  }

  Widget _buildAstrologerCard(BuildContext context, Map<String, dynamic> astrologer) {
    final theme = Theme.of(context);

    return Container(
      width: 200,
      margin: const EdgeInsets.only(right: 16),
      child: Card(
        child: InkWell(
          onTap: () {
            // Navigate to astrologer profile
            context.push('/astrologer/${astrologer['id']}');
          },
          borderRadius: BorderRadius.circular(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image
              Container(
                height: 120,
                decoration: BoxDecoration(
                  color: ProfessionalColors.primary.withOpacity(0.1),
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(8),
                  ),
                ),
                child: Stack(
                  children: [
                    Center(
                      child: CircleAvatar(
                        radius: 40,
                        backgroundImage: astrologer['imageUrl'] != null
                            ? NetworkImage(astrologer['imageUrl'])
                            : null,
                        child: astrologer['imageUrl'] == null
                            ? const Icon(Icons.person, size: 40)
                            : null,
                      ),
                    ),
                    if (astrologer['isVerified'] == true)
                      Positioned(
                        top: 8,
                        right: 8,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: ProfessionalColors.success,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.verified,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      astrologer['name'],
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      astrologer['specialty'],
                      style: theme.textTheme.bodySmall,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          size: 16,
                          color: Colors.amber,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${astrologer['rating']}',
                          style: theme.textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '(${astrologer['reviews']})',
                          style: theme.textTheme.bodySmall,
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '₹${astrologer['price']}',
                          style: theme.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: ProfessionalColors.success,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // Book consultation
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 4,
                            ),
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: const Text('Book'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

