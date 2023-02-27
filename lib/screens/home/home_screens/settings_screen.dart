import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hero/blocs/profile/profile_bloc.dart';
import 'package:hero/cubits/localuser/localuser_cubit.dart';
import 'package:hero/models/brew.dart';
import 'package:hero/models/models.dart' as myUser;
import 'package:hero/repository/firestore_repository.dart';
import 'package:hero/widgets/widgets.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  static const String routeName = '/settings';
  SettingsScreen({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => SettingsScreen(),
      settings: RouteSettings(name: routeName),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoaded) {
          return Scaffold(
            appBar: TopAppBar(title: 'Settings'),
            body: Center(
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      _firebaseAuth.signOut();
                      Navigator.popAndPushNamed(context, '/wrapper/');
                    },
                    child: Text('logout'),
                  ),
                ],
              ),
            ),
          );
        }
        return CircularProgressIndicator();
      },
    );
  }
}
