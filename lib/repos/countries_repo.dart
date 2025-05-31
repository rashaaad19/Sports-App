import 'package:dio/dio.dart';
import 'package:sportsapp/data/models/countries_model.dart';

class CountryRepo {
  final Dio dio = Dio();

  Future<CountryResponseModel?> getCountries() async {
    try {
      final response = await dio.get(
        'https://apiv2.allsportsapi.com/football/?met=Countries&APIkey=b7d207bbb75cf6b51de0aebc8ca55c8412b7c5a33c77510be5338170718b911d',
      );
      //* Check for errors
      if (response.statusCode! > 299) {
        return null;
      } else {
        CountryResponseModel countryResponseModel = CountryResponseModel.fromJson(
          response.data,
        );
        return countryResponseModel;
      }
    } catch (e) {
      print('Error fetching countries: $e');
      return null;
    }
  }
}
