import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';
import '../../../../core/theme/professional_theme.dart';
import '../../../../core/providers/auth_provider.dart';
import '../../../../models/horoscope_model.dart';
import '../widgets/star_rating_widget.dart';
import '../widgets/energy_meter_widget.dart';
import '../widgets/tarot_card_widget.dart';

class TodaysHoroscopePage extends ConsumerStatefulWidget {
  final String? initialZodiacSign;
  
  const TodaysHoroscopePage({
    super.key,
    this.initialZodiacSign,
  });

  @override
  ConsumerState<TodaysHoroscopePage> createState() => _TodaysHoroscopePageState();
}

class _TodaysHoroscopePageState extends ConsumerState<TodaysHoroscopePage>
    with SingleTickerProviderStateMixin {
  final PageController _zodiacController = PageController();
  
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  
  String _selectedZodiac = 'Aries';
  DateTime _selectedDate = DateTime.now();
  HoroscopeModel? _currentHoroscope;
  bool _isLoading = false; // Changed to false - using dummy data
  bool _isBookmarked = false;
  String? _errorMessage;
  
  // Accordion states - all closed by default except Vedic Panchang
  bool _detailedPredictionsExpanded = false;
  bool _starRatingsExpanded = false;
  bool _luckyElementsExpanded = false;
  bool _dailyMantraExpanded = false;
  bool _todayAtGlanceExpanded = false;
  bool _planetaryInfluenceExpanded = false;
  bool _vedicDataExpanded = true; // Only this one open by default
  bool _energyMeterExpanded = false;

  final List<Map<String, dynamic>> _zodiacSigns = [
    {
      'name': 'Aries',
      'icon': '♈',
      'dateRange': 'Mar 21 - Apr 19',
      'imageUrl': 'https://images.unsplash.com/photo-1502134249126-9f3755a50d78?w=1200&h=600&fit=crop',
    },
    {
      'name': 'Taurus',
      'icon': '♉',
      'dateRange': 'Apr 20 - May 20',
      'imageUrl': 'https://images.unsplash.com/photo-1446776653964-20c1d3a81b06?w=1200&h=600&fit=crop',
    },
    {
      'name': 'Gemini',
      'icon': '♊',
      'dateRange': 'May 21 - Jun 20',
      'imageUrl': 'https://images.unsplash.com/photo-1462331940025-496dfbfc7564?w=1200&h=600&fit=crop',
    },
    {
      'name': 'Cancer',
      'icon': '♋',
      'dateRange': 'Jun 21 - Jul 22',
      'imageUrl': 'https://images.unsplash.com/photo-1506443432602-ac2fcd6f54e0?w=1200&h=600&fit=crop',
    },
    {
      'name': 'Leo',
      'icon': '♌',
      'dateRange': 'Jul 23 - Aug 22',
      'imageUrl': 'https://images.unsplash.com/photo-1518709268805-4e9042af2176?w=1200&h=600&fit=crop',
    },
    {
      'name': 'Virgo',
      'icon': '♍',
      'dateRange': 'Aug 23 - Sep 22',
      'imageUrl': 'https://images.unsplash.com/photo-1518837695005-2083093ee35b?w=1200&h=600&fit=crop',
    },
    {
      'name': 'Libra',
      'icon': '♎',
      'dateRange': 'Sep 23 - Oct 22',
      'imageUrl': 'https://images.unsplash.com/photo-1519389950473-47ba0277781c?w=1200&h=600&fit=crop',
    },
    {
      'name': 'Scorpio',
      'icon': '♏',
      'dateRange': 'Oct 23 - Nov 21',
      'imageUrl': 'https://images.unsplash.com/photo-1446776877081-d282a0f896e2?w=1200&h=600&fit=crop',
    },
    {
      'name': 'Sagittarius',
      'icon': '♐',
      'dateRange': 'Nov 22 - Dec 21',
      'imageUrl': 'https://images.unsplash.com/photo-1465101162946-4377e57745c3?w=1200&h=600&fit=crop',
    },
    {
      'name': 'Capricorn',
      'icon': '♑',
      'dateRange': 'Dec 22 - Jan 19',
      'imageUrl': 'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=1200&h=600&fit=crop',
    },
    {
      'name': 'Aquarius',
      'icon': '♒',
      'dateRange': 'Jan 20 - Feb 18',
      'imageUrl': 'https://images.unsplash.com/photo-1519681393784-d120267933ba?w=1200&h=600&fit=crop',
    },
    {
      'name': 'Pisces',
      'icon': '♓',
      'dateRange': 'Feb 19 - Mar 20',
      'imageUrl': 'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=1200&h=600&fit=crop',
    },
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    // Initialize with user's zodiac or default
    _initializeZodiac();
    _loadDummyHoroscope();
    _checkBookmark();
  }

  void _initializeZodiac() {
    // Use initial zodiac from route if provided
    if (widget.initialZodiacSign != null) {
      _selectedZodiac = widget.initialZodiacSign!;
      return;
    }
    
    // Try to get user's zodiac sign (will be set in build method)
    _selectedZodiac = 'Aries'; // Default fallback
  }

  @override
  void dispose() {
    _animationController.dispose();
    _zodiacController.dispose();
    super.dispose();
  }

  void _loadDummyHoroscope() {
    // Create dummy horoscope data for design preview
    _currentHoroscope = HoroscopeModel(
      id: 'dummy-${_selectedZodiac.toLowerCase()}',
      zodiacSign: _selectedZodiac,
      date: _selectedDate,
      prediction: 'Today brings new opportunities for ${_selectedZodiac}. The cosmic energies are aligned in your favor, creating a perfect moment for growth and transformation. Trust your instincts and embrace the changes that come your way. This is a time to focus on your goals and take decisive action.',
      love: 'Your relationships are highlighted today. Open communication will strengthen bonds with loved ones. Single ${_selectedZodiac}s may find new connections in unexpected places. Express your feelings authentically.',
      career: 'Professional growth is on the horizon. Take initiative and showcase your talents. A new opportunity may present itself. Your hard work is being recognized, and recognition is coming your way.',
      health: 'Focus on wellness and balance. Listen to your body\'s needs and take time for rest. Consider incorporating meditation or gentle exercise into your routine. Pay attention to your mental health as well.',
      finance: 'Financial decisions require careful consideration. Avoid impulsive spending today. A thoughtful approach to money matters will yield positive results. Consider long-term investments.',
      family: 'Family connections bring joy and support. Spend quality time with loved ones and strengthen your bonds. Your family may need your guidance or support today.',
      mood: 'Your emotional state is balanced and positive. Practice gratitude for inner peace. You\'re feeling optimistic about the future and ready to take on new challenges.',
      luck: 'Fortune favors the bold. Take calculated risks today. Your lucky number and color will bring you good fortune. Trust in the universe\'s plan for you.',
      spirituality: 'Connect with your inner self through meditation or reflection. Spiritual growth is emphasized today. Take time to contemplate your life\'s purpose and align with your higher self.',
      loveRating: 4,
      moodRating: 5,
      careerRating: 4,
      healthRating: 3,
      luckRating: 5,
      luckyNumber: [7, 14, 21, 28, 35][_zodiacSigns.indexWhere((z) => z['name'] == _selectedZodiac) % 5],
      luckyColor: ['Red', 'Blue', 'Green', 'Gold', 'Silver', 'Purple', 'Pink', 'Teal', 'Orange', 'Yellow', 'White', 'Black'][_zodiacSigns.indexWhere((z) => z['name'] == _selectedZodiac)],
      luckyTime: ['09:00 AM', '11:30 AM', '02:00 PM', '04:30 PM', '06:00 PM'][_zodiacSigns.indexWhere((z) => z['name'] == _selectedZodiac) % 5],
      luckyDirection: ['North', 'South', 'East', 'West', 'Northeast', 'Northwest', 'Southeast', 'Southwest'][_zodiacSigns.indexWhere((z) => z['name'] == _selectedZodiac) % 8],
      luckyStone: ['Diamond', 'Ruby', 'Emerald', 'Sapphire', 'Pearl', 'Coral', 'Topaz', 'Amethyst', 'Garnet', 'Opal', 'Aquamarine', 'Jade'][_zodiacSigns.indexWhere((z) => z['name'] == _selectedZodiac)],
      dailyMantra: 'Om ${_selectedZodiac} Namah - I am aligned with the cosmic energy of ${_selectedZodiac} and embrace today\'s opportunities with grace and wisdom.',
      affirmation: 'I am blessed with abundance, love, and success. Today, I attract positive energy and manifest my highest good. The universe supports my journey.',
      bestActivity: ['Meditation', 'Creative Work', 'Exercise', 'Socializing', 'Learning', 'Planning', 'Networking', 'Rest'][_zodiacSigns.indexWhere((z) => z['name'] == _selectedZodiac) % 8],
      avoidToday: ['Impulsive Decisions', 'Conflict', 'Overwork', 'Negativity', 'Procrastination', 'Gossip', 'Risky Investments'][_zodiacSigns.indexWhere((z) => z['name'] == _selectedZodiac) % 7],
      planetaryHighlight: '${['Sun', 'Moon', 'Mars', 'Mercury', 'Jupiter', 'Venus', 'Saturn'][_zodiacSigns.indexWhere((z) => z['name'] == _selectedZodiac) % 7]} is in favorable position, bringing ${['strong energy', 'emotional balance', 'action and determination', 'clear communication', 'wisdom and growth', 'love and harmony', 'discipline and structure'][_zodiacSigns.indexWhere((z) => z['name'] == _selectedZodiac) % 7]} to your life.',
      planetaryInfluence: {
        'Sun': 'Strong energy and vitality are with you today. Your confidence is high, and you\'re ready to shine.',
        'Moon': 'Emotional balance and intuition guide your decisions. Trust your feelings.',
        'Mars': 'Action and determination drive you forward. Channel this energy productively.',
        'Mercury': 'Clear communication and mental clarity support your endeavors.',
        'Jupiter': 'Wisdom and growth opportunities are abundant. Expand your horizons.',
        'Venus': 'Love and harmony surround you. Relationships flourish.',
        'Saturn': 'Discipline and structure help you achieve long-term goals.',
      },
      tithi: 'Dwitiya',
      nakshatra: ['Ashwini', 'Bharani', 'Krittika', 'Rohini', 'Mrigashira', 'Ardra', 'Punarvasu', 'Pushya', 'Ashlesha', 'Magha', 'Purva Phalguni', 'Uttara Phalguni'][_zodiacSigns.indexWhere((z) => z['name'] == _selectedZodiac)],
      yoga: 'Vajra',
      karana: 'Bava',
      rahuKalam: '07:30 - 09:00',
      gulikaKalam: '10:30 - 12:00',
      yamagandaKalam: '13:30 - 15:00',
      tarotCardName: ['The Fool', 'The Magician', 'The High Priestess', 'The Empress', 'The Emperor', 'The Hierophant', 'The Lovers', 'The Chariot', 'Strength', 'The Hermit', 'Wheel of Fortune', 'Justice'][_zodiacSigns.indexWhere((z) => z['name'] == _selectedZodiac)],
      tarotCardMeaning: 'This card represents new beginnings, fresh perspectives, and the courage to step into the unknown. Trust in the journey ahead and embrace the opportunities that come your way. Your intuition will guide you to make the right decisions.',
      tarotCardImageUrl: 'https://images.unsplash.com/photo-1502134249126-9f3755a50d78?w=400&h=600&fit=crop',
      morningEnergy: 7,
      afternoonEnergy: 5,
      eveningEnergy: 8,
      dateRange: _zodiacSigns.firstWhere((z) => z['name'] == _selectedZodiac)['dateRange'] as String,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    if (mounted) {
      setState(() {
        _isLoading = false;
        _errorMessage = null;
      });
      _animationController.forward(from: 0);
    }
  }

  Future<void> _checkBookmark() async {
    // Check if horoscope is bookmarked
    // Implementation depends on your bookmarking system
  }

  Future<void> _toggleBookmark() async {
    setState(() {
      _isBookmarked = !_isBookmarked;
    });
    // Save bookmark to Firestore
  }

  Future<void> _shareHoroscope() async {
    if (_currentHoroscope == null) return;
    
    final text = '''
🌟 ${_selectedZodiac} Daily Horoscope - ${_formatDate(_selectedDate)}

${_currentHoroscope!.prediction}

Download Astrotalk App for more insights!
''';
    
    await Share.share(text);
  }

  void _navigateDate(int days) {
    setState(() {
      _selectedDate = _selectedDate.add(Duration(days: days));
    });
    _loadDummyHoroscope();
  }

  String _formatDate(DateTime date) {
    return '${_getMonthName(date.month)} ${date.day}, ${date.year}';
  }

  String _getMonthName(int month) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return months[month - 1];
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;
    final isTablet = screenWidth >= 600 && screenWidth < 1024;
    
    // Get user's zodiac sign if available
    final authState = ref.watch(authStateProvider);
    authState.whenData((user) {
      if (user?.zodiacSign != null && 
          widget.initialZodiacSign == null && 
          _selectedZodiac == 'Aries') {
        final userZodiac = user!.zodiacSign!;
        // Validate zodiac sign exists in our list
        if (_zodiacSigns.any((z) => z['name'] == userZodiac)) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted && _selectedZodiac != userZodiac) {
              setState(() {
                _selectedZodiac = userZodiac;
                // Update carousel position
                final index = _zodiacSigns.indexWhere((z) => z['name'] == userZodiac);
                if (index >= 0) {
                  _zodiacController.animateToPage(
                    index,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                }
              });
              _loadDummyHoroscope();
            }
          });
        }
      }
    });

    return Scaffold(
      backgroundColor: Colors.white,
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _errorMessage != null
              ? SafeArea(child: _buildErrorState(isMobile, isTablet))
              : FadeTransition(
                  opacity: _fadeAnimation,
                  child: CustomScrollView(
                    slivers: [
                      // Shrinking Header with Hero Banner
                      _buildSliverAppBar(context, isMobile, isTablet),
                      // Zodiac and Date Selection Dropdowns
                      SliverToBoxAdapter(
                        child: _buildSelectionDropdowns(isMobile, isTablet),
                      ),
                      // Content
                      SliverPadding(
                        padding: const EdgeInsets.only(top: 24),
                        sliver: SliverList(
                          delegate: SliverChildListDelegate([
                            // Daily Prediction at the top (no accordion)
                            _buildDailyPrediction(isMobile, isTablet),
                            const SizedBox(height: 24),
                            // Vedic Panchang
                            _buildVedicData(isMobile, isTablet),
                            const SizedBox(height: 24),
                            _buildSectionedPredictions(isMobile, isTablet),
                            const SizedBox(height: 24),
                            _buildStarRatings(isMobile, isTablet),
                            const SizedBox(height: 24),
                            _buildLuckyElements(isMobile, isTablet),
                            const SizedBox(height: 24),
                            _buildDailyMantra(isMobile, isTablet),
                            const SizedBox(height: 24),
                            _buildTodayAtGlance(isMobile, isTablet),
                            const SizedBox(height: 24),
                            _buildPlanetaryInfluence(isMobile, isTablet),
                            const SizedBox(height: 24),
                            if (_currentHoroscope?.tarotCardName != null)
                              _buildTarotCard(isMobile, isTablet),
                            const SizedBox(height: 24),
                            if (_currentHoroscope?.morningEnergy != null)
                              _buildEnergyMeterAccordion(isMobile, isTablet),
                            const SizedBox(height: 24),
                            _buildNavigationButtons(isMobile, isTablet),
                            const SizedBox(height: 24),
                            _buildCTASection(isMobile, isTablet),
                            const SizedBox(height: 24),
                          ]),
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }

  Widget _buildErrorState(bool isMobile, bool isTablet) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(isMobile ? 16 : 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: ProfessionalColors.error,
            ),
            const SizedBox(height: 16),
            Text(
              _errorMessage ?? 'Something went wrong',
              style: TextStyle(
                fontSize: isMobile ? 16 : 18,
                color: ProfessionalColors.textPrimary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _loadDummyHoroscope,
              style: ElevatedButton.styleFrom(
                backgroundColor: ProfessionalColors.primary,
                foregroundColor: Colors.white,
              ),
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSliverAppBar(BuildContext context, bool isMobile, bool isTablet) {
    final currentZodiac = _zodiacSigns.firstWhere(
      (z) => z['name'] == _selectedZodiac,
      orElse: () => _zodiacSigns[0],
    );
    final backgroundImage = currentZodiac['imageUrl'] as String?;

    return SliverAppBar(
      expandedHeight: isMobile ? 280 : 320,
      floating: false,
      pinned: true,
      snap: false,
      backgroundColor: ProfessionalColors.primary,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () {
          if (context.canPop()) {
            context.pop();
          } else {
            context.go('/home');
          }
        },
      ),
      actions: [
        IconButton(
          icon: Icon(
            _isBookmarked ? Icons.bookmark : Icons.bookmark_border,
            color: Colors.white,
          ),
          onPressed: _toggleBookmark,
        ),
        IconButton(
          icon: const Icon(Icons.share, color: Colors.white),
          onPressed: _shareHoroscope,
        ),
      ],
      flexibleSpace: LayoutBuilder(
        builder: (context, constraints) {
          // Show title only when collapsed (when height is near minimum)
          final isCollapsed = constraints.maxHeight <= (isMobile ? 100 : 120);
          
          return FlexibleSpaceBar(
            titlePadding: EdgeInsets.zero,
            centerTitle: true,
            title: isCollapsed
                ? Container(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${_selectedZodiac}'s Today's Horoscope",
                          style: TextStyle(
                            fontSize: isMobile ? 16 : 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          _formatDate(_selectedDate),
                          style: TextStyle(
                            fontSize: isMobile ? 12 : 14,
                            color: Colors.white.withOpacity(0.9),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  )
                : const SizedBox.shrink(),
            background: Stack(
              fit: StackFit.expand,
              children: [
                // Background Image
                if (backgroundImage != null)
                  Image.network(
                    backgroundImage,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              ProfessionalColors.primary,
                              ProfessionalColors.primaryDark,
                            ],
                          ),
                        ),
                      );
                    },
                  )
                else
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          ProfessionalColors.primary,
                          ProfessionalColors.primaryDark,
                        ],
                      ),
                    ),
                  ),
                // Dark overlay for better text visibility
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withOpacity(0.3),
                        Colors.black.withOpacity(0.6),
                      ],
                    ),
                  ),
                ),
                // Title overlay - Only shown when hero is expanded (hidden when collapsed)
                LayoutBuilder(
                  builder: (context, innerConstraints) {
                    // Show title only when expanded (when height is near expandedHeight)
                    final isExpanded = innerConstraints.maxHeight > (isMobile ? 200 : 240);
                    if (!isExpanded) return const SizedBox.shrink();
                    
                    return Positioned(
                      left: 0,
                      right: 0,
                      bottom: isMobile ? 60 : 70,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "${_selectedZodiac}'s Today's Horoscope",
                            style: TextStyle(
                              fontSize: isMobile ? 22 : 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '(${_formatDate(_selectedDate)})',
                            style: TextStyle(
                              fontSize: isMobile ? 14 : 16,
                              color: Colors.white.withOpacity(0.9),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSelectionDropdowns(bool isMobile, bool isTablet) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : isTablet ? 24 : 32,
        vertical: 16,
      ),
      child: Row(
        children: [
          // Zodiac Dropdown
          Expanded(
            child: Container(
              height: isMobile ? 48 : 52, // Fixed height to match date selector
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 12 : 16,
                vertical: 4,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: ProfessionalColors.border,
                  width: 1,
                ),
              ),
              child: DropdownButton<String>(
                value: _selectedZodiac,
                isExpanded: true,
                underline: const SizedBox.shrink(),
                dropdownColor: Colors.white,
                icon: Icon(
                  Icons.arrow_drop_down,
                  color: ProfessionalColors.primary,
                ),
                style: TextStyle(
                  fontSize: isMobile ? 14 : 16,
                  color: ProfessionalColors.textPrimary,
                ),
                items: _zodiacSigns.map((zodiac) {
                  return DropdownMenuItem<String>(
                    value: zodiac['name'] as String,
                    child: Row(
                      children: [
                        Text(
                          zodiac['icon'] as String,
                          style: TextStyle(fontSize: isMobile ? 16 : 18),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          zodiac['name'] as String,
                          style: TextStyle(
                            color: ProfessionalColors.textPrimary,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  if (newValue != null && newValue != _selectedZodiac) {
                    setState(() {
                      _selectedZodiac = newValue;
                      // Update carousel position
                      final index = _zodiacSigns.indexWhere((z) => z['name'] == newValue);
                      if (index >= 0) {
                        _zodiacController.animateToPage(
                          index,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      }
                    });
                    _loadDummyHoroscope();
                  }
                },
              ),
            ),
          ),
          const SizedBox(width: 12),
          // Date Dropdown
          Expanded(
            child: Container(
              height: isMobile ? 48 : 52, // Fixed height to match zodiac selector
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 12 : 16,
                vertical: 4,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: ProfessionalColors.border,
                  width: 1,
                ),
              ),
              child: InkWell(
                onTap: () async {
                  final pickedDate = await showDatePicker(
                    context: context,
                    initialDate: _selectedDate,
                    firstDate: DateTime.now().subtract(const Duration(days: 365)),
                    lastDate: DateTime.now().add(const Duration(days: 365)),
                    builder: (context, child) {
                      return Theme(
                        data: Theme.of(context).copyWith(
                          colorScheme: ColorScheme.light(
                            primary: ProfessionalColors.primary,
                            onPrimary: Colors.white,
                            surface: Colors.white,
                            onSurface: ProfessionalColors.textPrimary,
                          ),
                        ),
                        child: child!,
                      );
                    },
                  );
                  if (pickedDate != null && pickedDate != _selectedDate) {
                    setState(() {
                      _selectedDate = pickedDate;
                    });
                    _loadDummyHoroscope();
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_today,
                          size: 18,
                          color: ProfessionalColors.primary,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          _formatDate(_selectedDate),
                          style: TextStyle(
                            fontSize: isMobile ? 14 : 16,
                            color: ProfessionalColors.textPrimary,
                          ),
                        ),
                      ],
                    ),
                    Icon(
                      Icons.arrow_drop_down,
                      color: ProfessionalColors.primary,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildDailyPrediction(bool isMobile, bool isTablet) {
    if (_currentHoroscope == null) return const SizedBox.shrink();
    
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : isTablet ? 24 : 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: ProfessionalColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.wb_sunny,
                  color: ProfessionalColors.primary,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'Daily Prediction',
                style: TextStyle(
                  fontSize: isMobile ? 18 : 20,
                  fontWeight: FontWeight.bold,
                  color: ProfessionalColors.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            _currentHoroscope!.prediction,
            style: TextStyle(
              fontSize: isMobile ? 14 : 16,
              color: ProfessionalColors.textPrimary,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionedPredictions(bool isMobile, bool isTablet) {
    if (_currentHoroscope == null) return const SizedBox.shrink();
    
    final sections = [
      if (_currentHoroscope!.love != null)
        {'title': 'Love', 'icon': Icons.favorite, 'text': _currentHoroscope!.love!},
      if (_currentHoroscope!.career != null)
        {'title': 'Career', 'icon': Icons.work, 'text': _currentHoroscope!.career!},
      if (_currentHoroscope!.finance != null)
        {'title': 'Finance', 'icon': Icons.account_balance_wallet, 'text': _currentHoroscope!.finance!},
      if (_currentHoroscope!.health != null)
        {'title': 'Health', 'icon': Icons.favorite_border, 'text': _currentHoroscope!.health!},
      if (_currentHoroscope!.family != null)
        {'title': 'Family', 'icon': Icons.family_restroom, 'text': _currentHoroscope!.family!},
      if (_currentHoroscope!.mood != null)
        {'title': 'Mood', 'icon': Icons.mood, 'text': _currentHoroscope!.mood!},
      if (_currentHoroscope!.luck != null)
        {'title': 'Luck', 'icon': Icons.stars, 'text': _currentHoroscope!.luck!},
      if (_currentHoroscope!.spirituality != null)
        {'title': 'Spirituality', 'icon': Icons.self_improvement, 'text': _currentHoroscope!.spirituality!},
    ];

    return Container(
      margin: EdgeInsets.symmetric(horizontal: isMobile ? 16 : isTablet ? 24 : 32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent,
          iconTheme: const IconThemeData(color: ProfessionalColors.textSecondary),
        ),
        child: ExpansionTile(
          initiallyExpanded: _detailedPredictionsExpanded,
          onExpansionChanged: (expanded) {
            setState(() {
              _detailedPredictionsExpanded = expanded;
            });
          },
          leading: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: ProfessionalColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.list,
              color: ProfessionalColors.primary,
              size: 24,
            ),
          ),
          title: Text(
            'Detailed Predictions',
            style: TextStyle(
              fontSize: isMobile ? 18 : 20,
              fontWeight: FontWeight.bold,
              color: ProfessionalColors.textPrimary,
            ),
          ),
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : 20, vertical: 8),
              child: Column(
                children: sections.map((section) => _buildPredictionItem(
                  section['title'] as String,
                  section['icon'] as IconData,
                  section['text'] as String,
                  isMobile,
                  isTablet,
                )).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPredictionItem(
    String title,
    IconData icon,
    String text,
    bool isMobile,
    bool isTablet,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: ProfessionalColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  icon,
                  color: ProfessionalColors.primary,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: TextStyle(
                  fontSize: isMobile ? 16 : 18,
                  fontWeight: FontWeight.bold,
                  color: ProfessionalColors.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            text,
            style: TextStyle(
              fontSize: isMobile ? 14 : 15,
              color: ProfessionalColors.textSecondary,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStarRatings(bool isMobile, bool isTablet) {
    if (_currentHoroscope == null) return const SizedBox.shrink();
    
    final ratings = [
      if (_currentHoroscope!.loveRating != null)
        {'label': 'Love', 'rating': _currentHoroscope!.loveRating!},
      if (_currentHoroscope!.moodRating != null)
        {'label': 'Mood', 'rating': _currentHoroscope!.moodRating!},
      if (_currentHoroscope!.careerRating != null)
        {'label': 'Career', 'rating': _currentHoroscope!.careerRating!},
      if (_currentHoroscope!.healthRating != null)
        {'label': 'Health', 'rating': _currentHoroscope!.healthRating!},
      if (_currentHoroscope!.luckRating != null)
        {'label': 'Luck', 'rating': _currentHoroscope!.luckRating!},
    ];

    if (ratings.isEmpty) return const SizedBox.shrink();

    return Container(
      margin: EdgeInsets.symmetric(horizontal: isMobile ? 16 : isTablet ? 24 : 32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent,
          iconTheme: const IconThemeData(color: ProfessionalColors.textSecondary),
        ),
        child: ExpansionTile(
          initiallyExpanded: _starRatingsExpanded,
          onExpansionChanged: (expanded) {
            setState(() {
              _starRatingsExpanded = expanded;
            });
          },
          leading: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: ProfessionalColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.star,
              color: ProfessionalColors.primary,
              size: 24,
            ),
          ),
          title: Text(
            'Today\'s Ratings',
            style: TextStyle(
              fontSize: isMobile ? 18 : 20,
              fontWeight: FontWeight.bold,
              color: ProfessionalColors.textPrimary,
            ),
          ),
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : 20, vertical: 8),
              child: Column(
                children: ratings.map((rating) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        rating['label'] as String,
                        style: TextStyle(
                          fontSize: isMobile ? 14 : 16,
                          color: ProfessionalColors.textPrimary,
                        ),
                      ),
                      StarRatingWidget(
                        rating: rating['rating'] as int,
                        size: isMobile ? 16 : 18,
                      ),
                    ],
                  ),
                )).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLuckyElements(bool isMobile, bool isTablet) {
    if (_currentHoroscope == null) return const SizedBox.shrink();
    
    return Container(
      margin: EdgeInsets.symmetric(horizontal: isMobile ? 16 : isTablet ? 24 : 32),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            ProfessionalColors.primary.withOpacity(0.1),
            ProfessionalColors.primaryDark.withOpacity(0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent,
          iconTheme: const IconThemeData(color: ProfessionalColors.textSecondary),
        ),
        child: ExpansionTile(
          initiallyExpanded: _luckyElementsExpanded,
          onExpansionChanged: (expanded) {
            setState(() {
              _luckyElementsExpanded = expanded;
            });
          },
          leading: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: ProfessionalColors.primary,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.stars,
              color: Colors.white,
              size: 24,
            ),
          ),
          title: Text(
            'Lucky Elements',
            style: TextStyle(
              fontSize: isMobile ? 18 : 20,
              fontWeight: FontWeight.bold,
              color: ProfessionalColors.textPrimary,
            ),
          ),
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : 20, vertical: 8),
              child: Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  _buildLuckyItem('Number', _currentHoroscope!.luckyNumber.toString(), Icons.numbers),
                  _buildLuckyItem('Color', _currentHoroscope!.luckyColor, Icons.palette),
                  if (_currentHoroscope!.luckyTime != null)
                    _buildLuckyItem('Time', _currentHoroscope!.luckyTime!, Icons.access_time),
                  if (_currentHoroscope!.luckyDirection != null)
                    _buildLuckyItem('Direction', _currentHoroscope!.luckyDirection!, Icons.explore),
                  if (_currentHoroscope!.luckyStone != null)
                    _buildLuckyItem('Stone', _currentHoroscope!.luckyStone!, Icons.diamond),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLuckyItem(String label, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: ProfessionalColors.border,
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 20, color: ProfessionalColors.primary),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: ProfessionalColors.textSecondary,
                ),
              ),
              Text(
                value,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: ProfessionalColors.textPrimary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDailyMantra(bool isMobile, bool isTablet) {
    if (_currentHoroscope == null ||
        (_currentHoroscope!.dailyMantra == null &&
            _currentHoroscope!.affirmation == null)) {
      return const SizedBox.shrink();
    }
    
    return Container(
      margin: EdgeInsets.symmetric(horizontal: isMobile ? 16 : isTablet ? 24 : 32),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            ProfessionalColors.primary,
            ProfessionalColors.primaryDark,
          ],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent,
          iconTheme: const IconThemeData(color: ProfessionalColors.textSecondary),
        ),
        child: ExpansionTile(
          initiallyExpanded: _dailyMantraExpanded,
          onExpansionChanged: (expanded) {
            setState(() {
              _dailyMantraExpanded = expanded;
            });
          },
          leading: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.self_improvement,
              color: Colors.white,
              size: 24,
            ),
          ),
          title: Text(
            'Daily Mantra',
            style: TextStyle(
              fontSize: isMobile ? 18 : 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : 20, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (_currentHoroscope!.dailyMantra != null) ...[
                    Text(
                      _currentHoroscope!.dailyMantra!,
                      style: TextStyle(
                        fontSize: isMobile ? 16 : 18,
                        color: Colors.white,
                        fontStyle: FontStyle.italic,
                        height: 1.6,
                      ),
                    ),
                    if (_currentHoroscope!.affirmation != null) const SizedBox(height: 12),
                  ],
                  if (_currentHoroscope!.affirmation != null)
                    Text(
                      _currentHoroscope!.affirmation!,
                      style: TextStyle(
                        fontSize: isMobile ? 14 : 16,
                        color: Colors.white.withOpacity(0.9),
                        height: 1.5,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTodayAtGlance(bool isMobile, bool isTablet) {
    if (_currentHoroscope == null ||
        (_currentHoroscope!.bestActivity == null &&
            _currentHoroscope!.avoidToday == null &&
            _currentHoroscope!.planetaryHighlight == null)) {
      return const SizedBox.shrink();
    }
    
    return Container(
      margin: EdgeInsets.symmetric(horizontal: isMobile ? 16 : isTablet ? 24 : 32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent,
          iconTheme: const IconThemeData(color: ProfessionalColors.textSecondary),
        ),
        child: ExpansionTile(
          initiallyExpanded: _todayAtGlanceExpanded,
          onExpansionChanged: (expanded) {
            setState(() {
              _todayAtGlanceExpanded = expanded;
            });
          },
          leading: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: ProfessionalColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.today,
              color: ProfessionalColors.primary,
              size: 24,
            ),
          ),
          title: Text(
            'Today at a Glance',
            style: TextStyle(
              fontSize: isMobile ? 18 : 20,
              fontWeight: FontWeight.bold,
              color: ProfessionalColors.textPrimary,
            ),
          ),
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : 20, vertical: 8),
              child: Column(
                children: [
                  if (_currentHoroscope!.bestActivity != null)
                    _buildGlanceItem(
                      'Best Activity',
                      _currentHoroscope!.bestActivity!,
                      Icons.check_circle,
                      ProfessionalColors.success,
                      isMobile,
                    ),
                  if (_currentHoroscope!.avoidToday != null) ...[
                    const SizedBox(height: 12),
                    _buildGlanceItem(
                      'Avoid Today',
                      _currentHoroscope!.avoidToday!,
                      Icons.cancel,
                      ProfessionalColors.error,
                      isMobile,
                    ),
                  ],
                  if (_currentHoroscope!.planetaryHighlight != null) ...[
                    const SizedBox(height: 12),
                    _buildGlanceItem(
                      'Planetary Highlight',
                      _currentHoroscope!.planetaryHighlight!,
                      Icons.star,
                      ProfessionalColors.warning,
                      isMobile,
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGlanceItem(
    String label,
    String value,
    IconData icon,
    Color color,
    bool isMobile,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: isMobile ? 12 : 13,
                  color: ProfessionalColors.textSecondary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: TextStyle(
                  fontSize: isMobile ? 14 : 15,
                  color: ProfessionalColors.textPrimary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPlanetaryInfluence(bool isMobile, bool isTablet) {
    if (_currentHoroscope == null ||
        _currentHoroscope!.planetaryInfluence == null ||
        _currentHoroscope!.planetaryInfluence!.isEmpty) {
      return const SizedBox.shrink();
    }
    
    return Container(
      margin: EdgeInsets.symmetric(horizontal: isMobile ? 16 : isTablet ? 24 : 32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent,
          iconTheme: const IconThemeData(color: ProfessionalColors.textSecondary),
        ),
        child: ExpansionTile(
          initiallyExpanded: _planetaryInfluenceExpanded,
          onExpansionChanged: (expanded) {
            setState(() {
              _planetaryInfluenceExpanded = expanded;
            });
          },
          leading: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: ProfessionalColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.wb_sunny,
              color: ProfessionalColors.primary,
              size: 24,
            ),
          ),
          title: Text(
            'Planetary Influence',
            style: TextStyle(
              fontSize: isMobile ? 18 : 20,
              fontWeight: FontWeight.bold,
              color: ProfessionalColors.textPrimary,
            ),
          ),
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : 20, vertical: 8),
              child: Column(
                children: _currentHoroscope!.planetaryInfluence!.entries.map((entry) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: ProfessionalColors.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          entry.key,
                          style: TextStyle(
                            fontSize: isMobile ? 12 : 13,
                            fontWeight: FontWeight.bold,
                            color: ProfessionalColors.primary,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          entry.value,
                          style: TextStyle(
                            fontSize: isMobile ? 14 : 15,
                            color: ProfessionalColors.textPrimary,
                          ),
                        ),
                      ),
                    ],
                  ),
                )).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVedicData(bool isMobile, bool isTablet) {
    if (_currentHoroscope == null) return const SizedBox.shrink();
    
    final vedicItems = [
      if (_currentHoroscope!.tithi != null)
        {'label': 'Tithi', 'value': _currentHoroscope!.tithi!},
      if (_currentHoroscope!.nakshatra != null)
        {'label': 'Nakshatra', 'value': _currentHoroscope!.nakshatra!},
      if (_currentHoroscope!.yoga != null)
        {'label': 'Yoga', 'value': _currentHoroscope!.yoga!},
      if (_currentHoroscope!.karana != null)
        {'label': 'Karana', 'value': _currentHoroscope!.karana!},
      if (_currentHoroscope!.rahuKalam != null)
        {'label': 'Rahu Kalam', 'value': _currentHoroscope!.rahuKalam!},
      if (_currentHoroscope!.gulikaKalam != null)
        {'label': 'Gulika Kalam', 'value': _currentHoroscope!.gulikaKalam!},
      if (_currentHoroscope!.yamagandaKalam != null)
        {'label': 'Yamaganda Kalam', 'value': _currentHoroscope!.yamagandaKalam!},
    ];

    if (vedicItems.isEmpty) return const SizedBox.shrink();

    return Container(
      margin: EdgeInsets.symmetric(horizontal: isMobile ? 16 : isTablet ? 24 : 32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent,
          iconTheme: const IconThemeData(color: ProfessionalColors.textSecondary),
        ),
        child: ExpansionTile(
          initiallyExpanded: _vedicDataExpanded,
          onExpansionChanged: (expanded) {
            setState(() {
              _vedicDataExpanded = expanded;
            });
          },
          leading: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: ProfessionalColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.calendar_today,
              color: ProfessionalColors.primary,
              size: 24,
            ),
          ),
          title: Text(
            'Vedic Panchang',
            style: TextStyle(
              fontSize: isMobile ? 18 : 20,
              fontWeight: FontWeight.bold,
              color: ProfessionalColors.textPrimary,
            ),
          ),
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : 20, vertical: 8),
              child: Wrap(
                spacing: 12,
                runSpacing: 12,
                children: vedicItems.map((item) => Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: ProfessionalColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item['label'] as String,
                        style: TextStyle(
                          fontSize: 12,
                          color: ProfessionalColors.textSecondary,
                        ),
                      ),
                      Text(
                        item['value'] as String,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: ProfessionalColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                )).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTarotCard(bool isMobile, bool isTablet) {
    if (_currentHoroscope?.tarotCardName == null) return const SizedBox.shrink();
    
    return Container(
      margin: EdgeInsets.only(
        left: isMobile ? 16 : isTablet ? 24 : 32,
        right: isMobile ? 16 : isTablet ? 24 : 32,
        top: 0,
        bottom: 32, // Increased bottom margin
      ),
      child: TarotCardWidget(
        cardName: _currentHoroscope!.tarotCardName!,
        meaning: _currentHoroscope!.tarotCardMeaning ?? '',
        imageUrl: _currentHoroscope!.tarotCardImageUrl,
      ),
    );
  }

  Widget _buildEnergyMeterAccordion(bool isMobile, bool isTablet) {
    if (_currentHoroscope?.morningEnergy == null) return const SizedBox.shrink();
    
    return Container(
      margin: EdgeInsets.symmetric(horizontal: isMobile ? 16 : isTablet ? 24 : 32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent,
          iconTheme: const IconThemeData(color: ProfessionalColors.textSecondary),
        ),
        child: ExpansionTile(
          initiallyExpanded: _energyMeterExpanded,
          onExpansionChanged: (expanded) {
            setState(() {
              _energyMeterExpanded = expanded;
            });
          },
          leading: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: ProfessionalColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.battery_charging_full,
              color: ProfessionalColors.primary,
              size: 24,
            ),
          ),
          title: Text(
            'Energy Meter',
            style: TextStyle(
              fontSize: isMobile ? 18 : 20,
              fontWeight: FontWeight.bold,
              color: ProfessionalColors.textPrimary,
            ),
          ),
          children: [
            EnergyMeterWidget(
              morning: _currentHoroscope!.morningEnergy!,
              afternoon: _currentHoroscope!.afternoonEnergy ?? 5,
              evening: _currentHoroscope!.eveningEnergy ?? 5,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavigationButtons(bool isMobile, bool isTablet) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: isMobile ? 16 : isTablet ? 24 : 32),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ElevatedButton.icon(
            onPressed: () => _navigateDate(-1),
            icon: const Icon(Icons.arrow_back),
            label: const Text('Yesterday'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: ProfessionalColors.primary,
              side: const BorderSide(color: ProfessionalColors.primary),
            ),
          ),
          ElevatedButton.icon(
            onPressed: () {
              setState(() {
                _selectedDate = DateTime.now();
              });
              _loadDummyHoroscope();
            },
            icon: const Icon(Icons.today),
            label: const Text('Today'),
            style: ElevatedButton.styleFrom(
              backgroundColor: ProfessionalColors.primary,
              foregroundColor: Colors.white,
            ),
          ),
          ElevatedButton.icon(
            onPressed: () => _navigateDate(1),
            icon: const Icon(Icons.arrow_forward),
            label: const Text('Tomorrow'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: ProfessionalColors.primary,
              side: const BorderSide(color: ProfessionalColors.primary),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCTASection(bool isMobile, bool isTablet) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: isMobile ? 16 : isTablet ? 24 : 32),
      padding: EdgeInsets.all(isMobile ? 16 : 20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            ProfessionalColors.primary,
            ProfessionalColors.primaryDark,
          ],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Text(
            'Want to know more?',
            style: TextStyle(
              fontSize: isMobile ? 18 : 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => context.go('/ai-questions'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: ProfessionalColors.primary,
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              child: const Text('Ask AI (Free Questions)'),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => context.go('/astrologers'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white.withOpacity(0.2),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
                side: const BorderSide(color: Colors.white),
              ),
              child: const Text('Talk to Astrologer Now'),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => context.go('/compatibility'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white.withOpacity(0.2),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
                side: const BorderSide(color: Colors.white),
              ),
              child: const Text('Match Compatibility'),
            ),
          ),
        ],
      ),
    );
  }
}

