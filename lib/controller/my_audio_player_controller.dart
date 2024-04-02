import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms_user_app/controller/classroom_controller.dart';
import 'package:lms_user_app/controller/video_player_controller.dart';

class MyAudioPlayerController extends GetxController implements GetxService {
  final player = AudioPlayer();
  UrlSource? _playerSource;
  Duration? _audioDuration;
  Duration? _oneThirdDuration;
  bool saveProgressCalled = false;
  int? _courseId;
  String? _lessonId;
  String? _sectionId;

  final progressNotifier = ValueNotifier<ProgressBarState>(
    ProgressBarState(
      current: Duration.zero,
      buffered: Duration.zero,
      total: Duration.zero,
    ),
  );

  @override
  void onInit() {
    Get.find<MyVideoPlayerController>().saveProgressCalled = false;
    listenProgressState();
    super.onInit();
  }

  Future<void> initPlayer(String url, int courseId, String lessonId,  String sectionId ) async {
    _courseId = courseId;
    _lessonId = lessonId;
    _sectionId = sectionId;
    _playerSource = UrlSource(url);
    await player.setSourceUrl(url);
    await playAudio();
    update();
  }

  Future<void> playOrPause() async {
    if (player.state == PlayerState.playing) {
      await pauseAudio();
    } else {
      await playAudio();
    }
    update();
  }

  Future<void> listenProgressState() async {
    player.onDurationChanged.listen((duration) {
      final oldState = progressNotifier.value;

      _audioDuration = duration;
      _oneThirdDuration = duration * (1 / 3);


      progressNotifier.value = ProgressBarState(
          current: oldState.current,
          buffered: oldState.buffered,
          total: duration);
    }).asFuture();

    player.onPositionChanged.listen((position) {
      if(_audioDuration != null && position > _oneThirdDuration!){
        // print("Current position is greater than one third of the total duration.");
        // print('Current position: $position');
        Get.find<ClassroomController>().saveCourseProgress( _courseId!, _lessonId!,  _sectionId!, position.inSeconds.toString(), _audioDuration!.inSeconds.toString());


      }
      final oldState = progressNotifier.value;
      progressNotifier.value = ProgressBarState(
        current: position,
        buffered: oldState.buffered,
        total: oldState.total,
      );
    });
    update();
  }

  Future<void> playAudio() async {
    if (_playerSource != null) {
      await player.play(_playerSource!);
      await listenProgressState();
      update();
    }
  }

  Future<void> pauseAudio() async {
    await player.pause();
    update();
  }

  Future<void> seekTo(Duration duration) async {
    await player.seek(duration);
    update();
  }

  Future<void> stopPlayer() async {
    await player.stop();
    await player.release();
    Get.find<MyVideoPlayerController>().saveProgressCalled = false;
    update();
  }

  @override
  void dispose() {
    stopPlayer();
    progressNotifier.dispose();
    super.dispose();
  }
}

class ProgressBarState {
  final Duration? current;
  final Duration? buffered;
  final Duration? total;

  ProgressBarState(
      {required this.current, required this.buffered, required this.total});
}
