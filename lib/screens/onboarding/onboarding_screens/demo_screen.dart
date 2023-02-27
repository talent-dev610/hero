import 'package:hero/screens/onboarding/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../../../models/models.dart';
import '../widgets/custom_onbaording_buttons.dart';

class Demo extends StatefulWidget {
  final TabController tabController;
  final User user;
  const Demo({
    Key? key,
    required this.tabController,
    required this.user,
  }) : super(key: key);

  @override
  State<Demo> createState() => _DemoState();
}

class _DemoState extends State<Demo> {
  int age = 0;
  String gender = '';

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextHeader(
                    tabController: widget.tabController,
                    text: 'What\'s your gender?',
                  ),

                  SizedBox(height: 10),
                  CustomTextField(
                    hint: 'ENTER YOUR GENDER',
                    onChanged: (val) => setState(() => gender = val),
                  ),
                  // CustomCheckbox(
                  //     tabController: widget.tabController, text: 'MALE'),
                  // CustomCheckbox(
                  //     tabController: widget.tabController, text: 'FEMALE'),
                  SizedBox(height: 100),
                  CustomTextHeader(
                    tabController: widget.tabController,
                    text: 'What\'s your age?',
                  ),
                  CustomTextField(
                    hint: 'ENTER YOUR AGE',
                    onChanged: (val) => setState(() => age = int.parse(val)),
                  ),
                ],
              ),
            ],
          ),
          Column(
            children: [
              StepProgressIndicator(
                totalSteps: 3,
                currentStep: 1,
                selectedColor: Theme.of(context).primaryColor,
                unselectedColor: Theme.of(context).scaffoldBackgroundColor,
              ),
              SizedBox(height: 10),
              CustomOnboardingButton(
                age: age,
                tabController: widget.tabController,
                text: 'NEXT STEP',
                id: widget.user.id,
                bio: '',
                gender: gender,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
