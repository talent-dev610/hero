import 'package:flutter/material.dart';
import 'package:hero/cubits/signIn/cubit/signin_cubit.dart';
import 'package:hero/repository/auth_repository.dart';
import 'package:hero/screens/onboarding/widgets/custom_login_button.dart';
import 'package:hero/screens/onboarding/widgets/widgets.dart';
import 'package:provider/src/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static const String routeName = '/login';
  static Route route() {
    return MaterialPageRoute(
      builder: (_) => LoginScreen(),
      settings: RouteSettings(name: routeName),
    );
  }

  @override
  Widget build(BuildContext context) {
    final authRepository = Provider.of<AuthRepository>(context);

    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    CustomLoginTextField(
                      controller: emailController,
                      hint: 'ENTER YOUR EMAIL',
                      onChanged: (value) {
                        context.read<SigninCubit>().emailChanged(value);

                        //print(context.read<SigninCubit>().state.email);
                      },
                    ),
                    CustomLoginTextField(
                      controller: passwordController,
                      hint: 'ENTER YOUR PASSWORD',
                      onChanged: (value) {
                        context.read<SigninCubit>().passwordChanged(value);
                        //print(context.read<SigninCubit>().state.password);
                        // print(passwordController.text);
                      },
                    ),
                    SizedBox(height: 100),
                  ],
                ),
              ],
            ),
            CustomLoginButton(text: 'LOGIN',
                email: emailController.text, password: passwordController.text)
            // ElevatedButton(
            //     onPressed: () async {
            //       //context.read<SigninCubit>().signInWithCredentials();
            //       authRepository.signInWithEmailAndPassword(
            //           email: emailController.text,
            //           password: passwordController.text);
            //       print(context.read<SigninCubit>().state);
            //       Navigator.pushNamed(context, '/wrapper');
            //     },
            //     child: Text('bruh'))
          ],
        ),
      ),
    );
  }
}
