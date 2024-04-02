import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms_user_app/components/custom_button.dart';
import 'package:lms_user_app/core/helper/route_helper.dart';
import 'package:lms_user_app/data/model/common/quiz.dart';
import 'package:lms_user_app/utils/styles.dart';

class QuizDetailScreen extends StatelessWidget {
  final Quiz? quiz;
  const QuizDetailScreen({this.quiz, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('quiz'.tr),
        titleSpacing: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              quiz?.title ?? '',
              style: robotoRegular.copyWith(fontSize: 14),
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                "• Duration: ${quiz?.duration}",
                style: robotoRegular.copyWith(
                  fontSize: 12,
                  color: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .color!
                      .withOpacity(0.6),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                "• Total marks: ${quiz?.totalMarks}",
                style: robotoRegular.copyWith(
                  fontSize: 12,
                  color: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .color!
                      .withOpacity(0.6),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                "• Pass marks: ${quiz?.passMarks}",
                style: robotoRegular.copyWith(
                  fontSize: 12,
                  color: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .color!
                      .withOpacity(0.6),
                ),
              ),
            ),
            const Spacer(),
            CustomButton(
              buttonText: 'start_quiz'.tr,
              onPressed: () => Get.toNamed(RouteHelper.quizStartPage,
                  arguments: quiz?.id as int),
            ),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
