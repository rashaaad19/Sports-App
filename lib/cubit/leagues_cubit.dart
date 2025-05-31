import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sportsapp/cubit/leagues_state.dart';
import 'package:sportsapp/data/models/leages_model.dart';
import 'package:sportsapp/repos/leagues_repo.dart';

class LeaguesCubit extends Cubit<LeaguesState> {
  final LeaguesRepo leaguesRepo;

  LeaguesCubit(this.leaguesRepo) : super(LeaguesInitial());

  //* Fetching leagues by country ID
  Future<void> fetchLeaguesByCountry(int countryId) async {
    emit(LeaguesLoading());

    try {
      final LeagueResponseModel? response = await leaguesRepo
          .getLeaguesByCountry(countryId);
      if (response != null) {
        emit(LeaguesLoaded(response));
      } else {
        emit(LeaguesError("No leagues found for country ID $countryId"));
      }
    } catch (e) {
      emit(LeaguesError("Failed to fetch leagues: $e"));
    }
  }
}
