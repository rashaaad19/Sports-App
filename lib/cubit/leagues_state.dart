import 'package:sportsapp/data/models/leages_model.dart';

abstract class LeaguesState {}

class LeaguesInitial extends LeaguesState {}

class LeaguesLoading extends LeaguesState {}

class LeaguesLoaded extends LeaguesState {
  final LeagueResponseModel leagueResponse;
  LeaguesLoaded(this.leagueResponse);
}

class LeaguesError extends LeaguesState {
  final String message;
  LeaguesError(this.message);
}
