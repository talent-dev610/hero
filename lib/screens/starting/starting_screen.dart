import 'package:hero/screens/onboarding/onboarding_screens/bio_screen.dart';
import 'package:hero/widgets/widgets.dart';
import 'package:flutter/material.dart';

import 'starting_screens/start_screens.dart';

class StartingScreen extends StatelessWidget {
  static const String routeName = '/onboarding';

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (context) => StartingScreen(),
    );
  }

  static const List<Tab> tabs = <Tab>[
    Tab(text: 'Start'),
    Tab(text: 'Login'),
    Tab(text: 'Signup'),
    Tab(text: 'LoginWait'),
    Tab(text: 'SignupWait'),
  ];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Builder(builder: (BuildContext context) {
        final TabController tabController = DefaultTabController.of(context)!;
        tabController.addListener(() {
          if (!tabController.indexIsChanging) {}
        });

        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: TopAppBar(
            title: 'Welcome!',
            hasActions: false,
          ),
          body: TabBarView(
            children: [
              Start(tabController: tabController),
              LoginScreen(tabController: tabController),
              Email(tabController: tabController),
              LoginWait(tabController: tabController),
              SignupWait(tabController: tabController)
            ],
          ),
        );
      }),
    );
  }
}
