import 'package:hero/models/models.dart';
import 'package:hero/screens/home/home_screens/votes/user_vote_screen.dart';
import 'package:hero/screens/home/main_page.dart';
import 'package:hero/screens/matches/matches_screen.dart';
import 'package:hero/screens/onboarding/onboarding_screens/login_screen.dart';
import 'package:hero/screens/screens.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    print('The Route is: ${settings.name}');

    switch (settings.name) {
      case '/':
        return MainPage.route();
      case HomeScreen.routeName:
        return HomeScreen.route();
      case MatchesScreen.routeName:
        return MatchesScreen.route();
      case UsersScreen.routeName:
        return UsersScreen.route(user: settings.arguments as User);
      case OnboardingScreen.routeName:
        return OnboardingScreen.route(user: settings.arguments as User);
      case MatchesScreen.routeName:
        return MatchesScreen.route();
      case ProfileScreen.routeName:
        return ProfileScreen.route();
      case ChatScreen.routeName:
        return ChatScreen.route(userMatch: settings.arguments as UserMatch);
      case TeamScreen.routeName:
        return TeamScreen.route();
      case MainPage.routeName:
        return MainPage.route();
      case Wrapper.routeName:
        return Wrapper.route();
             case UserVoteScreen.routeName:
        return UserVoteScreen.route(user: settings.arguments as User);
      default:
        return _errorRoute();
    }
  }

  static const String routeName = '/';

  static Route _errorRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(appBar: AppBar(title: Text('error'))),
      settings: RouteSettings(name: '/error'),
    );
  }
}
