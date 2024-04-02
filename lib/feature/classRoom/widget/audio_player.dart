import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms_user_app/controller/my_audio_player_controller.dart';
import 'package:lms_user_app/utils/images.dart';
import '../../../data/model/common/lesson.dart';
import '../../../utils/dimensions.dart';
import '../../../utils/styles.dart';

class MyAudioPlayer extends StatelessWidget {
  final Lesson lesson;
  final int courseID;
  final String sectionID;
  const MyAudioPlayer({super.key, required this.lesson, required this.courseID, required this.sectionID});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: GetBuilder<MyAudioPlayerController>(
          initState: (state) => Get.find<MyAudioPlayerController>().initPlayer(lesson.link,courseID, lesson.id.toString(), sectionID ),
          builder: (controller) {
            return Container(
              padding: const EdgeInsets.all(10),
              height: MediaQuery.of(context).size.height / 4 - 50,
              decoration: const BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                child: Column(
                  children: [
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(
                            lesson.thumbnail,
                            height: 44.0,
                            width: 44.0,
                            errorBuilder: (context, error, stackTrace) =>
                                Image.asset(
                              Images.placeholder,
                              height: 44.0,
                              width: 44.0,
                            ),
                          ),
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                lesson.title,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: robotoRegular.copyWith(
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .color!,
                                    fontSize: Dimensions.fontSizeSmall),
                              ),
                              Text(
                                lesson.description,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: robotoRegular.copyWith(
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .color!
                                        .withOpacity(0.6),
                                    fontSize: Dimensions.fontSizeExtraSmall),
                              )
                            ],
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              controller.stopPlayer();
                              Get.back();
                            },
                            icon: const Icon(Icons.close))
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        StreamBuilder<PlayerState>(
                            stream: controller.player.onPlayerStateChanged,
                            builder: (context, snapshot) {
                              final playerState = snapshot.data;
                              return playerButton(controller, playerState);
                            }),
                      ],
                    ),
                    ValueListenableBuilder<ProgressBarState>(
                        valueListenable: controller.progressNotifier,
                        builder: (_, value, __) {
                          return ProgressBar(
                            progress: value.current!,
                            buffered: value.buffered,
                            barHeight: 2.0,
                            thumbRadius: 8,
                            timeLabelTextStyle: robotoRegular.copyWith(
                                color: Colors.black, fontSize: 12),
                            total: value.total!,
                            onSeek: (value) => controller.seekTo(value),
                          );
                        }),
                  ],
                ),
              ),
            );
          }),
    );
  }

  Widget playerButton(MyAudioPlayerController controller, PlayerState? state) {
    if (state != PlayerState.completed &&
        state != PlayerState.paused &&
        state != PlayerState.playing &&
        state != PlayerState.stopped) {
      return Container(
        margin: const EdgeInsets.all(8.0),
        width: 25.0,
        height: 25.0,
        child: const CircularProgressIndicator(),
      );
    } else if (state == PlayerState.playing) {
      return IconButton(
          onPressed: () => controller.playOrPause(),
          icon: const Icon(Icons.pause));
    } else {
      return IconButton(
          onPressed: () => controller.playOrPause(),
          icon: const Icon(Icons.play_arrow));
    }
  }
}
