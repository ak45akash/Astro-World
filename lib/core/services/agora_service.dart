import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import '../constants/app_constants.dart';

class AgoraService {
  RtcEngine? _engine;
  final String _appId = AppConstants.agoraAppId;

  Future<void> initialize() async {
    _engine = createAgoraRtcEngine();
    await _engine!.initialize(RtcEngineContext(
      appId: _appId,
      channelProfile: ChannelProfileType.channelProfileCommunication,
    ));
  }

  Future<void> joinChannel({
    required String channelName,
    required String token,
    required int uid,
    required ClientRoleType role,
  }) async {
    await _engine?.joinChannel(
      token: token,
      channelId: channelName,
      uid: uid,
      options: ChannelMediaOptions(
        clientRoleType: role,
        channelProfile: ChannelProfileType.channelProfileCommunication,
      ),
    );
  }

  Future<void> leaveChannel() async {
    await _engine?.leaveChannel();
  }

  Future<void> enableVideo() async {
    await _engine?.enableVideo();
  }

  Future<void> disableVideo() async {
    await _engine?.disableVideo();
  }

  Future<void> enableAudio() async {
    await _engine?.enableLocalAudio(true);
  }

  Future<void> disableAudio() async {
    await _engine?.enableLocalAudio(false);
  }

  void setEventHandler(RtcEngineEventHandler handler) {
    _engine?.registerEventHandler(handler);
  }

  void dispose() {
    _engine?.release();
  }
}

