import 'package:dio/dio.dart';
import 'package:sportsapp/data/models/topScorers_model.dart';

class TopscorersRepo {
  final Dio dio = Dio();

  Future<TopScorersResponseModel?> getTopScorers(int leagueId) async {
    try {
      final response = await dio.get(
        'https://apiv2.allsportsapi.com/football/',
        queryParameters: {
          'met': 'Topscorers',
          'leagueId': leagueId,
          'APIkey': 'b7d207bbb75cf6b51de0aebc8ca55c8412b7c5a33c77510be5338170718b911d',
        },
      );

      //* Check for errors
      if (response.statusCode! > 299) {
        return null;
      } else {
        TopScorersResponseModel topScorersResponseModel = TopScorersResponseModel.fromJson(
          response.data,
        );
        return topScorersResponseModel;
      }
    } catch (e) {
      print('Error fetching teams: $e');
      return null;
    }
  }
}
