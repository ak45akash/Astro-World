import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/professional_theme.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  late PageController _carouselController;
  int _currentCarouselIndex = 0;

  final List<Map<String, dynamic>> featuredAstrologers = [
    {
      'id': '1',
      'name': 'Sujata',
      'specialty': 'Vedic Astrology',
      'imageUrl': null,
    },
    {
      'id': '2',
      'name': 'Sujata',
      'specialty': 'Vedic Astrology',
      'imageUrl': null,
    },
    {
      'id': '3',
      'name': 'Sujata',
      'specialty': 'Vedic Astrology',
      'imageUrl': null,
    },
  ];

  final List<Map<String, dynamic>> astrologyServices = [
    {
      'icon': Icons.wb_sunny,
      'title': "Today's Horoscope",
    },
    {
      'icon': Icons.grid_view,
      'title': 'Free Kundli',
    },
    {
      'icon': Icons.favorite,
      'title': 'Compatibility',
    },
    {
      'icon': Icons.chat_bubble_outline,
      'title': 'Consultation',
    },
  ];

  @override
  void initState() {
    super.initState();
    _carouselController = PageController();
  }

  @override
  void dispose() {
    _carouselController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;
    final isTablet = screenWidth >= 600 && screenWidth < 1024;

    return Scaffold(
      backgroundColor: Colors.white,
      drawer: _buildDrawer(context, isMobile, isTablet),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Header
              _buildHeader(context, isMobile, isTablet),

              // Main Banner
              _buildBanner(context, isMobile, isTablet),

              const SizedBox(height: 24),

              // Quick Action Icons
              _buildQuickActions(context, isMobile, isTablet),

              const SizedBox(height: 32),

              // Astrology Services Section
              _buildAstrologyServices(context, isMobile, isTablet),

              const SizedBox(height: 32),

              // Our Astrologers Section
              _buildAstrologersSection(context, isMobile, isTablet),

              const SizedBox(height: 24),

              // Footer
              _buildFooter(context, isMobile, isTablet),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, bool isMobile, bool isTablet) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : isTablet ? 24 : 32,
        vertical: 12,
      ),
      decoration: const BoxDecoration(
        color: ProfessionalColors.primary,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: isMobile ? 40 : 48,
                height: isMobile ? 40 : 48,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    'A',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: isMobile ? 20 : 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'Astrotalk',
                style: TextStyle(
                  fontSize: isMobile ? 20 : 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBanner(BuildContext context, bool isMobile, bool isTablet) {
    final carouselItems = [
      {
        'title': 'Chat with',
        'subtitle': 'Astrologers',
        'icon': Icons.chat_bubble_outline,
        'gradient': [
          ProfessionalColors.primary,
          ProfessionalColors.primaryDark,
        ],
      },
      {
        'title': 'Talk to',
        'subtitle': 'Experts',
        'icon': Icons.phone,
        'gradient': [
          ProfessionalColors.primaryDark,
          ProfessionalColors.primary,
        ],
      },
      {
        'title': 'Get Your',
        'subtitle': 'Horoscope',
        'icon': Icons.wb_sunny,
        'gradient': [
          ProfessionalColors.primary,
          ProfessionalColors.primaryDark,
        ],
      },
    ];

    return Column(
      children: [
        SizedBox(
          height: isMobile ? 200 : isTablet ? 250 : 300,
          child: PageView.builder(
            controller: _carouselController,
            onPageChanged: (index) {
              setState(() {
                _currentCarouselIndex = index;
              });
            },
            itemCount: carouselItems.length,
            itemBuilder: (context, index) {
              final item = carouselItems[index];
              return Container(
                margin: EdgeInsets.symmetric(horizontal: isMobile ? 16 : isTablet ? 24 : 32),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: item['gradient'] as List<Color>,
                  ),
                ),
                child: Stack(
                  children: [
                    // Zodiac wheel background (simplified)
                    Positioned.fill(
                      child: Opacity(
                        opacity: 0.2,
                        child: CustomPaint(
                          painter: _ZodiacWheelPainter(),
                        ),
                      ),
                    ),
                    // Icon placeholder (left side)
                    Positioned(
                      left: isMobile ? 16 : 24,
                      bottom: 0,
                      child: Container(
                        width: isMobile ? 120 : isTablet ? 150 : 180,
                        height: isMobile ? 150 : isTablet ? 180 : 220,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          item['icon'] as IconData,
                          size: isMobile ? 80 : 100,
                          color: Colors.white.withOpacity(0.5),
                        ),
                      ),
                    ),
                    // Text overlay (right side)
                    Positioned(
                      right: isMobile ? 16 : 24,
                      top: isMobile ? 40 : 50,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            item['title'] as String,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: isMobile ? 24 : isTablet ? 28 : 32,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          Text(
                            item['subtitle'] as String,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: isMobile ? 32 : isTablet ? 40 : 48,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 12),
        // Carousel indicators
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            carouselItems.length,
            (index) => Container(
              width: _currentCarouselIndex == index ? 24 : 8,
              height: 8,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: _currentCarouselIndex == index
                    ? ProfessionalColors.primary
                    : ProfessionalColors.primary.withOpacity(0.3),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildQuickActions(BuildContext context, bool isMobile, bool isTablet) {
    final actions = [
      {
        'icon': Icons.chat_bubble_outline,
        'label': 'Chat with\nAstrologer',
      },
      {
        'icon': Icons.phone,
        'label': 'Talk to\nAstrologer',
      },
      {
        'icon': Icons.shopping_cart_outlined,
        'label': 'Astromall\nShop',
      },
      {
        'icon': Icons.menu_book,
        'label': 'Book a\nPooja',
      },
    ];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : isTablet ? 24 : 32),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: actions.map((action) {
          return _buildQuickActionIcon(
            context,
            icon: action['icon'] as IconData,
            label: action['label'] as String,
            isMobile: isMobile,
            isTablet: isTablet,
          );
        }).toList(),
      ),
    );
  }

  Widget _buildQuickActionIcon(
    BuildContext context, {
    required IconData icon,
    required String label,
    required bool isMobile,
    required bool isTablet,
  }) {
    return InkWell(
      onTap: () {
        // Handle action
      },
      borderRadius: BorderRadius.circular(12),
      child: Column(
        children: [
          Container(
            width: isMobile ? 60 : isTablet ? 70 : 80,
            height: isMobile ? 60 : isTablet ? 70 : 80,
            decoration: BoxDecoration(
              color: ProfessionalColors.primary,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: isMobile ? 28 : isTablet ? 32 : 36,
                        ),
                      ),
                      const SizedBox(height: 8),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: isMobile ? 11 : 12,
              color: ProfessionalColors.textPrimary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAstrologyServices(
    BuildContext context,
    bool isMobile,
    bool isTablet,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : isTablet ? 24 : 32),
          child: Text(
            'Astrology Services',
            style: TextStyle(
              fontSize: isMobile ? 18 : isTablet ? 20 : 22,
                              fontWeight: FontWeight.bold,
              color: ProfessionalColors.textPrimary,
            ),
                            ),
                      ),
                      const SizedBox(height: 16),
        isMobile
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 0.85,
                  ),
                  itemCount: astrologyServices.length,
                  itemBuilder: (context, index) {
                    final service = astrologyServices[index];
                    return _buildServiceCard(
                      context,
                      icon: service['icon'] as IconData,
                      title: service['title'] as String,
                      isMobile: isMobile,
                      isTablet: isTablet,
                      index: index,
                    );
                  },
                ),
              )
            : SizedBox(
                height: isTablet ? 140 : 160,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(horizontal: isTablet ? 24 : 32),
                  itemCount: astrologyServices.length,
                  itemBuilder: (context, index) {
                    final service = astrologyServices[index];
                    return _buildServiceCard(
                      context,
                      icon: service['icon'] as IconData,
                      title: service['title'] as String,
                      isMobile: isMobile,
                      isTablet: isTablet,
                      index: index,
                    );
                  },
                ),
              ),
      ],
    );
  }

  Widget _buildServiceCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required bool isMobile,
    required bool isTablet,
    required int index,
  }) {
    // Different gradient backgrounds for each service card
    final gradients = [
      [
        const Color(0xFFE8F5E9),
        const Color(0xFFC8E6C9),
      ], // Today's Horoscope - Light green
      [
        const Color(0xFFE1F5FE),
        const Color(0xFFB3E5FC),
      ], // Free Kundli - Light blue
      [
        const Color(0xFFFCE4EC),
        const Color(0xFFF8BBD0),
      ], // Compatibility - Light pink
      [
        const Color(0xFFFFF9C4),
        const Color(0xFFFFF59D),
      ], // Consultation - Light yellow
    ];

    final gradient = gradients[index % gradients.length];

    return Container(
      width: isMobile ? null : isTablet ? 120 : 140,
      margin: isMobile ? EdgeInsets.zero : const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: gradient,
        ),
        border: Border.all(
          color: ProfessionalColors.border.withOpacity(0.3),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Decorative pattern overlay
          Positioned.fill(
            child: Opacity(
              opacity: 0.1,
              child: CustomPaint(
                painter: _ServiceCardPatternPainter(),
              ),
            ),
          ),
          // Content
          InkWell(
            onTap: () {
              // Navigate to service
            },
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.7),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      icon,
                      size: isMobile ? 32 : isTablet ? 36 : 40,
                      color: ProfessionalColors.primary,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: isMobile ? 12 : 13,
                      color: ProfessionalColors.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAstrologersSection(
    BuildContext context,
    bool isMobile,
    bool isTablet,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : isTablet ? 24 : 32),
          child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                'Our Astrologers',
                style: TextStyle(
                  fontSize: isMobile ? 18 : isTablet ? 20 : 22,
                                  fontWeight: FontWeight.bold,
                  color: ProfessionalColors.textPrimary,
                                ),
                          ),
                          TextButton(
                onPressed: () => context.go('/astrologers'),
                            child: const Text(
                  'View all',
                  style: TextStyle(
                    color: ProfessionalColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                            ),
                          ),
                        ],
          ),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
          height: isMobile ? 140 : isTablet ? 160 : 180,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : isTablet ? 24 : 32),
            itemCount: featuredAstrologers.length,
                          itemBuilder: (context, index) {
              final astrologer = featuredAstrologers[index];
              return _buildAstrologerCard(
                context,
                astrologer: astrologer,
                isMobile: isMobile,
                isTablet: isTablet,
              );
            },
                                          ),
                                        ),
                                      ],
    );
  }

  Widget _buildAstrologerCard(
    BuildContext context, {
    required Map<String, dynamic> astrologer,
    required bool isMobile,
    required bool isTablet,
  }) {
    return Container(
      width: isMobile ? 100 : isTablet ? 120 : 140,
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: ProfessionalColors.border,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: InkWell(
        onTap: () {
          context.push('/astrologer/${astrologer['id']}');
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: EdgeInsets.all(isMobile ? 8 : 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: isMobile ? 28 : isTablet ? 32 : 36,
                backgroundColor: ProfessionalColors.primary.withOpacity(0.1),
                child: Icon(
                  Icons.person,
                  size: isMobile ? 28 : isTablet ? 32 : 36,
                  color: ProfessionalColors.primary,
                ),
              ),
              const SizedBox(height: 6),
              Flexible(
                child: Text(
                  astrologer['name'],
                  style: TextStyle(
                    fontSize: isMobile ? 12 : 13,
                    fontWeight: FontWeight.bold,
                    color: ProfessionalColors.textPrimary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 2),
              Flexible(
                child: Text(
                  astrologer['specialty'],
                  style: TextStyle(
                    fontSize: isMobile ? 10 : 11,
                    color: ProfessionalColors.textSecondary,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFooter(BuildContext context, bool isMobile, bool isTablet) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : isTablet ? 24 : 32,
        vertical: isMobile ? 20 : 24,
      ),
      decoration: const BoxDecoration(
        color: ProfessionalColors.primary,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
                  'Register your account',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: isMobile ? 14 : 16,
                    fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
                  'Login your account to start free trial now!',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: isMobile ? 12 : 13,
            ),
          ),
        ],
      ),
          ),
          const SizedBox(width: 16),
          ElevatedButton(
            onPressed: () {
              context.go('/login');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: ProfessionalColors.primary,
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 20 : 24,
                vertical: isMobile ? 12 : 14,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              'Login',
              style: TextStyle(
                fontSize: isMobile ? 14 : 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawer(BuildContext context, bool isMobile, bool isTablet) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: ProfessionalColors.primary,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Center(
                        child: Text(
                          'A',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      'Astrotalk',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home, color: ProfessionalColors.primary),
            title: const Text('Home'),
            onTap: () {
              Navigator.pop(context);
              context.go('/home');
            },
          ),
          ListTile(
            leading: const Icon(Icons.people, color: ProfessionalColors.primary),
            title: const Text('Astrologers'),
            onTap: () {
              Navigator.pop(context);
              context.go('/astrologers');
            },
          ),
          ListTile(
            leading: const Icon(Icons.calendar_today, color: ProfessionalColors.primary),
            title: const Text('Bookings'),
            onTap: () {
              Navigator.pop(context);
              context.go('/bookings');
            },
          ),
          ListTile(
            leading: const Icon(Icons.person, color: ProfessionalColors.primary),
            title: const Text('Profile'),
            onTap: () {
              Navigator.pop(context);
              context.go('/profile');
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text('Logout', style: TextStyle(color: Colors.red)),
            onTap: () {
              Navigator.pop(context);
              context.go('/login');
            },
          ),
        ],
      ),
    );
  }
}

// Custom painter for zodiac wheel background
class _ZodiacWheelPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width * 0.3;

    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    // Draw outer circle
    canvas.drawCircle(center, radius, paint);

    // Draw inner circle
    canvas.drawCircle(center, radius * 0.6, paint);

    // Draw lines dividing the circle
    for (int i = 0; i < 12; i++) {
      final angle = (i * 30 - 90) * math.pi / 180;
      final x1 = center.dx + radius * 0.6 * math.cos(angle);
      final y1 = center.dy + radius * 0.6 * math.sin(angle);
      final x2 = center.dx + radius * math.cos(angle);
      final y2 = center.dy + radius * math.sin(angle);
      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Custom painter for service card pattern background
class _ServiceCardPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = ProfessionalColors.primary
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    // Draw circular patterns
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width * 0.3;

    // Draw concentric circles
    canvas.drawCircle(center, radius, paint);
    canvas.drawCircle(center, radius * 0.6, paint);

    // Draw some decorative lines
    for (int i = 0; i < 8; i++) {
      final angle = (i * 45 - 90) * math.pi / 180;
      final x1 = center.dx + radius * 0.6 * math.cos(angle);
      final y1 = center.dy + radius * 0.6 * math.sin(angle);
      final x2 = center.dx + radius * math.cos(angle);
      final y2 = center.dy + radius * math.sin(angle);
      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
