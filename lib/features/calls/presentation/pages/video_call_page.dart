import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/professional_theme.dart';

class VideoCallPage extends ConsumerStatefulWidget {
  final String astrologerName;
  final String? astrologerImage;
  final String? astrologerId;

  const VideoCallPage({
    super.key,
    required this.astrologerName,
    this.astrologerImage,
    this.astrologerId,
  });

  @override
  ConsumerState<VideoCallPage> createState() => _VideoCallPageState();
}

class _VideoCallPageState extends ConsumerState<VideoCallPage> {
  bool _isCallActive = false;
  bool _isMuted = false;
  bool _isVideoOff = false;
  bool _isFrontCamera = true;
  Duration _callDuration = Duration.zero;

  @override
  void initState() {
    super.initState();
    _startCall();
  }

  void _startCall() {
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
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);
    return '${twoDigits(minutes)}:${twoDigits(seconds)}';
  }

  void _endCall() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Remote Video (Full Screen)
          Container(
            width: double.infinity,
            height: double.infinity,
            color: ProfessionalColors.primaryDark,
            child: widget.astrologerImage != null
                ? Image.network(
                    widget.astrologerImage!,
                    fit: BoxFit.cover,
                  )
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.person,
                          size: 100,
                          color: Colors.white.withOpacity(0.5),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          widget.astrologerName,
                          style: theme.textTheme.headlineMedium?.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
          ),

          // Local Video (Picture in Picture)
          Positioned(
            top: 50,
            right: 16,
            child: Container(
              width: 120,
              height: 160,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white, width: 2),
                color: ProfessionalColors.primaryDark,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: _isVideoOff
                    ? Center(
                        child: Icon(
                          Icons.person,
                          size: 40,
                          color: Colors.white.withOpacity(0.5),
                        ),
                      )
                    : Container(
                        color: ProfessionalColors.primary,
                        child: Center(
                          child: Icon(
                            Icons.videocam,
                            color: Colors.white,
                            size: 40,
                          ),
                        ),
                      ),
              ),
            ),
          ),

          // Top Info Bar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.7),
                      Colors.transparent,
                    ],
                  ),
                ),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: _endCall,
                    ),
                    const Spacer(),
                    if (_isCallActive)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 8,
                              height: 8,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: ProfessionalColors.success,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              _formatDuration(_callDuration),
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),

          // Bottom Controls
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black.withOpacity(0.8),
                    Colors.transparent,
                  ],
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Name
                  Text(
                    widget.astrologerName,
                    style: theme.textTheme.titleLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _isCallActive ? 'Video Call' : 'Connecting...',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Control Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Mute
                      _buildVideoControlButton(
                        icon: _isMuted ? Icons.mic_off : Icons.mic,
                        label: 'Mute',
                        isActive: _isMuted,
                        onPressed: () {
                          setState(() {
                            _isMuted = !_isMuted;
                          });
                        },
                      ),

                      // Video Toggle
                      _buildVideoControlButton(
                        icon: _isVideoOff ? Icons.videocam_off : Icons.videocam,
                        label: 'Video',
                        isActive: _isVideoOff,
                        onPressed: () {
                          setState(() {
                            _isVideoOff = !_isVideoOff;
                          });
                        },
                      ),

                      // Switch Camera
                      _buildVideoControlButton(
                        icon: Icons.flip_camera_ios,
                        label: 'Switch',
                        isActive: false,
                        onPressed: () {
                          setState(() {
                            _isFrontCamera = !_isFrontCamera;
                          });
                        },
                      ),

                      // End Call
                      _buildVideoControlButton(
                        icon: Icons.call_end,
                        label: 'End',
                        isActive: true,
                        backgroundColor: ProfessionalColors.error,
                        onPressed: _endCall,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVideoControlButton({
    required IconData icon,
    required String label,
    required bool isActive,
    Color? backgroundColor,
    required VoidCallback onPressed,
  }) {
    return Column(
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: backgroundColor ?? (isActive ? Colors.white24 : Colors.white12),
          ),
          child: IconButton(
            icon: Icon(icon, color: Colors.white, size: 24),
            onPressed: onPressed,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 11,
          ),
        ),
      ],
    );
  }
}

