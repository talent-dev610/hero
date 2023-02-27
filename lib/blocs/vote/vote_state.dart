part of 'vote_bloc.dart';

abstract class VoteState extends Equatable {
  const VoteState();

  @override
  List<Object> get props => [];
}

class VoteInitialUh extends VoteState {}

class VoteInitial extends VoteState {
  final User user;

  const VoteInitial({
    required this.user,
  });

  @override
  List<Object> get props => [user];
}
