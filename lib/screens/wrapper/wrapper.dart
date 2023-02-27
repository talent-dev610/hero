import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hero/blocs/auth/auth_bloc.dart';
import 'package:hero/cubits/localuser/localuser_cubit.dart';
import 'package:hero/models/models.dart';
import 'package:hero/repository/auth_repository.dart';
import 'package:hero/repository/firestore_repository.dart';
import 'package:hero/screens/email_verification/verification_screen.dart';
import 'package:hero/screens/home/main_page.dart';
import 'package:hero/screens/screens.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

import '../starting/starting_screen.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  static const String routeName = '/wrapper/';
  static Route route() {
    return MaterialPageRoute(
      builder: (_) => Wrapper(),
      settings: RouteSettings(name: routeName),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state != AuthState.unknown()) {
          return state == AuthState.unauthenticated()
              ? StartingScreen()
              : StreamProvider<User?>.value(
                  initialData: null,
                  value: FirestoreRepository(id: state.user!.uid).userData,
                  child: VerifyScreen());
        } else {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
