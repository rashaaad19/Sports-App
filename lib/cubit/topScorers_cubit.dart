import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sportsapp/cubit/topScorers_state.dart';
import 'package:sportsapp/data/models/topScorers_model.dart';
import 'package:sportsapp/repos/topScorers_repo.dart';

class TopscorersCubit extends Cubit<TopscorersState> {
  final TopscorersRepo topScorersRepo;

  TopscorersCubit(this.topScorersRepo) : super(TopScorersInitial());

  //* Fetching top scorers by league ID
  Future<void> fetchTopScorers(int leagueId) async {
    emit(TopScorersLoading());

    try {
      final TopScorersResponseModel? response = await TopscorersRepo().getTopScorers(leagueId);
      if (response != null) {
        emit(TopScorersLoaded(response));
      } else {
        emit(TopScorersError("No top scorers found for league ID $leagueId"));
      }
    } catch (e) {
      emit(TopScorersError("Failed to fetch top scorers: $e"));
    }
  }
}
