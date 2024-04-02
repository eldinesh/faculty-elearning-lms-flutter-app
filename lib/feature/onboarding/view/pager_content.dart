import 'package:flutter/material.dart';
import 'package:lms_user_app/components/custom_image.dart';

class PagerContent extends StatelessWidget {
  const PagerContent({Key? key, required this.image}) : super(key: key);

  final String image;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Spacer(),
        CustomImage(image: image,),
        const SizedBox(height: 80),
      ],
    );
  }
}