import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hero/cubits/signupNew/cubit/signup_cubit.dart';
import 'package:hero/models/user_model.dart' as myUser;
import 'package:provider/src/provider.dart';

import '../../../cubits/signIn/cubit/signin_cubit.dart';

class CustomButton extends StatelessWidget {
  final TabController tabController;
  final String text;
  final int addedIndex;
  const CustomButton({
    Key? key,
    required this.tabController,
    this.text = 'START', required this.addedIndex,
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
        onPressed: () async {
          tabController.animateTo(tabController.index + addedIndex);
          print(tabController.index);
          if (tabController.index == 3) {
            context.read<SigninCubit>().signInWithCredentials();
          }
          if (tabController.index == 4) {
            context.read<SignupCubit>().signUpWithCredentials();
          }
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
