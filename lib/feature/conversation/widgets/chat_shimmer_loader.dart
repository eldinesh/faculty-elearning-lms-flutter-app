import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ChatShimmerLoader extends StatelessWidget {
  const ChatShimmerLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int offset = 0;
    int time = 100;

    return SafeArea(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
          itemCount: 5,
          padding: const EdgeInsets.only(top: 0),
          itemBuilder: (BuildContext context, int index) {
            offset += 5;
            time = 1000 + offset;
            return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 10),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Shimmer.fromColors(
                          highlightColor: Colors.grey[400]!,
                          baseColor: Colors.grey[300]!,
                          period: Duration(milliseconds: time),
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration:  const BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.all(Radius.circular(30))
                            ),
                            child: const CircleAvatar(
                              radius: 30,
                            ),
                          ),
                        ),
                        const SizedBox(width: 20,),
                        Expanded(
                          child: Shimmer.fromColors(
                            highlightColor: Colors.grey[400]!,
                            baseColor: Colors.grey[300]!,
                            period: Duration(milliseconds: time),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 40,
                                  width: 180,
                                  decoration:  const BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(10),
                                        topLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(10),
                                      )
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20,),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [

                        Expanded(
                          child: Shimmer.fromColors(
                            highlightColor: Colors.grey[400]!,
                            baseColor: Colors.grey[300]!,
                            period: Duration(milliseconds: time),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                  height: 80,
                                  width: 180,
                                  decoration:  const BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(10),
                                        topLeft: Radius.circular(10),
                                        bottomLeft: Radius.circular(10),
                                      )
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 20,),
                        Shimmer.fromColors(
                          highlightColor: Colors.grey[400]!,
                          baseColor: Colors.grey[300]!,
                          period: Duration(milliseconds: time),
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration:  const BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.all(Radius.circular(30))
                            ),
                            child: const CircleAvatar(
                              radius: 30,
                            ),
                          ),
                        ),

                      ],
                    ),
                  ],
                )
            );
          },
        ),
      ),
    );
  }
}
