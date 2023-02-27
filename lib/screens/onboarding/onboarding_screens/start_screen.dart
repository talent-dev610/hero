import 'package:hero/screens/onboarding/widgets/login_button.dart';
import 'package:hero/screens/onboarding/widgets/widgets.dart';
import 'package:flutter/material.dart';

class Start extends StatelessWidget {
  final TabController tabController;

  const Start({
    Key? key,
    required this.tabController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 50),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Container(
                    height: 200,
                    width: 200,
                    child: Image(image: AssetImage('assets/smugg.png')),
                  ),
                  SizedBox(height: 50),
                  Text('Welcome to Fishtank!',
                      style: Theme.of(context).textTheme.headline2),
                  SizedBox(height: 20),
                  Text(
                    'Move on to sign up!',
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(height: 1.8),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ],
          ),
          LoginButton(),
          CustomButton(
            tabController: tabController,
            text: 'SIGN UP',
            addedIndex: 1,
          ),
        ],
      ),
    );
  }
}
