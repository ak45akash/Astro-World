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
  String _selectedFilter = 'All';

  final List<Map<String, dynamic>> _astrologers = [
    {
      'id': '1',
      'name': 'Dr. Elena Petrova',
      'specialty': 'Vedic Astrology',
      'experience': '15+ Years',
      'rating': 4.9,
      'reviews': 1200,
      'price': 500,
      'imageUrl': 'https://randomuser.me/api/portraits/women/1.jpg',
      'isVerified': true,
      'languages': ['English', 'Hindi'],
      'availability': 'Available Now',
    },
    {
      'id': '2',
      'name': 'Prof. Rahul Sharma',
      'specialty': 'Tarot Reading',
      'experience': '12+ Years',
      'rating': 4.8,
      'reviews': 950,
      'price': 450,
      'imageUrl': 'https://randomuser.me/api/portraits/men/2.jpg',
      'isVerified': true,
      'languages': ['Hindi', 'English'],
      'availability': 'Available Now',
    },
    {
      'id': '3',
      'name': 'Ms. Anya Singh',
      'specialty': 'Numerology',
      'experience': '8+ Years',
      'rating': 4.7,
      'reviews': 800,
      'price': 400,
      'imageUrl': 'https://randomuser.me/api/portraits/women/3.jpg',
      'isVerified': false,
      'languages': ['English'],
      'availability': 'Available in 2 hours',
    },
    {
      'id': '4',
      'name': 'Mr. David Lee',
      'specialty': 'Palmistry',
      'experience': '10+ Years',
      'rating': 4.6,
      'reviews': 700,
      'price': 380,
      'imageUrl': 'https://randomuser.me/api/portraits/men/4.jpg',
      'isVerified': true,
      'languages': ['English', 'Chinese'],
      'availability': 'Available Now',
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: ProfessionalColors.background,
      appBar: AppBar(
        title: const Text('Astrologers'),
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search astrologers...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          setState(() {});
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: (value) => setState(() {}),
            ),
          ),

          // Filter Chips
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            height: 50,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: ['All', 'Vedic', 'Tarot', 'Numerology', 'Palmistry']
                  .map((filter) => Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: FilterChip(
                          label: Text(filter),
                          selected: _selectedFilter == filter,
                          onSelected: (selected) {
                            setState(() {
                              _selectedFilter = filter;
                            });
                          },
                          selectedColor: ProfessionalColors.primary,
                          checkmarkColor: ProfessionalColors.textLight,
                          labelStyle: TextStyle(
                            color: _selectedFilter == filter
                                ? ProfessionalColors.textLight
                                : ProfessionalColors.textPrimary,
                            fontWeight: _selectedFilter == filter
                                ? FontWeight.w600
                                : FontWeight.normal,
                          ),
                        ),
                      ))
                  .toList(),
            ),
          ),

          const SizedBox(height: 8),

          // Astrologers List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _astrologers.length,
              itemBuilder: (context, index) {
                final astrologer = _astrologers[index];
                return _buildAstrologerCard(context, astrologer);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAstrologerCard(BuildContext context, Map<String, dynamic> astrologer) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      child: InkWell(
        onTap: () {
          // Navigate to astrologer detail
          context.push('/astrologer/${astrologer['id']}');
        },
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Profile Image
              Stack(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: astrologer['imageUrl'] != null
                        ? NetworkImage(astrologer['imageUrl'])
                        : null,
                    child: astrologer['imageUrl'] == null
                        ? const Icon(Icons.person, size: 40)
                        : null,
                  ),
                  if (astrologer['isVerified'] == true)
                    Positioned(
                      bottom: 0,
                      right: 0,
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
              const SizedBox(width: 16),

              // Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            astrologer['name'],
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: ProfessionalColors.success.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            astrologer['availability'],
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: ProfessionalColors.success,
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${astrologer['specialty']} • ${astrologer['experience']}',
                      style: theme.textTheme.bodySmall,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.star, size: 16, color: Colors.amber),
                        const SizedBox(width: 4),
                        Text(
                          '${astrologer['rating']}',
                          style: theme.textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '(${astrologer['reviews']} reviews)',
                          style: theme.textTheme.bodySmall,
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '₹${astrologer['price']}/30 min',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: ProfessionalColors.success,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // Book consultation
                          },
                          child: const Text('Book Now'),
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
