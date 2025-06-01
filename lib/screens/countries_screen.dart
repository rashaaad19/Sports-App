import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sportsapp/cubit/countries_cubit.dart';
import 'package:sportsapp/cubit/countries_state.dart';
import 'package:sportsapp/data/models/countries_model.dart';
import 'package:sportsapp/screens/leagues_screen.dart';
import 'package:sportsapp/util/scroll_utils.dart';
import 'package:sportsapp/widgets/main_app_scaffold.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CountriesScreen extends StatefulWidget {
  const CountriesScreen({super.key});

  @override
  State<CountriesScreen> createState() => _CountriesScreenState();
}

class _CountriesScreenState extends State<CountriesScreen> {
  //* Controller to manage the scroll position of the ListView
  final ScrollController _scrollController = ScrollController();

  //* Fetch countries when the screen is initialized
  @override
  void initState() {
    super.initState();
    context.read<CountriesCubit>().fetchCountries();
  }

  //* UI builder method to display the list of countries
  Widget _buildUI(CountryResponseModel countryResponse, String? userCountry) {
    final countries = countryResponse.result;

    //* Scroll to the user's country if it exists
    scrollToUserCountry(userCountry, countries, _scrollController);
    return MainAppScaffold(
      showDrawer: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const Icon(Icons.location_on, color: Colors.red),
                const SizedBox(width: 8),
                Text(
                  userCountry ?? "Location not detected",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: countries.length,
              itemExtent: 80.0,
              itemBuilder: (context, index) {
                final country = countries[index];
                final countryName = country.countryName;
                final countryImg = country.countryLogo;
                final isUserCountry =
                    userCountry != null && countryName == userCountry;

                return Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: GestureDetector(
                    onTap: () {
                      //* Navigate to LeaguesScreen and pass the selected country
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LeaguesScreen(country: country),
                        ),
                      );
                    },
                    child: Container(
                      decoration:
                          isUserCountry
                              ? BoxDecoration(
                                color: Colors.green.withOpacity(0.2),
                                border: Border.all(
                                  color: Colors.green,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              )
                              : null,
                      child: ListTile(
                        leading:
                            countryImg != null
                                ? Image.network(
                                  country.countryLogo!,
                                  width: 30.w,
                                  height: 30.h,
                                )
                                : const Icon(Icons.flag),
                        title: Text(
                          countryName ?? 'Unknown Country',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
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
            return _buildUI(state.countryResponse, state.userCountry);
          } else if (state is CountriesError) {
            return Center(child: Text(state.message));
          }

          //* While waiting for initial fetch or unexpected state
          return const SizedBox();
        },
      ),
    );
  }
}
