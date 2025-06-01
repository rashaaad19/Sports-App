import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sportsapp/cubit/teams_state.dart';
import 'package:sportsapp/data/models/teams_model.dart';
import 'package:sportsapp/repos/teams_repo.dart';

class TeamsCubit extends Cubit<TeamsState> {
  final TeamsRepo teamsRepo;

  TeamsCubit(this.teamsRepo) : super(TeamsInitial());

  //* Fetching leagues by country ID
  Future<void> fetchTeamsById(int leagueId) async {
    emit(TeamsLoading());

    try {
      final TeamResponseModel? response = await teamsRepo.getTeamsById(
        leagueId,
      );
      if (response != null) {
        emit(TeamsLoaded(response));
      } else {
        emit(TeamsError("No teams found for League ID $leagueId"));
      }
    } catch (e) {
      emit(TeamsError("Failed to fetch teams: $e"));
    }
  }
}
