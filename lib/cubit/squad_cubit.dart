import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sportsapp/cubit/squad_state.dart';
import 'package:sportsapp/data/models/squad_model.dart';
import 'package:sportsapp/repos/squad_repo.dart';

class SquadCubit extends Cubit<SquadState> {
  final PlayersRepo playersRepo;

  SquadCubit(this.playersRepo) : super(SquadInitial());

  //* Fetching Players by team ID
  Future<void> fetchPlayersByTeam(int teamId) async {
    emit(SquadLoading());

    try {
      final PlayersResponse? response = await playersRepo.getSquadByTeamId(
        teamId,
      );
      if (response != null) {
        emit(SquadLoaded(response));
      } else {
        emit(SquadError("No Teams found for Team ID $teamId"));
      }
    } catch (e) {
      emit(SquadError("Failed to fetch Teams: $e"));
    }
  }
}
