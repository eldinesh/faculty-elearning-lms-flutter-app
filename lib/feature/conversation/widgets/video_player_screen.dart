//import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
//import 'package:video_player/video_player.dart';

class VideoPlayerScreen extends StatefulWidget {
  const VideoPlayerScreen({super.key});

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  // late String url;
  // late VideoPlayerController _videoPlayerController;
  // late ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    // url = Get.arguments;
    // _videoPlayerController = VideoPlayerController.network(url);

    // _chewieController = ChewieController(
    //   videoPlayerController: _videoPlayerController,
    //   aspectRatio: 3 / 2,
    //   autoPlay: true,
    //   looping: true,
    // );
  }

  @override
  void dispose() {
    // _videoPlayerController.dispose();
    // _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(),
      body: const SizedBox(
        //height: MediaQuery.of(context).size.height * 0.5,
        // width: MediaQuery.of(context).size.width * 0.5,
        // child: Center(
        //   child: Chewie(
        //     controller: _chewieController,
        //   ),
        // ),
      ),
    );
  }
}
