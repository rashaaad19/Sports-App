import 'package:sportsapp/data/models/countries_model.dart';

abstract class CountriesState {}

class CountriesInitial extends CountriesState {}

class CountriesLoading extends CountriesState {}

class CountriesLoaded extends CountriesState {
  final CountryResponseModel countryResponse;
  final String? userCountry;
  //* userCountry is optional named parameter
  CountriesLoaded(this.countryResponse, {this.userCountry});
}

class CountriesError extends CountriesState {
  final String message;
  CountriesError(this.message);
}
