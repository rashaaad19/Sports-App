import 'package:dio/dio.dart';
import 'package:sportsapp/data/models/squad_model.dart';

class PlayersRepo {
  final Dio dio = Dio();

  Future<PlayersResponse?> getSquadByTeamId(int teamId) async {
    try {
      final response = await dio.get(
        'https://apiv2.allsportsapi.com/football/',
        queryParameters: {
          'met': 'Players',
          'teamId': teamId,
          'APIkey':
              'b7d207bbb75cf6b51de0aebc8ca55c8412b7c5a33c77510be5338170718b911d',
        },
      );

      if (response.statusCode! > 299) {
        return null;
      } else {
        PlayersResponse playersResponse = PlayersResponse.fromJson(
          response.data,
        );
        return playersResponse;
      }
    } catch (e) {
      print('Error fetching squad: $e');
      return null;
    }
  }
}
