import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/professional_theme.dart';

class ChatPage extends ConsumerStatefulWidget {
  final String bookingId;
  final String? astrologerName;
  final String? astrologerImage;

  const ChatPage({
    super.key,
    required this.bookingId,
    this.astrologerName,
    this.astrologerImage,
  });

  @override
  ConsumerState<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends ConsumerState<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<ChatMessage> _messages = [];

  @override
  void initState() {
    super.initState();
    _loadMessages();
  }

  void _loadMessages() {
    // Mock messages for UI
    _messages.addAll([
      ChatMessage(
        text: 'Hello! I\'m ready to help you with your astrology questions.',
        isSent: false,
        timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
      ),
      ChatMessage(
        text: 'Thank you! I wanted to know about my career prospects.',
        isSent: true,
        timestamp: DateTime.now().subtract(const Duration(minutes: 4)),
      ),
      ChatMessage(
        text: 'Based on your birth chart, I can see strong planetary positions in your 10th house. Let me explain...',
        isSent: false,
        timestamp: DateTime.now().subtract(const Duration(minutes: 3)),
      ),
    ]);
  }

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) return;

    setState(() {
      _messages.add(
        ChatMessage(
          text: _messageController.text,
          isSent: true,
          timestamp: DateTime.now(),
        ),
      );
    });

    _messageController.clear();
    _scrollToBottom();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final astrologerName = widget.astrologerName ?? 'Astrologer';
    final astrologerImage = widget.astrologerImage;

    return Scaffold(
      backgroundColor: ProfessionalColors.background,
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              radius: 18,
              backgroundImage: astrologerImage != null
                  ? NetworkImage(astrologerImage)
                  : null,
              child: astrologerImage == null
                  ? const Icon(Icons.person, size: 20)
                  : null,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    astrologerName,
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: ProfessionalColors.textLight,
                    ),
                  ),
                  Text(
                    'Online',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: ProfessionalColors.textLight.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.phone),
            onPressed: () {
              // Navigate to voice call
            },
            tooltip: 'Voice Call',
          ),
          IconButton(
            icon: const Icon(Icons.videocam),
            onPressed: () {
              // Navigate to video call
            },
            tooltip: 'Video Call',
          ),
          PopupMenuButton(
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'view_profile',
                child: Row(
                  children: [
                    Icon(Icons.person_outline, size: 20),
                    SizedBox(width: 8),
                    Text('View Profile'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'view_charts',
                child: Row(
                  children: [
                    Icon(Icons.account_tree_outlined, size: 20),
                    SizedBox(width: 8),
                    Text('View Charts'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          // Messages List
          Expanded(
            child: _messages.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.chat_bubble_outline,
                          size: 64,
                          color: ProfessionalColors.textSecondary,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Start your conversation',
                          style: theme.textTheme.bodyLarge?.copyWith(
                            color: ProfessionalColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.all(16),
                    itemCount: _messages.length,
                    itemBuilder: (context, index) {
                      return _buildMessageBubble(_messages[index]);
                    },
                  ),
          ),

          // Attachment Options
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.attach_file),
                  onPressed: () {
                    // Show attachment options
                    _showAttachmentOptions(context);
                  },
                  tooltip: 'Attach',
                ),
                IconButton(
                  icon: const Icon(Icons.image_outlined),
                  onPressed: () {
                    // Pick image
                  },
                  tooltip: 'Image',
                ),
              ],
            ),
          ),

          // Message Input
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: ProfessionalColors.surface,
              border: Border(
                top: BorderSide(color: ProfessionalColors.border),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide(color: ProfessionalColors.border),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide(color: ProfessionalColors.border),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: const BorderSide(
                          color: ProfessionalColors.accent,
                          width: 2,
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                    ),
                    maxLines: null,
                    textCapitalization: TextCapitalization.sentences,
                    onSubmitted: (_) => _sendMessage(),
                  ),
                ),
                const SizedBox(width: 8),
                CircleAvatar(
                  backgroundColor: ProfessionalColors.primary,
                  child: IconButton(
                    icon: const Icon(Icons.send, color: Colors.white),
                    onPressed: _sendMessage,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(ChatMessage message) {
    final theme = Theme.of(context);
    final isSent = message.isSent;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment:
            isSent ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!isSent) ...[
            CircleAvatar(
              radius: 16,
              backgroundColor: ProfessionalColors.accent.withOpacity(0.2),
              child: const Icon(Icons.person, size: 18),
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: isSent
                    ? ProfessionalColors.primary
                    : ProfessionalColors.surface,
                borderRadius: BorderRadius.circular(16),
                border: !isSent
                    ? Border.all(color: ProfessionalColors.border)
                    : null,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    message.text,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: isSent
                          ? ProfessionalColors.textLight
                          : ProfessionalColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        _formatTime(message.timestamp),
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: isSent
                              ? ProfessionalColors.textLight.withOpacity(0.7)
                              : ProfessionalColors.textSecondary,
                          fontSize: 11,
                        ),
                      ),
                      if (isSent) ...[
                        const SizedBox(width: 4),
                        Icon(
                          Icons.done_all,
                          size: 14,
                          color: ProfessionalColors.textLight.withOpacity(0.7),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ),
          if (isSent) const SizedBox(width: 8),
        ],
      ),
    );
  }

  void _showAttachmentOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildAttachmentOption(
              context,
              Icons.image,
              'Image',
              () {
                Navigator.pop(context);
                // Handle image pick
              },
            ),
            const SizedBox(height: 16),
            _buildAttachmentOption(
              context,
              Icons.insert_drive_file,
              'Document',
              () {
                Navigator.pop(context);
                // Handle document pick
              },
            ),
            const SizedBox(height: 16),
            _buildAttachmentOption(
              context,
              Icons.account_tree,
              'Chart',
              () {
                Navigator.pop(context);
                // Handle chart attachment
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAttachmentOption(
    BuildContext context,
    IconData icon,
    String label,
    VoidCallback onTap,
  ) {
    return ListTile(
      leading: Icon(icon, color: ProfessionalColors.primary),
      title: Text(label),
      onTap: onTap,
    );
  }

  String _formatTime(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inDays == 0) {
      final hour = timestamp.hour;
      final minute = timestamp.minute.toString().padLeft(2, '0');
      final period = hour >= 12 ? 'PM' : 'AM';
      final displayHour = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);
      return '$displayHour:$minute $period';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else {
      return '${timestamp.day}/${timestamp.month}/${timestamp.year}';
    }
  }
}

class ChatMessage {
  final String text;
  final bool isSent;
  final DateTime timestamp;
  final String? attachmentUrl;

  ChatMessage({
    required this.text,
    required this.isSent,
    required this.timestamp,
    this.attachmentUrl,
  });
}
