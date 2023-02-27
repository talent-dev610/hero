import 'package:flutter/material.dart';
import 'package:hero/models/models.dart';
import 'package:hero/repository/firestore_repository.dart';
import 'package:hero/widgets/like_card.dart';
import 'package:hero/widgets/widgets.dart';
import 'package:provider/provider.dart';

class LikesScreen extends StatelessWidget {
  const LikesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _isLoaded = false;
    final allStingrays = Provider.of<List<Stingray?>>(context);

    if (Provider.of<List<Stingray?>>(context) != null) _isLoaded = true;

    if (_isLoaded == true) {
      return Scaffold(
          appBar: TopAppBar(title: 'Likes'),
        body: GridView.builder(
              shrinkWrap: true,
              itemCount: allStingrays.length,
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 150),
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(allStingrays[index]!.name),
                    ListView.builder(
                        itemCount: allStingrays[index]!.likes.length,
                        physics: ClampingScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int nestedIndex) {
                          return Column(
                            children: [
                              Text(
                                  allStingrays[index]!.likes[nestedIndex]!.name)
                            ],
                          );
                        }),
                  ],
                );
                // return Row(
                //   children: [
                //     LikeCard(user: localStingray.likes[index]),
                //   ],
              }));
    } else {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
  }
}
