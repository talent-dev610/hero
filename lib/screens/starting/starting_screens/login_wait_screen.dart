import 'package:hero/cubits/signupNew/cubit/signup_cubit.dart';
import 'package:hero/screens/onboarding/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class LoginWait extends StatelessWidget {
  final TabController tabController;

  const LoginWait({
    Key? key,
    required this.tabController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column();
  }
}
