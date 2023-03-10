part of 'onboarding_bloc.dart';

abstract class OnboardingEvent extends Equatable {
  const OnboardingEvent();

  @override
  List<Object?> get props => [];
}

class StartOnboarding extends OnboardingEvent {
  final User? user;

  const StartOnboarding({
    this.user = const User(
            id: '',
            name: '',
            age: 0,
            imageUrls: [],
            jobTitle: '',
            bio: '',
            interests: [],
            isRude: false,
            instigations: 0,
            votes: 0,
            votesUsable: 0,
            stingrays: [],
            finishedOnboarding: false,
          )
  });

  @override
  List<Object?> get props => [user];
}

class UpdateUser extends OnboardingEvent {
  final User user;

  const UpdateUser({required this.user});

  @override
  List<Object?> get props => [user];
}

class UpdateUserImages extends OnboardingEvent {
  final User? user;
  final XFile image;

  const UpdateUserImages({
    this.user,
    required this.image,
  });

  @override
  List<Object?> get props => [user, image];
}
