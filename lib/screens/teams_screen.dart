import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sportsapp/cubit/teams_cubit.dart';
import 'package:sportsapp/cubit/teams_state.dart';
import 'package:sportsapp/cubit/topScorers_cubit.dart';
import 'package:sportsapp/cubit/topScorers_state.dart';
import 'package:sportsapp/screens/squad_screen.dart';
import 'package:sportsapp/widgets/main_app_scaffold.dart';

class TeamsScreen extends StatefulWidget {
  final int? leagueKey;
  const TeamsScreen({super.key, required this.leagueKey});

  @override
  State<TeamsScreen> createState() => _TeamsScreenState();
}

class _TeamsScreenState extends State<TeamsScreen> {
  //* Controller to manage the search input
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    final leagueId = widget.leagueKey!;
    context.read<TeamsCubit>().fetchTeamsById(leagueId);
    context.read<TopscorersCubit>().fetchTopScorers(leagueId);

    //* Listen to changes in the search input
    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text.toLowerCase();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: MainAppScaffold(
        title: 'Teams & Top Scorers',
        showBackButton: true,
        child: Column(
          children: [
            SizedBox(height: 8.h),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.grey.shade300, width: 0.5),
                ),
              ),
              child: TabBar(
                dividerColor: Colors.transparent,
                labelColor: Colors.green.shade700,
                unselectedLabelColor: Colors.grey.shade500,
                indicatorSize: TabBarIndicatorSize.label,
                indicator: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: const Color.fromARGB(255, 54, 172, 25),
                      width: 3.w,
                    ),
                  ),
                ),
                labelStyle: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w800,
                ),
                tabs: const [Tab(text: 'Teams'), Tab(text: 'Top Scorers')],
              ),
            ),
            SizedBox(height: 8.h),
            Expanded(
              child: TabBarView(
                children: [
                  //! Teams View
                  BlocBuilder<TeamsCubit, TeamsState>(
                    builder: (context, state) {
                      if (state is TeamsLoading) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: Color.fromARGB(255, 54, 172, 25),
                          ),
                        );
                      } else if (state is TeamsLoaded) {
                        final teams = state.teamResponse.result;

                        // if (teams.isEmpty) {
                        //   return const Center(child: Text('No teams found.'));
                        // }

                        //* Filter teams based on the search query
                        final filteredTeams =
                            teams.where((team) {
                              final name = team.teamName?.toLowerCase() ?? '';
                              return name.contains(_searchQuery);
                            }).toList();

                        return Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 12.w,
                                vertical: 8.h,
                              ),
                              child: SearchBar(
                                controller: _searchController,
                                hintText: 'Search teams...',
                                leading: Icon(
                                  Icons.search,
                                  color: Colors.green.shade500,
                                ),
                                elevation: WidgetStateProperty.all(1),
                                backgroundColor: WidgetStateProperty.all(
                                  Colors.grey.shade100,
                                ),
                                shadowColor: WidgetStateProperty.all(
                                  Colors.transparent,
                                ),
                                shape: WidgetStatePropertyAll(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                hintStyle: WidgetStateProperty.all(
                                  TextStyle(
                                    color: Colors.grey.shade600,
                                    fontSize: 14.sp,
                                  ),
                                ),
                                textStyle: WidgetStateProperty.all(
                                  TextStyle(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black87,
                                  ),
                                ),
                                padding: WidgetStateProperty.all(
                                  EdgeInsets.symmetric(horizontal: 12.w),
                                ),
                              ),
                            ),
                            Expanded(
                              child: ListView.builder(
                                itemCount: filteredTeams.length,
                                itemBuilder: (context, index) {
                                  final team = filteredTeams[index];
                                  return GestureDetector(
                                    onTap:
                                        () => {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder:
                                                  (context) => SquadScreen(
                                                    teamId: team.teamKey!,
                                                  ),
                                            ),
                                          ),
                                        },
                                    child: ListTile(
                                      leading: Image.network(
                                        team.teamLogo ?? '',
                                        width: 40,
                                        height: 40,
                                        errorBuilder:
                                            (_, __, ___) =>
                                                const Icon(Icons.error),
                                      ),
                                      title: Text(
                                        team.teamName ?? 'Unknown Team',
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        );
                      } else if (state is TeamsError) {
                        return Center(child: Text(state.message));
                      } else {
                        return const SizedBox();
                      }
                    },
                  ),

                  //! Top Scorers View
                  BlocBuilder<TopscorersCubit, TopscorersState>(
                    builder: (context, state) {
                      if (state is TopScorersLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is TopScorersLoaded) {
                        final scorers = state.topScorersResponse.result;
                        if (scorers.isEmpty) {
                          return const Center(child: Text('No top scorers.'));
                        }
                        return ListView.builder(
                          itemCount: scorers.length,
                          itemBuilder: (context, index) {
                            final player = scorers[index];
                            return ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Colors.grey[100],
                                child: Icon(
                                  Icons.person,
                                  color: Colors.green[400],
                                ),
                              ),
                              title: Text(
                                player.playerName ?? 'Unknown Player',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                              ),
                              subtitle: Text(
                                player.teamName ?? 'Unknown Team',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Colors.grey[600],
                                ),
                              ),
                              trailing: Text(
                                '${player.goals ?? 0}',
                                style: TextStyle(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green[700],
                                ),
                              ),
                            );
                          },
                        );
                      } else if (state is TopScorersError) {
                        return Center(child: Text(state.message));
                      } else {
                        return const SizedBox();
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
