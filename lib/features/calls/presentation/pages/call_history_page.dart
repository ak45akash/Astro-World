import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/professional_theme.dart';
import '../widgets/call_history_item.dart';

class CallHistoryPage extends ConsumerStatefulWidget {
  const CallHistoryPage({super.key});

  @override
  ConsumerState<CallHistoryPage> createState() => _CallHistoryPageState();
}

class _CallHistoryPageState extends ConsumerState<CallHistoryPage> {
  String _selectedFilter = 'All'; // All, Voice, Video

  final List<CallHistoryItem> _callHistory = [
    CallHistoryItem(
      id: '1',
      astrologerName: 'Dr. Elena Petrova',
      astrologerImage: 'https://randomuser.me/api/portraits/women/1.jpg',
      callType: CallType.voice,
      duration: const Duration(minutes: 25, seconds: 30),
      timestamp: DateTime.now().subtract(const Duration(days: 1)),
      status: CallStatus.completed,
      amount: 500,
    ),
    CallHistoryItem(
      id: '2',
      astrologerName: 'Prof. Rahul Sharma',
      astrologerImage: 'https://randomuser.me/api/portraits/men/2.jpg',
      callType: CallType.video,
      duration: const Duration(minutes: 45, seconds: 15),
      timestamp: DateTime.now().subtract(const Duration(days: 2)),
      status: CallStatus.completed,
      amount: 800,
    ),
    CallHistoryItem(
      id: '3',
      astrologerName: 'Ms. Anya Singh',
      astrologerImage: 'https://randomuser.me/api/portraits/women/3.jpg',
      callType: CallType.voice,
      duration: const Duration(minutes: 15, seconds: 20),
      timestamp: DateTime.now().subtract(const Duration(days: 3)),
      status: CallStatus.missed,
      amount: 400,
    ),
    CallHistoryItem(
      id: '4',
      astrologerName: 'Mr. David Lee',
      astrologerImage: 'https://randomuser.me/api/portraits/men/4.jpg',
      callType: CallType.video,
      duration: const Duration(minutes: 30, seconds: 45),
      timestamp: DateTime.now().subtract(const Duration(days: 5)),
      status: CallStatus.completed,
      amount: 750,
    ),
    CallHistoryItem(
      id: '5',
      astrologerName: 'Dr. Elena Petrova',
      astrologerImage: 'https://randomuser.me/api/portraits/women/1.jpg',
      callType: CallType.voice,
      duration: const Duration(minutes: 20),
      timestamp: DateTime.now().subtract(const Duration(days: 7)),
      status: CallStatus.completed,
      amount: 500,
    ),
  ];

  List<CallHistoryItem> get _filteredCalls {
    if (_selectedFilter == 'All') return _callHistory;
    return _callHistory.where((call) {
      if (_selectedFilter == 'Voice') {
        return call.callType == CallType.voice;
      } else {
        return call.callType == CallType.video;
      }
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: ProfessionalColors.background,
      appBar: AppBar(
        title: const Text('Call History'),
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
            child: Row(
              children: [
                _buildFilterChip('All', _selectedFilter == 'All'),
                const SizedBox(width: 8),
                _buildFilterChip('Voice', _selectedFilter == 'Voice'),
                const SizedBox(width: 8),
                _buildFilterChip('Video', _selectedFilter == 'Video'),
              ],
            ),
          ),

          // Call History List
          Expanded(
            child: _filteredCalls.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.call_outlined,
                          size: 64,
                          color: ProfessionalColors.textSecondary,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No call history',
                          style: theme.textTheme.bodyLarge?.copyWith(
                            color: ProfessionalColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: _filteredCalls.length,
                    separatorBuilder: (context, index) => const Divider(),
                    itemBuilder: (context, index) {
                      final call = _filteredCalls[index];
                      return CallHistoryItemWidget(
                        call: call,
                        onTap: () {
                          // View call details
                          _showCallDetails(context, call);
                        },
                        onCall: () {
                          // Start new call
                          _startCall(context, call);
                        },
                      );
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

  void _showCallDetails(BuildContext context, CallHistoryItem call) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: call.astrologerImage != null
                      ? NetworkImage(call.astrologerImage!)
                      : null,
                  child: call.astrologerImage == null
                      ? const Icon(Icons.person, size: 30)
                      : null,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        call.astrologerName,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        call.callType == CallType.voice ? 'Voice Call' : 'Video Call',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            _buildDetailRow(Icons.access_time, 'Duration', _formatDuration(call.duration)),
            const SizedBox(height: 12),
            _buildDetailRow(Icons.calendar_today, 'Date', _formatDate(call.timestamp)),
            const SizedBox(height: 12),
            _buildDetailRow(Icons.currency_rupee, 'Amount', '₹${call.amount}'),
            const SizedBox(height: 12),
            _buildDetailRow(
              Icons.info_outline,
              'Status',
              call.status == CallStatus.completed
                  ? 'Completed'
                  : call.status == CallStatus.missed
                      ? 'Missed'
                      : 'Cancelled',
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      _startCall(context, call);
                    },
                    child: const Text('Call Again'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      // Navigate to chat
                    },
                    child: const Text('View Chat'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 20, color: ProfessionalColors.textSecondary),
        const SizedBox(width: 12),
        Text(
          '$label: ',
          style: TextStyle(
            color: ProfessionalColors.textSecondary,
            fontSize: 14,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  void _startCall(BuildContext context, CallHistoryItem call) {
    if (call.callType == CallType.voice) {
      context.push('/voice-call', extra: {
        'astrologerName': call.astrologerName,
        'astrologerImage': call.astrologerImage,
        'astrologerId': call.id,
      });
    } else {
      context.push('/video-call', extra: {
        'astrologerName': call.astrologerName,
        'astrologerImage': call.astrologerImage,
        'astrologerId': call.id,
      });
    }
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);

    if (hours > 0) {
      return '${twoDigits(hours)}:${twoDigits(minutes)}:${twoDigits(seconds)}';
    }
    return '${twoDigits(minutes)}:${twoDigits(seconds)}';
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      return 'Today';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }
}

