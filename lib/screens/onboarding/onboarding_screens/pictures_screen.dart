import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hero/blocs/profile/profile_bloc.dart';
import 'package:hero/screens/onboarding/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../../../models/models.dart';
import '../widgets/custom_onbaording_buttons.dart';

class Pictures extends StatelessWidget {
  final TabController tabController;
  final User user;

  const Pictures({
    Key? key,
    required this.tabController,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state == ProfileLoaded) {}
        if (state is ProfileLoaded) {
          var images = state.user.imageUrls;
          var imageCount = images.length;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextHeader(
                      text: 'Add 2 or More Pictures',
                      tabController: tabController,
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      height: 350,
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 0.66,
                        ),
                        itemCount: 6,
                        itemBuilder: (BuildContext context, int index) {
                          return (imageCount > index)
                              ? CustomImageContainer(
                                  imageUrl: images[index],
                                  user: state.user,
                                )
                              : CustomImageContainer(
                                  user: state.user,
                                );
                        },
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    StepProgressIndicator(
                      totalSteps: 3,
                      currentStep: 2,
                      selectedColor: Theme.of(context).primaryColor,
                      unselectedColor:
                          Theme.of(context).scaffoldBackgroundColor,
                    ),
                    SizedBox(height: 10),
                    CustomOnboardingButton(
                      id: '',
                      bio: '',
                      tabController: tabController,
                      text: 'NEXT STEP',
                      age: 0,
                      imageCount: state.user.imageUrls.length,
                    ),
                  ],
                ),
              ],
            ),
          );
        }
        return Text('data');
      },
    );
  }
}
