import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/professional_theme.dart';

class VoiceCallPage extends ConsumerStatefulWidget {
  final String astrologerName;
  final String? astrologerImage;
  final String? astrologerId;

  const VoiceCallPage({
    super.key,
    required this.astrologerName,
    this.astrologerImage,
    this.astrologerId,
  });

  @override
  ConsumerState<VoiceCallPage> createState() => _VoiceCallPageState();
}

class _VoiceCallPageState extends ConsumerState<VoiceCallPage> {
  bool _isCallActive = false;
  bool _isMuted = false;
  bool _isSpeakerOn = false;
  Duration _callDuration = Duration.zero;

  @override
  void initState() {
    super.initState();
    _startCall();
  }

  void _startCall() {
    // Simulate call starting
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _isCallActive = true;
        });
        _startTimer();
      }
    });
  }

  void _startTimer() {
    // Simulate call timer
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted && _isCallActive) {
        setState(() {
          _callDuration = _callDuration + const Duration(seconds: 1);
        });
        _startTimer();
      }
    });
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

  void _endCall() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: ProfessionalColors.primaryDark,
      body: SafeArea(
        child: Column(
          children: [
            // Status Bar
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: _endCall,
                  ),
                  const Spacer(),
                  Text(
                    _isCallActive ? 'Call in progress' : 'Connecting...',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),

            // Main Content
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Profile Picture
                  Container(
                    width: 180,
                    height: 180,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: ProfessionalColors.accent.withOpacity(0.2),
                      border: Border.all(
                        color: ProfessionalColors.accent,
                        width: 3,
                      ),
                    ),
                    child: widget.astrologerImage != null
                        ? ClipOval(
                            child: Image.network(
                              widget.astrologerImage!,
                              fit: BoxFit.cover,
                            ),
                          )
                        : Icon(
                            Icons.person,
                            size: 100,
                            color: ProfessionalColors.accent,
                          ),
                  ),
                  const SizedBox(height: 32),

                  // Name
                  Text(
                    widget.astrologerName,
                    style: theme.textTheme.headlineLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Status
                  Text(
                    _isCallActive ? 'Voice Call' : 'Connecting...',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Call Duration
                  if (_isCallActive)
                    Text(
                      _formatDuration(_callDuration),
                      style: theme.textTheme.headlineMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                ],
              ),
            ),

            // Call Controls
            Padding(
              padding: const EdgeInsets.all(32),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Mute Button
                  _buildCallControlButton(
                    icon: _isMuted ? Icons.mic_off : Icons.mic,
                    label: 'Mute',
                    isActive: _isMuted,
                    onPressed: () {
                      setState(() {
                        _isMuted = !_isMuted;
                      });
                    },
                  ),

                  // Speaker Button
                  _buildCallControlButton(
                    icon: _isSpeakerOn ? Icons.volume_up : Icons.volume_down,
                    label: 'Speaker',
                    isActive: _isSpeakerOn,
                    onPressed: () {
                      setState(() {
                        _isSpeakerOn = !_isSpeakerOn;
                      });
                    },
                  ),

                  // End Call Button
                  _buildCallControlButton(
                    icon: Icons.call_end,
                    label: 'End',
                    isActive: true,
                    backgroundColor: ProfessionalColors.error,
                    onPressed: _endCall,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCallControlButton({
    required IconData icon,
    required String label,
    required bool isActive,
    Color? backgroundColor,
    required VoidCallback onPressed,
  }) {
    return Column(
      children: [
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: backgroundColor ?? (isActive ? ProfessionalColors.accent : Colors.white24),
          ),
          child: IconButton(
            icon: Icon(icon, color: Colors.white, size: 28),
            onPressed: onPressed,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            color: Colors.white70,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}

