import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hero/cubits/signupNew/cubit/signup_cubit.dart';
import 'package:hero/models/user_model.dart' as myUser;
import 'package:hero/repository/firestore_repository.dart';
import 'package:provider/src/provider.dart';

import '../../../cubits/signIn/cubit/signin_cubit.dart';

class CustomOnboardingButton extends StatelessWidget {
  final TabController tabController;
  final String text;
  final Function(String)? onChanged;
  final String? id;
  final String? bio;
  final int age;
  final String? gender;
  final int? imageCount;

  const CustomOnboardingButton(
      {Key? key,
      required this.tabController,
      this.text = 'START',
      this.onChanged,
      this.imageCount,
      required this.id,
      required this.bio,
      required this.age,
      this.gender})
      : super(key: key);

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
          try {
            if (tabController.index == 0) {
              FirestoreRepository(id: id).updateGender(id, gender!);
              FirestoreRepository(id: id).updateAge(id, age);
            }
            if (tabController.index == 1) {
              print('bruh');
              if (imageCount! < 2) {
                throw (Exception('You need to have at least two images'));
              }
            }
            if (tabController.index == 2) {
              FirestoreRepository(id: id).updateBio(id, bio!);

              print('moment');
              Navigator.popAndPushNamed(context, '/wrapper/');
            }
            if (tabController.index != 2) {
              tabController.animateTo(tabController.index + 1);
              print(tabController.index);
            }
          } catch (e) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(e.toString())));
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
