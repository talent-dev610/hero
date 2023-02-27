import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hero/blocs/profile/profile_bloc.dart';
import 'package:hero/blocs/swipe/swipe_bloc.dart';
import 'package:hero/cubits/localuser/localuser_cubit.dart';
import 'package:hero/models/models.dart';
import 'package:hero/repository/firestore_repository.dart';
import 'package:hero/screens/home/home_screens/screens.dart';
import 'package:hero/screens/screens.dart';
import 'package:provider/src/provider.dart';

import '../../../blocs/auth/auth_bloc.dart';

class HomeScreenWrapper extends StatelessWidget {
  const HomeScreenWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    try {
      final User? userData = context.read<LocaluserCubit>().state.user;
      if (userData!.isStingray == true) {
        return StreamBuilder<List<User?>>(
            stream: FirestoreRepository(stingrayId: userData.id).differentUsers,
            builder: (context, AsyncSnapshot<List<User?>> snapshot) {
              try {
                final List<User?> users = snapshot.data as List<User?>;
                return BlocProvider(
                  create: (_) =>
                      SwipeBloc(authBloc: BlocProvider.of<ProfileBloc>(context), databaseRepository: context.read<FirestoreRepository>())..add(LoadUsers(users: users, likes: [])),
                  child: HomeScreen(),
                );
              } catch (e) {
                return Text('mj');
              }
            });
      } else
        return NormalHomeScreen();
    } catch (e) {
      print(e);
      return Text('mucho');
    }
  }
}
