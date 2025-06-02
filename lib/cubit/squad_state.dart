import 'package:sportsapp/data/models/squad_model.dart';

abstract class SquadState {}

class SquadInitial extends SquadState {}

class SquadLoading extends SquadState {}

class SquadLoaded extends SquadState {
  final PlayersResponse playersResponse;
  SquadLoaded(this.playersResponse);
}

class SquadError extends SquadState {
  final String message;
  SquadError(this.message);
}
