import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/professional_theme.dart';

class AstrologerDetailPage extends ConsumerStatefulWidget {
  final String astrologerId;

  const AstrologerDetailPage({
    super.key,
    required this.astrologerId,
  });

  @override
  ConsumerState<AstrologerDetailPage> createState() =>
      _AstrologerDetailPageState();
}

class _AstrologerDetailPageState extends ConsumerState<AstrologerDetailPage> {
  // Mock data - in real app, this would come from a provider/repository
  Map<String, dynamic>? _astrologer;

  @override
  void initState() {
    super.initState();
    _loadAstrologerData();
  }

  void _loadAstrologerData() {
    // Mock data - replace with actual API call
    setState(() {
      _astrologer = {
        'id': widget.astrologerId,
        'name': 'Vedarsh',
        'specialty': 'Vedic Astrology',
        'experience': '8 years',
        'rate': 2,
        'languages': ['Hindi', 'English'],
        'rating': 4.8,
        'reviews': 1250,
        'imageUrl': null,
        'description':
            'Expert in Vedic astrology with 8+ years of experience. Specializes in career guidance, relationship counseling, and financial predictions.',
        'skills': [
          'Career Guidance',
          'Relationship Counseling',
          'Financial Predictions',
          'Health Predictions',
        ],
        'availability': 'Available Now',
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;
    final isTablet = screenWidth >= 600 && screenWidth < 1024;

    if (_astrologer == null) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              _buildHeader(context, isMobile, isTablet),
              const Expanded(
                child: Center(
                  child: CircularProgressIndicator(
                    color: ProfessionalColors.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Teal Header with Back Button
            _buildHeader(context, isMobile, isTablet),

            // Astrologer Details
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Profile Section
                    _buildProfileSection(context, isMobile, isTablet),

                    // Details Section
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: isMobile ? 16 : isTablet ? 24 : 32,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 24),
                          _buildInfoCard(
                            context,
                            icon: Icons.star,
                            title: 'Rating',
                            value: '${_astrologer!['rating']} (${_astrologer!['reviews']} reviews)',
                            isMobile: isMobile,
                            isTablet: isTablet,
                          ),
                          const SizedBox(height: 12),
                          _buildInfoCard(
                            context,
                            icon: Icons.work_outline,
                            title: 'Experience',
                            value: _astrologer!['experience'],
                            isMobile: isMobile,
                            isTablet: isTablet,
                          ),
                          const SizedBox(height: 12),
                          _buildInfoCard(
                            context,
                            icon: Icons.language,
                            title: 'Languages',
                            value: (_astrologer!['languages'] as List).join(', '),
                            isMobile: isMobile,
                            isTablet: isTablet,
                          ),
                          const SizedBox(height: 12),
                          _buildInfoCard(
                            context,
                            icon: Icons.access_time,
                            title: 'Availability',
                            value: _astrologer!['availability'],
                            isMobile: isMobile,
                            isTablet: isTablet,
                          ),
                          const SizedBox(height: 24),
                          Text(
                            'About',
                            style: TextStyle(
                              fontSize: isMobile ? 18 : 20,
                              fontWeight: FontWeight.bold,
                              color: ProfessionalColors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            _astrologer!['description'],
                            style: TextStyle(
                              fontSize: isMobile ? 14 : 16,
                              color: ProfessionalColors.textSecondary,
                              height: 1.5,
                            ),
                          ),
                          const SizedBox(height: 24),
                          Text(
                            'Specializations',
                            style: TextStyle(
                              fontSize: isMobile ? 18 : 20,
                              fontWeight: FontWeight.bold,
                              color: ProfessionalColors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: (_astrologer!['skills'] as List)
                                .map<Widget>((skill) => Chip(
                                      label: Text(skill),
                                      backgroundColor:
                                          ProfessionalColors.primary.withOpacity(0.1),
                                      labelStyle: const TextStyle(
                                        color: ProfessionalColors.primary,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ))
                                .toList(),
                          ),
                          const SizedBox(height: 32),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Action Buttons
            _buildActionButtons(context, isMobile, isTablet),
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
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => context.pop(),
          ),
          const SizedBox(width: 8),
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
        ],
      ),
    );
  }

  Widget _buildProfileSection(
      BuildContext context, bool isMobile, bool isTablet) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : isTablet ? 24 : 32,
        vertical: 24,
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: isMobile ? 50 : 60,
            backgroundColor: Colors.grey[300],
            child: Icon(
              Icons.person,
              size: isMobile ? 50 : 60,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 16),
          Text(
            _astrologer!['name'],
            style: TextStyle(
              fontSize: isMobile ? 24 : 28,
              fontWeight: FontWeight.bold,
              color: ProfessionalColors.textPrimary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            _astrologer!['specialty'],
            style: TextStyle(
              fontSize: isMobile ? 16 : 18,
              color: ProfessionalColors.textSecondary,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: ProfessionalColors.primary,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '₹${_astrologer!['rate']}/min',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String value,
    required bool isMobile,
    required bool isTablet,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
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
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: ProfessionalColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: ProfessionalColors.primary,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: isMobile ? 12 : 13,
                    color: ProfessionalColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: isMobile ? 16 : 18,
                    fontWeight: FontWeight.bold,
                    color: ProfessionalColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(
      BuildContext context, bool isMobile, bool isTablet) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : isTablet ? 24 : 32,
        vertical: 16,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton.icon(
              onPressed: () {
                context.push('/chat/new/${_astrologer!['id']}');
              },
              icon: const Icon(Icons.chat_bubble_outline),
              label: const Text('Chat'),
              style: OutlinedButton.styleFrom(
                padding: EdgeInsets.symmetric(
                  vertical: isMobile ? 14 : 16,
                ),
                side: const BorderSide(
                  color: ProfessionalColors.primary,
                  width: 2,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                // Book consultation
              },
              icon: const Icon(Icons.phone),
              label: const Text('Call'),
              style: ElevatedButton.styleFrom(
                backgroundColor: ProfessionalColors.primary,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(
                  vertical: isMobile ? 14 : 16,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

