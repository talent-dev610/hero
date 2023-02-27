import 'package:hero/models/user_model.dart';
import 'package:hero/screens/onboarding/onboarding_screens/bio_screen.dart';
import 'package:hero/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'onboarding_screens/screens.dart';

class OnboardingScreen extends StatelessWidget {
  static const String routeName = '/onboarding';

  const OnboardingScreen({Key? key, required this.user}) : super(key: key);

  static Route route({required User user}) {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (context) => OnboardingScreen(user: user),
    );
  }

  final User user;
  static const List<Tab> tabs = <Tab>[
    Tab(text: 'Demo'),
    Tab(text: 'Pictures'),
    Tab(text: 'Bio'),
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

        return WillPopScope(
          onWillPop: () async => false,
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: TopAppBar(
              title: 'Welcome!',
              hasActions: false,
            ),
            body: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              children: [
                Demo(tabController: tabController, user: user),
                Pictures(tabController: tabController, user: user),
                Biography(
                  tabController: tabController,
                  user: user,
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
