import 'package:flutter/material.dart';
import 'package:lms_user_app/data/model/conversation/chat_list.dart';

class ChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ChatAppBar({super.key, required this.user});
  final ConversationUser user;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      leadingWidth: 35,
      title: Row(
        children: <Widget>[
          Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: NetworkImage(
                  user.logo ?? "",
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(user.userName,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(fontSize: 14, color: const Color(0xff333333))),
            ],
          )
        ],
      ),
      automaticallyImplyLeading: false,
      leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Padding(
            padding: EdgeInsets.all(4.0),
            child: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          )),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight - 5);
}
