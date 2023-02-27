import 'package:hero/cubits/signupNew/cubit/signup_cubit.dart';
import 'package:hero/screens/onboarding/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class Email extends StatelessWidget {
  final TabController tabController;

  const Email({
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  CustomTextHeader(
                    tabController: tabController,
                    text: 'What\'s your email address?',
                  ),
                  CustomTextField(
                    hint: 'ENTER YOUR EMAIL',
                    onChanged: (value) {
                      context.read<SignupCubit>().emailChanged(value);
                      print(context.read<SignupCubit>().state.email);
                    },
                  ),
                  SizedBox(height: 100),
                  CustomTextHeader(
                    tabController: tabController,
                    text: 'Choose a Password',
                  ),
                  CustomTextField(
                    hint: 'ENTER YOUR PASSWORD',
                    onChanged: (value) {
                      context.read<SignupCubit>().passwordChanged(value);
                      print(context.read<SignupCubit>().state.password);
                    },
                  ),
                ],
              ),
            ],
          ),
          Column(
            children: [
              StepProgressIndicator(
                totalSteps: 6,
                currentStep: 1,
                selectedColor: Theme.of(context).primaryColor,
                unselectedColor: Theme.of(context).scaffoldBackgroundColor,
              ),
              SizedBox(height: 10),
              CustomButton(
                tabController: tabController,
                text: 'NEXT STEP',
                addedIndex: 2,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
