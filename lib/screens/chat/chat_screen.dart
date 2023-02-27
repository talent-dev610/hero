// ignore_for_file: deprecated_member_use

import 'package:hero/models/models.dart';
import 'package:hero/widgets/top_appBar.dart';
import 'package:hero/widgets/widgets.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  static const String routeName = '/chat';

  static Route route({required UserMatch userMatch}) {
    return MaterialPageRoute(
      builder: (_) => ChatScreen(userMatch: userMatch),
      settings: RouteSettings(name: routeName),
    );
  }

  final UserMatch userMatch;
  const ChatScreen({required this.userMatch});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        title: Column(
          children: [
            CircleAvatar(
              radius: 15,
              backgroundImage: NetworkImage(userMatch.matchedUser.imageUrls[0]),
            ),
            Text(
              userMatch.matchedUser.name,
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: userMatch.chat != null
                  ? Container(
                      child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: userMatch.chat[0]!.messages.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                            title: userMatch
                                        .chat[0]!.messages[index].senderId ==
                                    1
                                ? Align(
                                    alignment: Alignment.topRight,
                                    child: Container(
                                      padding: const EdgeInsets.all(8.0),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          color: Theme.of(context).accentColor),
                                      child: Text(
                                        userMatch
                                            .chat[0]!.messages[index].message,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6,
                                      ),
                                    ),
                                  )
                                : Align(
                                    alignment: Alignment.topLeft,
                                    child: Row(
                                      children: [
                                        CircleAvatar(
                                          radius: 15,
                                          backgroundImage: NetworkImage(
                                              userMatch
                                                  .matchedUser.imageUrls[0]),
                                        ),
                                        SizedBox(width: 10),
                                        Container(
                                          padding: const EdgeInsets.all(8.0),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                              color: Theme.of(context)
                                                  .primaryColor),
                                          child: Text(
                                            userMatch.chat[0]!.messages[index]
                                                .message,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline6!
                                                .copyWith(color: Colors.white),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ));
                      },
                    ))
                  : SizedBox(),
            ),
          ),
          Container(
              padding: const EdgeInsets.all(8.0),
              height: 100,
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        shape: BoxShape.circle),
                    child: IconButton(
                      icon: Icon(Icons.send_outlined),
                      onPressed: () {},
                      color: Theme.of(context).scaffoldBackgroundColor,
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Theme.of(context).scaffoldBackgroundColor,
                        hintText: 'Type here...',
                        contentPadding:
                            const EdgeInsets.only(left: 20, bottom: 5, top: 5),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).scaffoldBackgroundColor),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).scaffoldBackgroundColor),
                        ),
                      ),
                    ),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
