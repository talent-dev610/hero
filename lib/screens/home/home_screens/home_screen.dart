import 'package:hero/blocs/profile/profile_bloc.dart';
import 'package:hero/blocs/swipe/swipe_bloc.dart';
import 'package:hero/cubits/localuser/localuser_cubit.dart';
import 'package:hero/models/models.dart';
import 'package:hero/repository/firestore_repository.dart';
import 'package:hero/widgets/choice_button.dart';
import 'package:hero/widgets/top_appBar.dart';
import 'package:hero/widgets/user_card.dart';
import 'package:hero/widgets/user_image_small.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/';

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => HomeScreen(),
      settings: RouteSettings(name: routeName),
    );
  }

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    try {
      return BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoading) {
            return Center(
              child: Text('mujuj'),
            );
          }
          if (state is ProfileLoaded) {
            if (state.user.isStingray == true) {
              return StreamBuilder<Stingray?>(
                  stream: FirestoreRepository(id: state.user.id).stingrayData,
                  builder: (context, snapshot) {
                    final Stingray? localStingray = snapshot.data;
                    return StingrayView(localUser: state.user);
                  });
            }
            if (state.user.isStingray == false) {
              return Text('data');
            }
          }
          return Center(child: Text('data'));
        },
      );
    } catch (e) {
      print(e);
      return Text('mujuj');
    }
  }
}

class StingrayView extends StatelessWidget {
  const StingrayView({
    Key? key,
    this.localUser,
  }) : super(key: key);

  final User? localUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: TopAppBar(title: 'Discover'),
        // body: userCard(),
        body: BlocBuilder<SwipeBloc, SwipeState>(
          builder: (context, state) {
            if (state is SwipeLoading) {
              return Center(
                child: Text('mujuj'),
              );
            } else if (state is SwipeLoaded) {
              try {
                return Column(
                  children: [
                    InkWell(
                      onDoubleTap: () {
                        Navigator.pushNamed(context, '/users',
                            arguments: state.users[0]);
                      },
                      child: Draggable(
                        child: UserCard(user: state.users[0]),
                        feedback: UserCard(user: state.users[0]),
                        childWhenDragging: UserCard(user: state.users[1]),
                        onDragEnd: (drag) {
                          if (drag.velocity.pixelsPerSecond.dx < 0 &&
                              drag.offset.distance >
                                  MediaQuery.of(context).size.width * .3) {
                            context.read<SwipeBloc>()
                              ..add(SwipeLeft(user: state.users[0]));
                            print('Swiped left');
                          } else if (drag.velocity.pixelsPerSecond.dx > 0 &&
                              drag.offset.distance >
                                  MediaQuery.of(context).size.width * .3) {
                            context.read<SwipeBloc>()
                              ..add(SwipeRight(
                                  id: localUser!.id!, user: state.users[0]));
                            print('swiped right');
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 60,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              context.read<SwipeBloc>()
                                ..add(SwipeLeft(user: state.users[0]));
                            },
                            child: ChoiceButton(
                              width: 30,
                              height: 30,
                              size: 10,
                              hasGradient: false,
                              color: Theme.of(context).secondaryHeaderColor,
                              icon: Icons.clear_rounded,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              context.read<SwipeBloc>()
                                ..add(SwipeRight(
                                    id: localUser!.id!, user: state.users[0]));
                            },
                            child: ChoiceButton(
                              width: 32,
                              height: 32,
                              size: 10,
                              hasGradient: true,
                              color: Colors.white,
                              icon: Icons.favorite,
                            ),
                          ),
                          ChoiceButton(
                            width: 20,
                            height: 20,
                            size: 25,
                            hasGradient: false,
                            color: Theme.of(context).secondaryHeaderColor,
                            icon: Icons.watch_later,
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              } catch (e) {
                print(e);
                return Text('pls');
              }
            } else {
              return Text('Somethings wrong, yo');
            }
          },
        ));
  }
}

showAlertDialog(BuildContext context) {
  // set up the buttons
  Widget cancelButton = TextButton(
    child: Text("Yes, lets go!"),
    onPressed: () {},
  );
  Widget continueButton = TextButton(
    child: Text("Continue"),
    onPressed: () {},
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("AlertDialog"),
    content:
        Text("Would you like to continue learning how to use Flutter alerts?"),
    actions: [
      cancelButton,
      continueButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
