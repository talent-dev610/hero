import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hero/repository/auth_repository.dart';

part 'signin_state.dart';

class SigninCubit extends Cubit<SigninState> {
  final AuthRepository _authRepository;

  SigninCubit({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(SigninState.initial());

  void emailChanged(String value) {
    emit(state.copyWith(email: value, status: SigninStatus.initial));
  }

  void passwordChanged(String value) {
    emit(state.copyWith(password: value, status: SigninStatus.initial));
  }

  void signInWithCredentials() async {
    try {
      await _authRepository.signInWithEmailAndPassword(
          email: state.email, password: state.password);
      emit(
        state.copyWith(status: SigninStatus.success),
      );
    } catch (_) {}
  }
}
