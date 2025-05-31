import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sportsapp/cubit/countries_state.dart';
import 'package:sportsapp/data/models/countries_model.dart';
import 'package:sportsapp/repos/countries_repo.dart';
import 'package:sportsapp/services/location_service.dart';

class CountriesCubit extends Cubit<CountriesState> {
  final CountryRepo countryRepo;

  CountriesCubit(this.countryRepo) : super(CountriesInitial());

//* Fetching countries from the repo 
Future<void> fetchCountries() async {
  emit(CountriesLoading());

  try {
    final CountryResponseModel? response = await countryRepo.getCountries();
    String? userCountry;
    //* Check if user granted location access
      userCountry = await getUserCountry();
    //* Update the state with the returned countries aand user country if provided
    if (response != null) {
      emit(CountriesLoaded(response, userCountry: userCountry));
    } else {
      emit(CountriesError("No data received."));
    }
  } catch (e) {
    emit(CountriesError("Failed to fetch countries: $e"));
  }
}

}





