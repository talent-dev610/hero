import 'package:firebase_core/firebase_core.dart';
import 'package:hero/blocs/auth/auth_bloc.dart';
import 'package:hero/blocs/swipe/swipe_bloc.dart';
import 'package:hero/config/app_router.dart';
import 'package:hero/config/theme.dart';
import 'package:hero/cubits/edit_bio/editbio_cubit.dart';
import 'package:hero/cubits/localuser/localuser_cubit.dart';
import 'package:hero/cubits/signup/bottomNavBar/bottomnavbar_cubit.dart';
import 'package:hero/cubits/signupNew/cubit/signup_cubit.dart';
import 'package:hero/models/models.dart';
import 'package:hero/repository/auth_repository.dart';
import 'package:hero/repository/database.dart';
import 'package:hero/repository/firestore_repository.dart';
import 'package:hero/screens/home/main_page.dart';
import 'package:hero/screens/matches/matches_screen.dart';
import 'package:hero/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hero/screens/home/home_screens/teams_screen.dart';
import 'package:provider/provider.dart';

import 'blocs/onboarding/onboarding_bloc.dart';
import 'blocs/profile/profile_bloc.dart';
import 'cubits/signIn/cubit/signin_cubit.dart';
import 'cubits/update/update_cubit.dart';
import 'models/brew.dart';
import 'repository/storage_repository.dart';

void main() async {
  WidgetsFlutterBinding();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (_) => AuthRepository(),
        ),
        RepositoryProvider(
          create: (_) => FirestoreRepository(),
        ),
        RepositoryProvider(
          create: (context) => StorageRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(
              authRepository: context.read<AuthRepository>(),
            ),
          ),
          BlocProvider<BottomnavbarCubit>(
            create: (context) => BottomnavbarCubit(),
            child: MainPage(),
          ),
          BlocProvider<SignupCubit>(
            create: (context) => SignupCubit(
              authRepository: context.read<AuthRepository>(),
            ),
          ),
          BlocProvider<LocaluserCubit>(
            create: (context) => LocaluserCubit(),
            child: MaterialApp(),
          ),
          BlocProvider<SigninCubit>(
            create: (context) => SigninCubit(
              authRepository: context.read<AuthRepository>(),
            ),
          ),
          BlocProvider<UpdateCubit>(
            create: (context) => UpdateCubit(
              firestoreRepository: context.read<FirestoreRepository>(),
            ),
          ),
          BlocProvider<ProfileBloc>(
            create: (context) => ProfileBloc(
              authBloc: BlocProvider.of<AuthBloc>(context),
              databaseRepository: context.read<FirestoreRepository>(),
            )..add(
                LoadProfile(
                    userId: BlocProvider.of<AuthBloc>(context).state.user!.uid),
              ),
          ),
          BlocProvider<EditbioCubit>(
            create: (context) => EditbioCubit(),
          ),
          BlocProvider<OnboardingBloc>(
            create: (context) => OnboardingBloc(
              databaseRepository: context.read<FirestoreRepository>(),
              storageRepository: context.read<StorageRepository>(),
            ),
          ),
        ],
        child: MultiProvider(
          providers: [
            Provider<AuthRepository>(
              create: (_) => AuthRepository(),
            ),
            StreamProvider<List<Stingray?>>.value(
              value: FirestoreRepository().stingrays,
              initialData: [],
            ),
          ],
          child: MaterialApp(
            title: 'Tone',
            theme: theme(),
            onGenerateRoute: AppRouter.onGenerateRoute,
            initialRoute: Wrapper.routeName,
          ),
        ),
      ),
    );
  }
}
