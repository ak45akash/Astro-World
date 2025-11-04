import 'package:flutter/material.dart';
import '../../../../core/theme/professional_theme.dart';

enum CallType { voice, video }

enum CallStatus { completed, missed, cancelled }

class CallHistoryItem {
  final String id;
  final String astrologerName;
  final String? astrologerImage;
  final CallType callType;
  final Duration duration;
  final DateTime timestamp;
  final CallStatus status;
  final double amount;

  CallHistoryItem({
    required this.id,
    required this.astrologerName,
    this.astrologerImage,
    required this.callType,
    required this.duration,
    required this.timestamp,
    required this.status,
    required this.amount,
  });
}

class CallHistoryItemWidget extends StatelessWidget {
  final CallHistoryItem call;
  final VoidCallback? onTap;
  final VoidCallback? onCall;

  const CallHistoryItemWidget({
    super.key,
    required this.call,
    this.onTap,
    this.onCall,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            // Avatar
            Stack(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundImage: call.astrologerImage != null
                      ? NetworkImage(call.astrologerImage!)
                      : null,
                  child: call.astrologerImage == null
                      ? const Icon(Icons.person, size: 28)
                      : null,
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: ProfessionalColors.surface,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      call.callType == CallType.voice
                          ? Icons.phone
                          : Icons.videocam,
                      size: 14,
                      color: ProfessionalColors.primary,
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
                  Text(
                    call.astrologerName,
                    style: theme.textTheme.titleMedium,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        call.status == CallStatus.completed
                            ? Icons.call_received
                            : call.status == CallStatus.missed
                                ? Icons.call_missed
                                : Icons.call_missed_outgoing,
                        size: 14,
                        color: call.status == CallStatus.completed
                            ? ProfessionalColors.success
                            : ProfessionalColors.error,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        _formatDuration(call.duration),
                        style: theme.textTheme.bodySmall,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '•',
                        style: theme.textTheme.bodySmall,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        _formatDate(call.timestamp),
                        style: theme.textTheme.bodySmall,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Amount & Call Button
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '₹${call.amount}',
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: ProfessionalColors.success,
                  ),
                ),
                const SizedBox(height: 8),
                IconButton(
                  icon: Icon(
                    call.callType == CallType.voice
                        ? Icons.phone
                        : Icons.videocam,
                    color: ProfessionalColors.primary,
                  ),
                  onPressed: onCall,
                  tooltip: 'Call Again',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);
    return '${twoDigits(minutes)}:${twoDigits(seconds)}';
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      final hour = date.hour;
      final minute = date.minute.toString().padLeft(2, '0');
      final period = hour >= 12 ? 'PM' : 'AM';
      final displayHour = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);
      return '$displayHour:$minute $period';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else {
      return '${date.day}/${date.month}';
    }
  }
}

