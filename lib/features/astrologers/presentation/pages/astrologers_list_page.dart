import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/professional_theme.dart';

class AstrologersListPage extends ConsumerStatefulWidget {
  const AstrologersListPage({super.key});

  @override
  ConsumerState<AstrologersListPage> createState() => _AstrologersListPageState();
}

class _AstrologersListPageState extends ConsumerState<AstrologersListPage> {
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, dynamic>> _astrologers = [
    {
      'id': '1',
      'name': 'Vedarsh',
      'specialty': 'Vedic',
      'experience': '8 years',
      'rate': 2,
      'languages': ['Hindi', 'English'],
      'imageUrl': null,
    },
    {
      'id': '2',
      'name': 'Vedarsh',
      'specialty': 'Vedic',
      'experience': '8 years',
      'rate': 2,
      'languages': ['Hindi', 'English'],
      'imageUrl': null,
    },
    {
      'id': '3',
      'name': 'Vedarsh',
      'specialty': 'Vedic',
      'experience': '8 years',
      'rate': 2,
      'languages': ['Hindi', 'English'],
      'imageUrl': null,
    },
    {
      'id': '4',
      'name': 'Vedarsh',
      'specialty': 'Vedic',
      'experience': '8 years',
      'rate': 2,
      'languages': ['Hindi', 'English'],
      'imageUrl': null,
    },
    {
      'id': '5',
      'name': 'Vedarsh',
      'specialty': 'Vedic',
      'experience': '8 years',
      'rate': 2,
      'languages': ['Hindi', 'English'],
      'imageUrl': null,
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
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
        child: Column(
          children: [
            // Header
            _buildHeader(context, isMobile, isTablet),

            // Search and Filter Bar
            _buildSearchAndFilter(context, isMobile, isTablet),

            const SizedBox(height: 8),

            // Astrologers List
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 16 : isTablet ? 24 : 32,
                  vertical: 8,
                ),
                itemCount: _astrologers.length,
                itemBuilder: (context, index) {
                  final astrologer = _astrologers[index];
                  return _buildAstrologerCard(
                    context,
                    astrologer,
                    isMobile,
                    isTablet,
                  );
                },
              ),
            ),

            // Footer
            _buildFooter(context, isMobile, isTablet),
          ],
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

  Widget _buildSearchAndFilter(
    BuildContext context,
    bool isMobile,
    bool isTablet,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : isTablet ? 24 : 32,
        vertical: 12,
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search Astrologers by name',
                hintStyle: TextStyle(
                  color: ProfessionalColors.textSecondary,
                  fontSize: isMobile ? 14 : 15,
                ),
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: ProfessionalColors.border,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: ProfessionalColors.border,
                  ),
                ),
                filled: true,
                fillColor: Colors.grey[50],
                contentPadding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 16 : 20,
                  vertical: isMobile ? 12 : 14,
                ),
              ),
              onChanged: (value) => setState(() {}),
            ),
          ),
          const SizedBox(width: 12),
          OutlinedButton(
            onPressed: () {
              // Show filter options
            },
            style: OutlinedButton.styleFrom(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 16 : 20,
                vertical: isMobile ? 12 : 14,
              ),
              side: BorderSide(color: ProfessionalColors.border),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text('Filter'),
          ),
          const SizedBox(width: 8),
          IconButton(
            icon: const Icon(Icons.star_border),
            onPressed: () {
              // Show favorites
            },
            color: ProfessionalColors.textPrimary,
          ),
        ],
      ),
    );
  }

  Widget _buildAstrologerCard(
    BuildContext context,
    Map<String, dynamic> astrologer,
    bool isMobile,
    bool isTablet,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
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
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Image Placeholder (Large gray square)
              Container(
                width: isMobile ? 80 : isTablet ? 100 : 120,
                height: isMobile ? 80 : isTablet ? 100 : 120,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.person,
                  size: isMobile ? 40 : isTablet ? 50 : 60,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(width: 16),

              // Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            astrologer['name'],
                            style: TextStyle(
                              fontSize: isMobile ? 16 : isTablet ? 18 : 20,
                              fontWeight: FontWeight.bold,
                              color: ProfessionalColors.textPrimary,
                            ),
                          ),
                        ),
                        Text(
                          '₹${astrologer['rate']}/min',
                          style: TextStyle(
                            fontSize: isMobile ? 14 : isTablet ? 16 : 18,
                            fontWeight: FontWeight.bold,
                            color: ProfessionalColors.textPrimary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      astrologer['specialty'],
                      style: TextStyle(
                        fontSize: isMobile ? 14 : 15,
                        color: ProfessionalColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      astrologer['languages'].join(', '),
                      style: TextStyle(
                        fontSize: isMobile ? 13 : 14,
                        color: ProfessionalColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Exp: ${astrologer['experience']}',
                      style: TextStyle(
                        fontSize: isMobile ? 13 : 14,
                        color: ProfessionalColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        onPressed: () {
                          // Start chat
                          context.push('/chat/new/${astrologer['id']}');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ProfessionalColors.primary,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(
                            horizontal: isMobile ? 24 : 28,
                            vertical: isMobile ? 10 : 12,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text('Chat'),
                      ),
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
            onPressed: () => context.go('/login'),
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

