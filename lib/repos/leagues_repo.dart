import 'package:dio/dio.dart';
import 'package:sportsapp/data/models/leages_model.dart';

class LeaguesRepo {
  final Dio dio = Dio();

  Future<LeagueResponseModel?> getLeaguesByCountry(int countryId) async {
    try {
      final response = await dio.get(
        'https://apiv2.allsportsapi.com/football/',
        queryParameters: {
          'met': 'Leagues',
          'countryId': countryId,
          'APIkey': 'b7d207bbb75cf6b51de0aebc8ca55c8412b7c5a33c77510be5338170718b911d',
        },
      );

      //* Check for errors
      if (response.statusCode! > 299) {
        return null;
      } else {
        LeagueResponseModel leagueResponseModel = LeagueResponseModel.fromJson(
          response.data,
        );
        return leagueResponseModel;
      }
    } catch (e) {
      print('Error fetching leagues: $e');
      return null;
    }
  }
}
