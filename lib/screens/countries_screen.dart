import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sportsapp/cubit/countries_cubit.dart';
import 'package:sportsapp/cubit/countries_state.dart';
import 'package:sportsapp/data/models/countries_model.dart';
import 'package:sportsapp/widgets/main_app_scaffold.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CountriesScreen extends StatefulWidget {
  const CountriesScreen({super.key});

  @override
  State<CountriesScreen> createState() => _CountriesScreenState();
}

class _CountriesScreenState extends State<CountriesScreen> {
  @override
  //* Automatically fetch countries when screen opens
  void initState() {
    super.initState();
    context.read<CountriesCubit>().fetchCountries();
  }

  Widget _buildUI(CountryResponseModel countryResponse) {
    final countries = countryResponse.result;

    return MainAppScaffold(
      showDrawer: true,
      child: ListView.builder(
        itemCount: countries.length,
        itemBuilder: (context, index) {
          final country = countries[index];

          return ListTile(
            leading:
                country.countryLogo != null
                    ? Image.network(country.countryLogo!, width: 30, height: 30)
                    : const Icon(Icons.flag),
            title:
                country.countryName != null
                    ? Text(country.countryName!)
                    : const Text('Unknown Country'),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CountriesCubit, CountriesState>(
        builder: (context, state) {
          if (state is CountriesLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: Color.fromARGB(255, 54, 172, 25),
              ),
            );
          } else if (state is CountriesLoaded) {
            return _buildUI(state.countryResponse);
          } else if (state is CountriesError) {
            return Center(child: Text(state.message));
          }

          // While waiting for initial fetch or unexpected state
          return const SizedBox();
        },
      ),
    );
  }
}
