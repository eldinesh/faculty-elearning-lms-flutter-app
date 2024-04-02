import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms_user_app/controller/video_player_controller.dart';

class CourseVideoPlayer extends StatefulWidget {
  final String videoUrl;
  const CourseVideoPlayer({Key? key, required this.videoUrl}) : super(key: key);

  @override
  State<CourseVideoPlayer> createState() => _CourseVideoPlayerState();
}

class _CourseVideoPlayerState extends State<CourseVideoPlayer> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyVideoPlayerController>(builder: (controller) {
      return AspectRatio(
        aspectRatio: 16 / 9,
        child: controller.betterPlayerController != null
            ? BetterPlayer(controller: controller.betterPlayerController!)
            : const SizedBox(),
      );
    });
  }
}
