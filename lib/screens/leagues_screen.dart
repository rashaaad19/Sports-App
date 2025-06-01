import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sportsapp/cubit/leagues_cubit.dart';
import 'package:sportsapp/cubit/leagues_state.dart';
import 'package:sportsapp/data/models/countries_model.dart';
import 'package:sportsapp/screens/teams_screen.dart';
import 'package:sportsapp/widgets/main_app_scaffold.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LeaguesScreen extends StatefulWidget {
  final CountryModel country;
  const LeaguesScreen({super.key, required this.country});

  @override
  State<LeaguesScreen> createState() => _LeaguesScreenState();
}

class _LeaguesScreenState extends State<LeaguesScreen> {
  //* Fetch countries when the screen is initialized
  @override
  void initState() {
    super.initState();
    final countryId = widget.country.countryKey;
    context.read<LeaguesCubit>().fetchLeaguesByCountry(countryId!);
  }

  @override
  Widget build(BuildContext context) {
    return MainAppScaffold(
      showBackButton: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              'Top Leagues in ${widget.country.countryName}',
              style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: BlocBuilder<LeaguesCubit, LeaguesState>(
              builder: (context, state) {
                if (state is LeaguesLoading) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Color.fromARGB(255, 54, 172, 25),
                    ),
                  );
                } else if (state is LeaguesLoaded) {
                  final leagues = state.leagueResponse.result;

                  if (leagues.isEmpty) {
                    return const Center(child: Text('No leagues found.'));
                  }

                  return ListView.builder(
                    itemCount: leagues.length,
                    itemBuilder: (context, index) {
                      final league = leagues[index];
                      return GestureDetector(
                        child: ListTile(
                          leading: Image.network(
                            league.leagueLogo ??
                                widget.country.countryLogo ??
                                '',
                            width: 40.w,
                            height: 40.h,
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(Icons.sports_soccer);
                            },
                          ),
                          title: Text(
                            league.leagueName ?? 'Unknown League',
                            style: TextStyle(fontSize: 17.sp),
                          ),
                          subtitle: Text(
                            league.countryName ??
                                widget.country.countryName ??
                                'Unknown Country',
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        onTap:
                            () => {
                              //* Navigate to LeaguesScreen and pass the selected country
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) => TeamsScreen(
                                        leagueKey: league.leagueKey,
                                      ),
                                ),
                              ),
                            },
                      );
                    },
                  );
                } else if (state is LeaguesError) {
                  return Center(child: Text(state.message));
                } else {
                  return const SizedBox(); // Empty widget for initial state
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
