import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hero/repository/firestore_repository.dart';

import '../auth/auth_bloc.dart';
import '../profile/profile_bloc.dart';
import '/models/models.dart';

part 'swipe_event.dart';

part 'swipe_state.dart';

class SwipeBloc extends Bloc<SwipeEvent, SwipeState> {
  final ProfileBloc _profileBloc;
  final FirestoreRepository _firestoreRepository;
  StreamSubscription? _profileSubscription;

  SwipeBloc({
    required ProfileBloc authBloc,
    required FirestoreRepository databaseRepository,
  })  : _profileBloc = authBloc,
        _firestoreRepository = databaseRepository,
        super(SwipeLoading()) {
    on<LoadUsers>(_onLoadUsers);
    on<UpdateHome>(_onUpdateHome);
    on<SwipeLeft>(_onSwipeLeft);
    on<SwipeRight>(_onSwipeRight);

    _profileSubscription = _profileBloc.stream.listen((state) {
      if (state is ProfileLoaded) {
        if (state.user.isStingray) {
          add(LoadUsers(userId: state.user.id!));
        }
      }
    });
  }

  void _onLoadUsers(
    LoadUsers event,
    Emitter<SwipeState> emit,
  ) {
    _firestoreRepository.getUsers(event.userId).listen((users) {
      print('$users');
      add(
        UpdateHome(users: users),
      );
    });
  }

  void _onUpdateHome(
    UpdateHome event,
    Emitter<SwipeState> emit,
  ) {
    if (event.users != null) {
      emit(SwipeLoaded(users: event.users!));
    } else {
      emit(SwipeError());
    }
  }

  void _onSwipeLeft(
    SwipeLeft event,
    Emitter<SwipeState> emit,
  ) {
    if (state is SwipeLoaded) {
      final state = this.state as SwipeLoaded;

      List<User> users = List.from(state.users)..remove(event.user);

      if (users.isNotEmpty) {
        emit(SwipeLoaded(users: users));
      } else {
        emit(SwipeError());
      }
    }
  }

  void _onSwipeRight(
    SwipeRight event,
    Emitter<SwipeState> emit,
  ) {
    if (state is SwipeLoaded) {
      final state = this.state as SwipeLoaded;
      FirestoreRepository().updateStingrayLikes(event.id, event.user);
      FirestoreRepository().updateUserStinrayArray(event.user.id, event.id);
      List<User> users = List.from(state.users)..remove(event.user);

      if (users.isNotEmpty) {
        emit(SwipeLoaded(users: users));
      } else {
        emit(SwipeError());
      }
    }
  }

  @override
  Future<void> close() async {
    _profileSubscription?.cancel();
    super.close();
  }
}
