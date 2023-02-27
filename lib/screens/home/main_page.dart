// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hero/blocs/swipe/swipe_bloc.dart';
import 'package:hero/cubits/localuser/localuser_cubit.dart';
import 'package:hero/cubits/signup/bottomNavBar/bottomnavbar_cubit.dart';
import 'package:hero/models/models.dart';
import 'package:hero/repository/firestore_repository.dart';
import 'package:hero/screens/home/home_screens/active_chats_screen.dart';
import 'package:hero/screens/home/home_screens/likes_screen.dart';
import 'package:hero/screens/home/home_screens/screens.dart';
import 'package:hero/screens/home/home_screens/settings_screen.dart';
import 'package:hero/screens/home/home_screens/votes/vote_screen.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  @override
  static const String routeName = '/wrapper/mainPage';
  static Route route() {
    return MaterialPageRoute(
      builder: (_) => MainPage(),
      settings: RouteSettings(name: routeName),
    );
  }

  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  /// Create a list of pages to make the code shorter and better readability
  ///

  final _pageNavigation = [
    HomeScreenWrapper(),
    LikesScreen(),
    ActiveChatsScreen(),
    VoteScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomnavbarCubit, int>(
      builder: (context, state) {
        return Scaffold(
          body: _buildBody(state),
          bottomNavigationBar: _buildBottomNav(),
        );
      },
    );
  }

  Widget _buildBody(int index) {
    /// Check if index is in range
    /// else return Not Found widget
    ///
    return _pageNavigation.elementAt(index);
  }

  Widget _buildBottomNav() {
    return BottomNavigationBar(
      currentIndex: context.read<BottomnavbarCubit>().state,
      type: BottomNavigationBarType.fixed,
      onTap: _getChangeBottomNav,
      selectedItemColor: Theme.of(context).primaryColor,
      // ignore: prefer_const_literals_to_create_immutables
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.apps), label: "Likes"),
        BottomNavigationBarItem(
            icon: Icon(Icons.notification_important), label: 'Chats'),
        BottomNavigationBarItem(
            icon: Icon(Icons.how_to_vote_rounded), label: "Votes"),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings"),
      ],
    );
  }

  void _getChangeBottomNav(int index) {
    context.read<BottomnavbarCubit>().updateIndex(index);
  }
}
