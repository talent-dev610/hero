import 'package:hero/models/models.dart';
import 'package:hero/widgets/top_appBar.dart';
import 'package:hero/widgets/widgets.dart';
import 'package:flutter/material.dart';

class MatchesScreen extends StatelessWidget {
  static const String routeName = '/matches';

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => MatchesScreen(),
      settings: RouteSettings(name: routeName),
    );
  }

  @override
  Widget build(BuildContext context) {
    final inactiveMatches = UserMatch.matches
        .where((match) => match.userId == 1 && match.chat.isEmpty)
        .toList();
    final activeMatches = UserMatch.matches
        .where((match) => match.userId == 1 && match.chat.isNotEmpty)
        .toList();

    return Scaffold(
        appBar: TopAppBar(title: 'MATCHES'),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Your likes',
                  style: Theme.of(context).textTheme.headline4,
                ),
                SizedBox(
                  height: 100,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: inactiveMatches.length,
                      itemBuilder: (context, index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            UserImagesSmall(
                                height: 70,
                                width: 70,
                                imageUrl: inactiveMatches[index]
                                    .matchedUser
                                    .imageUrls[0]),
                            Text(
                              inactiveMatches[index].matchedUser.name,
                              style: Theme.of(context).textTheme.headline5,
                            )
                          ],
                        );
                      }),
                ),
                SizedBox(height: 10),
                Text(
                  'Your Chats',
                  style: Theme.of(context).textTheme.headline4,
                ),
                ListView.builder(
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
                              imageUrl: activeMatches[index]
                                  .matchedUser
                                  .imageUrls[0]),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                activeMatches[index].matchedUser.name,
                                style: Theme.of(context).textTheme.headline5,
                              ),
                              SizedBox(height: 5),
                              Text(
                                activeMatches[index]
                                    .chat[0]!
                                    .messages[0]
                                    .message,
                                style: Theme.of(context).textTheme.headline6,
                              ),
                              SizedBox(height: 5),
                              Text(
                                activeMatches[index]
                                    .chat[0]!
                                    .messages[0]
                                    .timeString,
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            ],
                          )
                        ],
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ));
  }
}
