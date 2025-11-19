import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/professional_theme.dart';

class BookingsPage extends ConsumerStatefulWidget {
  const BookingsPage({super.key});

  @override
  ConsumerState<BookingsPage> createState() => _BookingsPageState();
}

class _BookingsPageState extends ConsumerState<BookingsPage> {
  String _selectedFilter = 'All'; // All, Upcoming, Past, Cancelled

  final List<Booking> _bookings = [
    Booking(
      id: '1',
      astrologerName: 'Dr. Elena Petrova',
      astrologerImage: null,
      type: ConsultationType.chat,
      dateTime: DateTime.now().add(const Duration(days: 1)),
      amount: 500,
      status: BookingStatus.upcoming,
      duration: const Duration(minutes: 30),
    ),
    Booking(
      id: '2',
      astrologerName: 'Prof. Rahul Sharma',
      astrologerImage: null,
      type: ConsultationType.video,
      dateTime: DateTime.now().subtract(const Duration(days: 1)),
      amount: 800,
      status: BookingStatus.completed,
      duration: const Duration(minutes: 45),
    ),
    Booking(
      id: '3',
      astrologerName: 'Ms. Anya Singh',
      astrologerImage: null,
      type: ConsultationType.voice,
      dateTime: DateTime.now().subtract(const Duration(days: 5)),
      amount: 400,
      status: BookingStatus.completed,
      duration: const Duration(minutes: 20),
    ),
    Booking(
      id: '4',
      astrologerName: 'Mr. David Lee',
      astrologerImage: null,
      type: ConsultationType.chat,
      dateTime: DateTime.now().subtract(const Duration(days: 7)),
      amount: 600,
      status: BookingStatus.cancelled,
      duration: const Duration(minutes: 30),
    ),
  ];

  List<Booking> get _filteredBookings {
    if (_selectedFilter == 'All') return _bookings;
    return _bookings.where((booking) {
      switch (_selectedFilter) {
        case 'Upcoming':
          return booking.status == BookingStatus.upcoming;
        case 'Past':
          return booking.status == BookingStatus.completed;
        case 'Cancelled':
          return booking.status == BookingStatus.cancelled;
        default:
          return true;
      }
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;
    final isTablet = screenWidth >= 600 && screenWidth < 1024;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Teal Header with Back Button
            _buildHeader(context, isMobile, isTablet),

            // Filter Tabs
            _buildFilterSection(context, isMobile, isTablet),

            // Bookings List
            Expanded(
              child: _filteredBookings.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.calendar_today_outlined,
                            size: 64,
                            color: ProfessionalColors.textSecondary,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'No bookings found',
                            style: TextStyle(
                              fontSize: isMobile ? 16 : 18,
                              color: ProfessionalColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.separated(
                      padding: EdgeInsets.symmetric(
                        horizontal: isMobile ? 16 : isTablet ? 24 : 32,
                        vertical: 16,
                      ),
                      itemCount: _filteredBookings.length,
                      separatorBuilder: (context, index) => const SizedBox(height: 16),
                      itemBuilder: (context, index) {
                        final booking = _filteredBookings[index];
                        return _buildBookingCard(context, booking, isMobile, isTablet);
                      },
                    ),
            ),
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
                'My Bookings',
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

  Widget _buildFilterSection(BuildContext context, bool isMobile, bool isTablet) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : isTablet ? 24 : 32,
        vertical: 12,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: ProfessionalColors.border, width: 1),
        ),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            _buildFilterChip('All', _selectedFilter == 'All', isMobile),
            const SizedBox(width: 8),
            _buildFilterChip('Upcoming', _selectedFilter == 'Upcoming', isMobile),
            const SizedBox(width: 8),
            _buildFilterChip('Past', _selectedFilter == 'Past', isMobile),
            const SizedBox(width: 8),
            _buildFilterChip('Cancelled', _selectedFilter == 'Cancelled', isMobile),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label, bool isSelected, bool isMobile) {
    return FilterChip(
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isSelected) ...[
            const Icon(Icons.check, size: 16, color: Colors.white),
            const SizedBox(width: 4),
          ],
          Text(label),
        ],
      ),
      selected: isSelected,
      onSelected: (selected) {
        if (selected) {
          setState(() {
            _selectedFilter = label;
          });
        }
      },
      selectedColor: ProfessionalColors.primary,
      checkmarkColor: Colors.white,
      labelStyle: TextStyle(
        color: isSelected ? Colors.white : ProfessionalColors.textPrimary,
        fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
        fontSize: isMobile ? 14 : 16,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 12 : 16,
        vertical: isMobile ? 8 : 10,
      ),
    );
  }

  Widget _buildBookingCard(
      BuildContext context, Booking booking, bool isMobile, bool isTablet) {
    return Container(
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
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Avatar
                CircleAvatar(
                  radius: isMobile ? 28 : 32,
                  backgroundColor: ProfessionalColors.primary.withOpacity(0.1),
                  child: Icon(
                    Icons.person,
                    size: isMobile ? 28 : 32,
                    color: ProfessionalColors.primary,
                  ),
                ),
                const SizedBox(width: 12),
                // Name and Type
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        booking.astrologerName,
                        style: TextStyle(
                          fontSize: isMobile ? 16 : 18,
                          fontWeight: FontWeight.bold,
                          color: ProfessionalColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(
                            booking.type == ConsultationType.chat
                                ? Icons.chat_bubble_outline
                                : booking.type == ConsultationType.voice
                                    ? Icons.phone
                                    : Icons.videocam,
                            size: 16,
                            color: ProfessionalColors.textSecondary,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            booking.type == ConsultationType.chat
                                ? 'Chat Consultation'
                                : booking.type == ConsultationType.voice
                                    ? 'Voice Call'
                                    : 'Video Call',
                            style: TextStyle(
                              fontSize: isMobile ? 13 : 14,
                              color: ProfessionalColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // Status Tag
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: _getStatusColor(booking.status),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    _getStatusText(booking.status),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Date/Time and Duration
            Row(
              children: [
                Icon(
                  Icons.calendar_today,
                  size: 16,
                  color: ProfessionalColors.textSecondary,
                ),
                const SizedBox(width: 8),
                Text(
                  _formatDateTime(booking.dateTime),
                  style: TextStyle(
                    fontSize: isMobile ? 13 : 14,
                    color: ProfessionalColors.textSecondary,
                  ),
                ),
                const SizedBox(width: 16),
                Icon(
                  Icons.access_time,
                  size: 16,
                  color: ProfessionalColors.textSecondary,
                ),
                const SizedBox(width: 8),
                Text(
                  '${booking.duration.inMinutes} min',
                  style: TextStyle(
                    fontSize: isMobile ? 13 : 14,
                    color: ProfessionalColors.textSecondary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            // Cost and Action Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '₹${booking.amount.toInt()}',
                  style: TextStyle(
                    fontSize: isMobile ? 18 : 20,
                    fontWeight: FontWeight.bold,
                    color: ProfessionalColors.success,
                  ),
                ),
                Row(
                  children: [
                    if (booking.status == BookingStatus.upcoming) ...[
                      OutlinedButton(
                        onPressed: () {
                          // Cancel booking
                        },
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: ProfessionalColors.primary),
                          foregroundColor: ProfessionalColors.primary,
                          padding: EdgeInsets.symmetric(
                            horizontal: isMobile ? 16 : 20,
                            vertical: isMobile ? 8 : 10,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text('Cancel'),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () {
                          // Start consultation
                          if (booking.type == ConsultationType.chat) {
                            context.go('/chat/${booking.id}');
                          } else if (booking.type == ConsultationType.voice) {
                            context.push('/voice-call', extra: {
                              'astrologerName': booking.astrologerName,
                              'astrologerImage': booking.astrologerImage,
                            });
                          } else {
                            context.push('/video-call', extra: {
                              'astrologerName': booking.astrologerName,
                              'astrologerImage': booking.astrologerImage,
                            });
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ProfessionalColors.primary,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(
                            horizontal: isMobile ? 16 : 20,
                            vertical: isMobile ? 8 : 10,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          elevation: 0,
                        ),
                        child: const Text('Start'),
                      ),
                    ] else if (booking.status == BookingStatus.completed) ...[
                      OutlinedButton(
                        onPressed: () {
                          // View details
                        },
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: ProfessionalColors.primary),
                          foregroundColor: ProfessionalColors.primary,
                          padding: EdgeInsets.symmetric(
                            horizontal: isMobile ? 16 : 20,
                            vertical: isMobile ? 8 : 10,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text('View Details'),
                      ),
                      const SizedBox(width: 8),
                      TextButton(
                        onPressed: () {
                          // Book again
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: ProfessionalColors.primary,
                          padding: EdgeInsets.symmetric(
                            horizontal: isMobile ? 12 : 16,
                            vertical: isMobile ? 8 : 10,
                          ),
                        ),
                        child: const Text('Book Again'),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(BookingStatus status) {
    switch (status) {
      case BookingStatus.upcoming:
        return ProfessionalColors.info;
      case BookingStatus.completed:
        return ProfessionalColors.success;
      case BookingStatus.cancelled:
        return ProfessionalColors.error;
    }
  }

  String _getStatusText(BookingStatus status) {
    switch (status) {
      case BookingStatus.upcoming:
        return 'Upcoming';
      case BookingStatus.completed:
        return 'Completed';
      case BookingStatus.cancelled:
        return 'Cancelled';
    }
  }

  String _formatDateTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = dateTime.difference(now);

    if (difference.inDays == 0) {
      return 'Today, ${_formatTime(dateTime)}';
    } else if (difference.inDays == 1) {
      return 'Tomorrow, ${_formatTime(dateTime)}';
    } else if (difference.inDays == -1) {
      return 'Yesterday, ${_formatTime(dateTime)}';
    } else {
      return '${dateTime.day}/${dateTime.month}/${dateTime.year}, ${_formatTime(dateTime)}';
    }
  }

  String _formatTime(DateTime dateTime) {
    final hour = dateTime.hour;
    final minute = dateTime.minute.toString().padLeft(2, '0');
    final period = hour >= 12 ? 'PM' : 'AM';
    final displayHour = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);
    return '$displayHour:$minute $period';
  }
}

enum ConsultationType { chat, voice, video }

enum BookingStatus { upcoming, completed, cancelled }

class Booking {
  final String id;
  final String astrologerName;
  final String? astrologerImage;
  final ConsultationType type;
  final DateTime dateTime;
  final double amount;
  final BookingStatus status;
  final Duration duration;

  Booking({
    required this.id,
    required this.astrologerName,
    this.astrologerImage,
    required this.type,
    required this.dateTime,
    required this.amount,
    required this.status,
    required this.duration,
  });
}
