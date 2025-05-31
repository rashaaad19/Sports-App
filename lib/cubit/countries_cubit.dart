import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sportsapp/cubit/countries_state.dart';
import 'package:sportsapp/data/models/countries_model.dart';
import 'package:sportsapp/repos/countries_repo.dart';

class CountriesCubit extends Cubit<CountriesState> {
  final CountryRepo countryRepo;

  CountriesCubit(this.countryRepo) : super(CountriesInitial());

//* Fetch countries from the repository and emit states accordingly
  Future<void> fetchCountries() async {
    emit(CountriesLoading());
    try {
      final CountryResponseModel? response = await countryRepo.getCountries();
      if (response != null) {
        emit(CountriesLoaded(response));
      } else {
        emit(CountriesError("No data received."));
      }
    } catch (e) {
      emit(CountriesError("Failed to fetch countries: $e"));
    }
  }
}
