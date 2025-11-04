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
      astrologerImage: 'https://randomuser.me/api/portraits/women/1.jpg',
      type: ConsultationType.chat,
      dateTime: DateTime.now().add(const Duration(days: 2)),
      amount: 500,
      status: BookingStatus.upcoming,
      duration: const Duration(minutes: 30),
    ),
    Booking(
      id: '2',
      astrologerName: 'Prof. Rahul Sharma',
      astrologerImage: 'https://randomuser.me/api/portraits/men/2.jpg',
      type: ConsultationType.video,
      dateTime: DateTime.now().subtract(const Duration(days: 1)),
      amount: 800,
      status: BookingStatus.completed,
      duration: const Duration(minutes: 45),
    ),
    Booking(
      id: '3',
      astrologerName: 'Ms. Anya Singh',
      astrologerImage: 'https://randomuser.me/api/portraits/women/3.jpg',
      type: ConsultationType.voice,
      dateTime: DateTime.now().subtract(const Duration(days: 5)),
      amount: 400,
      status: BookingStatus.completed,
      duration: const Duration(minutes: 20),
    ),
    Booking(
      id: '4',
      astrologerName: 'Mr. David Lee',
      astrologerImage: 'https://randomuser.me/api/portraits/men/4.jpg',
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
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: ProfessionalColors.background,
      appBar: AppBar(
        title: const Text('My Bookings'),
      ),
      body: Column(
        children: [
          // Filter Tabs
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: ProfessionalColors.surface,
              border: Border(
                bottom: BorderSide(color: ProfessionalColors.border),
              ),
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildFilterChip('All', _selectedFilter == 'All'),
                  const SizedBox(width: 8),
                  _buildFilterChip('Upcoming', _selectedFilter == 'Upcoming'),
                  const SizedBox(width: 8),
                  _buildFilterChip('Past', _selectedFilter == 'Past'),
                  const SizedBox(width: 8),
                  _buildFilterChip('Cancelled', _selectedFilter == 'Cancelled'),
                ],
              ),
            ),
          ),

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
                          style: theme.textTheme.bodyLarge?.copyWith(
                            color: ProfessionalColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: _filteredBookings.length,
                    separatorBuilder: (context, index) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final booking = _filteredBookings[index];
                      return _buildBookingCard(context, booking);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, bool isSelected) {
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        if (selected) {
          setState(() {
            _selectedFilter = label;
          });
        }
      },
      selectedColor: ProfessionalColors.primary,
      checkmarkColor: ProfessionalColors.textLight,
      labelStyle: TextStyle(
        color: isSelected ? ProfessionalColors.textLight : ProfessionalColors.textPrimary,
        fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
      ),
    );
  }

  Widget _buildBookingCard(BuildContext context, Booking booking) {
    final theme = Theme.of(context);

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundImage: booking.astrologerImage != null
                      ? NetworkImage(booking.astrologerImage!)
                      : null,
                  child: booking.astrologerImage == null
                      ? const Icon(Icons.person, size: 28)
                      : null,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        booking.astrologerName,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(
                            booking.type == ConsultationType.chat
                                ? Icons.chat
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
                            style: theme.textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: _getStatusColor(booking.status).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    _getStatusText(booking.status),
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: _getStatusColor(booking.status),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Icon(Icons.calendar_today, size: 16, color: ProfessionalColors.textSecondary),
                const SizedBox(width: 8),
                Text(
                  _formatDateTime(booking.dateTime),
                  style: theme.textTheme.bodyMedium,
                ),
                const SizedBox(width: 16),
                Icon(Icons.access_time, size: 16, color: ProfessionalColors.textSecondary),
                const SizedBox(width: 8),
                Text(
                  '${booking.duration.inMinutes} min',
                  style: theme.textTheme.bodyMedium,
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '₹${booking.amount}',
                  style: theme.textTheme.titleLarge?.copyWith(
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
                        child: const Text('Start'),
                      ),
                    ] else if (booking.status == BookingStatus.completed) ...[
                      OutlinedButton(
                        onPressed: () {
                          // View details
                        },
                        child: const Text('View Details'),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () {
                          // Book again
                        },
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
