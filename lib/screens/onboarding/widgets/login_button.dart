import 'package:flutter/material.dart';
import 'package:hero/screens/onboarding/onboarding_screens/login_screen.dart';

class LoginButton extends StatelessWidget {
  final String text;

  const LoginButton({
    Key? key,
    this.text = 'LOGIN',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
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
        onPressed: () {
          Navigator.pushNamed(context, '/login');
        },
        child: Container(
          width: double.infinity,
          child: Center(
            child: Text(
              text,
              style: Theme.of(context)
                  .textTheme
                  .headline4!
                  .copyWith(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
