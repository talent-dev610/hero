import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hero/models/models.dart';

part 'vote_event.dart';
part 'vote_state.dart';

class VoteBloc extends Bloc<VoteEvent, VoteState> {
  VoteBloc() : super(VoteInitialUh()) {
    on<VoteEvent>((event, emit) {});
  }
  @override
  Stream<VoteState> mapEventToState(
    VoteEvent event,
  ) async* {
    if (event is VoteUserEvent) {
      yield* _mapLoadUsersToState(event, state);
    }
  }

  Stream<VoteState> _mapLoadUsersToState(
      VoteUserEvent event, VoteState state) async* {
    yield VoteInitial(user: event.user);
  }
}
