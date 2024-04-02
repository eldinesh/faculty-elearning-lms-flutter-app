import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class VideoMessagePreview extends StatelessWidget {
  final String videoUrl;

  const VideoMessagePreview({super.key, required this.videoUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 200,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: FutureBuilder<String>(
        future: _loadImage(videoUrl),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Stack(
              children: [
                Container(
                  height: 200,
                  width: 200,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.black26,
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    child: Image.file(
                      File(snapshot.data!),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                const Align(
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.play_circle_outline,
                    size: 80,
                    color: Colors.white,
                  ),
                )
              ],
            );
          } else {
            return Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                color: Colors.grey[200],
              ),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
    );
  }

  Future<String> _loadImage(String url) async {
    final thumbnail = await VideoThumbnail.thumbnailFile(
      video: url,
      thumbnailPath: (await getTemporaryDirectory()).path,
      imageFormat: ImageFormat.JPEG,
      // specify the height of the thumbnail, let the width auto-scaled to keep the source aspect ratio
      quality: 10,
    );
    return thumbnail ?? "";
  }
}
