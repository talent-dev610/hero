import 'package:flutter/material.dart';
import 'package:hero/models/models.dart';
import 'package:hero/widgets/widgets.dart';

class ActiveChatsScreen extends StatelessWidget {
  static const String routeName = '/settings';
  ActiveChatsScreen({Key? key}) : super(key: key);
  final activeMatches = UserMatch.matches
      .where((match) => match.userId == 1 && match.chat.isNotEmpty)
      .toList();

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => ActiveChatsScreen(),
      settings: RouteSettings(name: routeName),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: TopAppBar(title: 'Chats'),
        body: ListView.builder(
          shrinkWrap: true,
          itemCount: activeMatches.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/chat',
                    arguments: activeMatches[index]);
              },
              child: Row(
                children: [
                  UserImagesSmall(
                      imageUrl: activeMatches[index].matchedUser.imageUrls[0]),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        activeMatches[index].matchedUser.name,
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      SizedBox(height: 5),
                      Text(
                        activeMatches[index].chat[0]!.messages[0].message,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      SizedBox(height: 5),
                      Text(
                        activeMatches[index].chat[0]!.messages[0].timeString,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ],
                  )
                ],
              ),
            );
          },
        ));
  }
}
