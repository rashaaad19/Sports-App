import 'package:sportsapp/data/models/teams_model.dart';

abstract class TeamsState {}

class TeamsInitial extends TeamsState {}

class TeamsLoading extends TeamsState {}

class TeamsLoaded extends TeamsState {
  final TeamResponseModel teamResponse;
  TeamsLoaded(this.teamResponse);
}

class TeamsError extends TeamsState {
  final String message;
  TeamsError(this.message);
}
