
import 'package:sportsapp/data/models/topScorers_model.dart';

abstract class TopscorersState {}

class TopScorersInitial extends TopscorersState {}

class TopScorersLoading extends TopscorersState {}

class TopScorersLoaded extends TopscorersState {
  final TopScorersResponseModel topScorersResponse;
  TopScorersLoaded(this.topScorersResponse);
}

class TopScorersError extends TopscorersState {
  final String message;
  TopScorersError(this.message);
}
