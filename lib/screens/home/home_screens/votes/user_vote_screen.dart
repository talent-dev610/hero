import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hero/blocs/profile/profile_bloc.dart';

import 'package:hero/models/models.dart';
import 'package:hero/repository/firestore_repository.dart';
import 'package:hero/widgets/top_appBar.dart';

class UserVoteScreen extends StatelessWidget {
  static const String routeName = 'userVotePage';

  static Route route({required User? user}) {
    return MaterialPageRoute(
      builder: (_) => UserVoteScreen(user: user),
      settings: RouteSettings(name: routeName),
    );
  }

  final User? user;
  const UserVoteScreen({required this.user});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is ProfileLoaded) {
          String votesUsable = state.user.votesUsable.toString();
          String name = user!.name;

          return Scaffold(
            appBar: TopAppBar(
              title: 'Vote',
            ),
            body: ListView(
              children: [
                Column(
                  children: [
                    SizedBox(height: 10),
                    Stack(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height / 1.5,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey,
                                  offset: Offset(3, 3),
                                  blurRadius: 3,
                                  spreadRadius: 3)
                            ],
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image: NetworkImage(user!.imageUrls[0]),
                            ),
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height / 1.5,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(13),
                            gradient: LinearGradient(
                              colors: [
                                Theme.of(context).primaryColor.withOpacity(0.1),
                                Theme.of(context).primaryColor.withOpacity(0.9),
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 40.0),
                              child: Text(
                                (user!.name),
                                style: Theme.of(context)
                                    .textTheme
                                    .headline1!
                                    .copyWith(
                                        color: Theme.of(context)
                                            .scaffoldBackgroundColor),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    Container(
                        child: Center(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          gradient: LinearGradient(colors: [
                            Theme.of(context).primaryColor,
                            Theme.of(context).backgroundColor,
                          ]),
                        ),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            primary: Colors.transparent,
                          ),
                          child: const Text('Vote!'),
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return VotePopup(
                                  name: name,
                                  votesUsable: votesUsable,
                                  localId: state.user.id,
                                  voteTargetId: user!.id,
                                  votesUsableInt: state.user.votesUsable,
                                );
                              },
                            );
                          },
                        ),
                      ),
                    )),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Biography',
                                style: Theme.of(context).textTheme.headline3,
                              ),
                              IconButton(
                                  onPressed: () {
                                    print('bruh');
                                  },
                                  icon: Icon(Icons.edit))
                            ],
                          ),
                          Text(user!.bio,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(height: 1.5)),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        } else {
          return Text('Something went wrong.');
        }
      },
    );
  }
}

class VotePopup extends StatelessWidget {
  const VotePopup({
    Key? key,
    required this.name,
    required this.votesUsableInt,
    required this.votesUsable,
    required this.voteTargetId,
    required this.localId,
  }) : super(key: key);

  final String name;
  final String votesUsable;
  final String? localId;
  final String? voteTargetId;
  final int votesUsableInt;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 2,
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Vote for ${name}?",
                style: Theme.of(context)
                    .textTheme
                    .headline1!
                    .copyWith(color: Theme.of(context).primaryColor)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  child: IconButton(
                    onPressed: () {
                      FirestoreRepository(id: localId)
                          .voteEvent(voteTargetId, votesUsableInt);
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.check_circle_outline_rounded),
                    iconSize: 150,
                    color: Colors.green,
                  ),
                ),
                InkWell(
                  child: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Icons.clear_rounded),
                    color: Colors.red,
                    iconSize: 150,
                  ),
                )
              ],
            ),
            Text('Votes remaining: $votesUsable',
                style: Theme.of(context)
                    .textTheme
                    .subtitle1!
                    .copyWith(color: Theme.of(context).primaryColor))
          ],
        ),
      ),
    );
  }
}

// class VotingPopup extends StatelessWidget {
//   const VotingPopup({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: DecoratedBox(
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(5.0),
//           gradient: LinearGradient(colors: [
//             Theme.of(context).primaryColor,
//             Theme.of(context).backgroundColor,
//           ]),
//         ),
//         child: ElevatedButton(
//           style: ElevatedButton.styleFrom(
//             elevation: 0,
//             primary: Colors.transparent,
//           ),
//           child: const Text('Vote!'),
//           onPressed: () {
//             showModalBottomSheet<void>(
//               context: context,
//               builder: (BuildContext context) {
//                 return Container(
//                   height: MediaQuery.of(context).size.height / 2,
//                   color: Theme.of(context).scaffoldBackgroundColor,
//                   child: Center(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       mainAxisSize: MainAxisSize.min,
//                       children: <Widget>[
//                         Text('Vote for $name?',
//                             style: Theme.of(context)
//                                 .textTheme
//                                 .headline1!
//                                 .copyWith(
//                                     color: Theme.of(context).primaryColor)),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             InkWell(
//                               child: IconButton(
//                                 onPressed: () => print('bruh'),
//                                 icon: Icon(Icons.check_circle_outline_rounded),
//                                 iconSize: 150,
//                                 color: Colors.green,
//                               ),
//                             ),
//                             InkWell(
//                               child: IconButton(
//                                 onPressed: () => Navigator.pop(context),
//                                 icon: Icon(Icons.clear_rounded),
//                                 color: Colors.red,
//                                 iconSize: 150,
//                               ),
//                             )
//                           ],
//                         ),
//                         Text('votes remaining: $votes',
//                             style: Theme.of(context)
//                                 .textTheme
//                                 .subtitle1!
//                                 .copyWith(
//                                     color: Theme.of(context).primaryColor))
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
