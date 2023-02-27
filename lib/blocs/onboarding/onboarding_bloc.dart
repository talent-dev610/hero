import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hero/repository/firestore_repository.dart';
import 'package:hero/repository/storage_repository.dart';
import 'package:image_picker/image_picker.dart';

import '/models/models.dart';

part 'onboarding_event.dart';
part 'onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  final FirestoreRepository _databaseRepository;
  final StorageRepository _storageRepository;

  OnboardingBloc({
    required FirestoreRepository databaseRepository,
    required StorageRepository storageRepository,
  })  : _databaseRepository = databaseRepository,
        _storageRepository = storageRepository,
        super(OnboardingLoading()) {
    // on<StartOnboarding>(_onStartOnboarding);
    on<UpdateUser>(_onUpdateUser);
    on<UpdateUserImages>(_onUpdateUserImages);
  }

  // void _onStartOnboarding(
  //   StartOnboarding event,
  //   Emitter<OnboardingState> emit,
  // )  {
  //   emit(OnboardingLoaded(user: event.user));
  // }

  void _onUpdateUser(
    UpdateUser event,
    Emitter<OnboardingState> emit,
  ) {
    if (state is OnboardingLoaded) {
      _databaseRepository.updateUser(event.user);
      emit(OnboardingLoaded(user: event.user));
    }
  }

  void _onUpdateUserImages(
    UpdateUserImages event,
    Emitter<OnboardingState> emit,
  ) async {
    User user = (state as OnboardingLoaded).user;
    await _storageRepository.uploadImage(user, event.image);

    _databaseRepository.getUser(user.id!).listen((user) {
      add(UpdateUser(user: user));
    });
  }
}
