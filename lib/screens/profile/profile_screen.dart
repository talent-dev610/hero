import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:hero/blocs/auth/auth_bloc.dart';
import 'package:hero/blocs/profile/profile_bloc.dart';
import 'package:hero/cubits/edit_bio/editbio_cubit.dart';
import 'package:hero/repository/auth_repository.dart';
import 'package:hero/repository/firestore_repository.dart';
import 'package:hero/repository/storage_repository.dart';
import 'package:hero/screens/starting/starting_screen.dart';
import 'package:image_picker/image_picker.dart';

import '../../blocs/onboarding/onboarding_bloc.dart';
import '../../models/models.dart';
import '/screens/screens.dart';
import '/widgets/widgets.dart';

class ProfileScreen extends StatelessWidget {
  static const String routeName = '/profile';

  static Route route() {
    return MaterialPageRoute(
        settings: RouteSettings(name: routeName),
        builder: (context) {
          print(BlocProvider.of<AuthBloc>(context).state);

          return BlocProvider.of<AuthBloc>(context).state.status ==
                  AuthStatus.unauthenticated
              ? StartingScreen()
              : ProfileScreen();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopAppBar(
        title: 'PROFILE',
      ),
      body: SingleChildScrollView(
        child: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is ProfileLoaded) {
              if (state.user.finishedOnboarding == true) {
                return OnboardingFinishedView(user: state.user);
              } else {
                return OnbaordingNotFinishedView(user: state.user);
              }
            } else {
              return Text('Something went wrong.');
            }
          },
        ),
      ),
    );
  }
}

class OnbaordingNotFinishedView extends StatelessWidget {
  final User? user;
  const OnbaordingNotFinishedView({
    Key? key, this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width * .4,
              child: Text(
                'Looks like youre a stupid fucking idiot who hasnt made their profile yet.'
                ' Wanna do that now or later?',
                style: Theme.of(context)
                    .textTheme
                    .headline3!
                    .copyWith(color: Theme.of(context).primaryColor),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    'Later',
                  ),
                  style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).primaryColor,
                      textStyle: Theme.of(context).textTheme.headline5),
                ),
                ElevatedButton(
                  onPressed: () =>
                      Navigator.popAndPushNamed(context, '/onboarding',arguments: user),
                  child: Text('Now'),
                  style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).primaryColor,
                      textStyle: Theme.of(context).textTheme.headline5),
                )
              ],
            ),
            Container(
              child: Image(image: AssetImage('assets/smugug.png')),
            ),
          ],
        ),
      ),
    );
  }
}

class OnboardingFinishedView extends StatelessWidget {
  final User user;
  const OnboardingFinishedView({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 10),
        UserImage.medium(
          url: user.imageUrls[0],
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).primaryColor.withOpacity(0.1),
                  Theme.of(context).primaryColor.withOpacity(0.9),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 40.0),
                child: Text(
                  user.name,
                  style: Theme.of(context)
                      .textTheme
                      .headline1!
                      .copyWith(color: Colors.white),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TitleWithIcon(
                title: 'Biography',
                icon: Icons.edit,
                callback: () => showModalBottomSheet(
                    context: context,
                    builder: (builder) {
                      return BioEditingPopup(
                        bio: user.bio,
                        id: user.id,
                      );
                    }),
              ),
              Text(
                user.bio,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(height: 1.5),
              ),
              TitleWithIcon(
                  title: 'Pictures',
                  icon: Icons.edit,
                  callback: () => UploadImage(context, user)),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                height: user.imageUrls.length > 0 ? 125 : 0,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: user.imageUrls.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 5.0),
                      child: UserImage.small(
                        width: 100,
                        url: user.imageUrls[index],
                        border: Border.all(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    );
                  },
                ),
              ),
              TitleWithIcon(
                title: 'Location',
                icon: Icons.edit,
                callback: () => print('object'),
              ),
              TitleWithIcon(
                title: 'Interest',
                icon: Icons.edit,
                callback: () => showModalBottomSheet(
                    context: context,
                    builder: (builder) {
                      return InterestEditingPopup(
                        id: user.id,
                      );
                    }),
              ),
              ListView.builder(
                itemCount: user.interests.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return Container(child: Text(user.interests[index]));
                },
              ),
            ],
          ),
        )
      ],
    );
  }
}

class BioEditingPopup extends StatelessWidget {
  final String bio;
  final String? id;
  const BioEditingPopup({
    Key? key,
    required this.bio,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          BioForm(bio: bio),
          ElevatedButton(
              onPressed: () {
                context.read<EditbioCubit>().EditbioWithCredentials();
                if (context.read<EditbioCubit>().state.status ==
                    EditbioStatus.success) {
                  FirestoreRepository(id: id)
                      .updateBio(id, context.read<EditbioCubit>().state.bio);
                  Navigator.pop(context);
                } else {
                  print('bitch');
                }
              },
              child: Text('bruh'))
        ],
      ),
    );
  }
}

class TitleWithIcon extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback callback;

  const TitleWithIcon({
    Key? key,
    required this.title,
    required this.icon,
    required this.callback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headline3,
        ),
        IconButton(
          icon: Icon(icon),
          onPressed: () => callback(),
        ),
      ],
    );
  }
}

class BioForm extends StatelessWidget {
  final String bio;
  BioForm({
    Key? key,
    required this.bio,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextField(
            decoration:
                InputDecoration(border: OutlineInputBorder(), hintText: bio),
            onChanged: (text) {
              context.read<EditbioCubit>().bioChanged(text);
              print(context.read<EditbioCubit>().state.bio);
            },
          ),
        ),
      ],
    );
  }
}

class InterestEditingPopup extends StatelessWidget {
  final String? id;
  const InterestEditingPopup({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          InterestForm(),
          ElevatedButton(
              onPressed: () {
                context.read<EditbioCubit>().EditbioWithCredentials();
                if (context.read<EditbioCubit>().state.status ==
                    EditbioStatus.success) {
                  FirestoreRepository(id: id).updateInterest(
                      id, context.read<EditbioCubit>().state.interest);
                  Navigator.pop(context);
                } else {
                  print('bitch');
                }
              },
              child: Text('bruh'))
        ],
      ),
    );
  }
}

class InterestForm extends StatelessWidget {
  InterestForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextField(
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Insert interest here!"),
            onChanged: (text) {
              context.read<EditbioCubit>().interestChanged(text);
              print(context.read<EditbioCubit>().state.interest);
            },
          ),
        ),
      ],
    );
  }
}

void UploadImage(context, User user) async {
  if (user.imageUrls.length > 5) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('You already have 6 images.')));
  } else {
    ImagePicker _picker = ImagePicker();
    final XFile? _image = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );

    if (_image == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('No image was selected.')));
    }

    if (_image != null) {
      print('Uploading ...');
      StorageRepository().uploadImage(user, _image);
    }
  }
}
