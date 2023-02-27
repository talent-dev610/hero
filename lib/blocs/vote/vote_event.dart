part of 'vote_bloc.dart';

abstract class VoteEvent extends Equatable {
  const VoteEvent();

  @override
  List<Object> get props => [];
}

class VoteUserEvent extends VoteEvent {
  final User user;

  const VoteUserEvent({required this.user});

  @override
  List<Object> get props => [user];
}
