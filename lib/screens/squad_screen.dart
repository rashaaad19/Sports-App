import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sportsapp/cubit/squad_cubit.dart';
import 'package:sportsapp/cubit/squad_state.dart';
import 'package:sportsapp/widgets/dialog_helpers.dart';
import 'package:sportsapp/widgets/main_app_scaffold.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SquadScreen extends StatefulWidget {
  final int teamId;
  const SquadScreen({super.key, required this.teamId});

  @override
  State<SquadScreen> createState() => _SquadScreenState();
}

class _SquadScreenState extends State<SquadScreen> {
  //* Controller to manage the search input
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    context.read<SquadCubit>().fetchPlayersByTeam(widget.teamId);

    //* Listen to changes in the search input
    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text.toLowerCase();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MainAppScaffold(
      title: 'Squad',
      showDrawer: true,
      showBackButton: true,
      child: BlocBuilder<SquadCubit, SquadState>(
        builder: (context, state) {
          //* Handle Loading State
          if (state is SquadLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: Color.fromARGB(255, 54, 172, 25),
              ),
            );

            //* Handle Loaded State
          } else if (state is SquadLoaded) {
            final players = state.playersResponse.result;
            //* Filter teams based on the search query
            final filteredPlayers =
                players.where((player) {
                  final name = player.playerName.toLowerCase();
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
                    hintText: 'Search Players...',
                    leading: Icon(Icons.search, color: Colors.green.shade500),
                    elevation: WidgetStateProperty.all(1),
                    backgroundColor: WidgetStateProperty.all(
                      Colors.grey.shade100,
                    ),
                    shadowColor: WidgetStateProperty.all(Colors.transparent),
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    hintStyle: WidgetStateProperty.all(
                      TextStyle(color: Colors.grey.shade600, fontSize: 14.sp),
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
                    padding: const EdgeInsets.all(16),
                    itemCount: filteredPlayers.length,
                    itemBuilder: (context, index) {
                      final player = filteredPlayers[index];

                      return GestureDetector(
                        onTap:
                            () => {
                              //* Restrict the stats dialog for players only
                              player.playerType == 'Coach'
                                  ? null
                                  : showDialog(
                                    context: context,
                                    builder:
                                        (context) =>
                                            PlayerStatsDialog(player: player),
                                  ),
                            },
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.white,
                            child: ClipOval(
                              child:
                                  player.playerType == 'Coach'
                                      ? SvgPicture.asset(
                                        'assets/images/manager-icon.svg',
                                        height: 34,
                                        width: 34,
                                      )
                                      : Image.network(
                                        player.playerImage ??
                                            '', 
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                        height: double.infinity,
                                        errorBuilder: (
                                          context,
                                          error,
                                          stackTrace,
                                        ) {
                                          return const Icon(
                                            Icons.person,
                                            color: Colors.grey,
                                          );
                                        },
                                      ),
                            ),
                          ),

                          title: Text(
                            player.playerName,
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.black87,
                            ),
                          ),
                          subtitle: Text(
                            player.playerType,
                            style: TextStyle(
                              fontSize: 13.sp,
                              color: Colors.grey[600],
                            ),
                          ),
                          trailing: Text(
                            player.playerNumber ?? '',
                            style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.green[700],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }
          //* Handle Error State
          else if (state is SquadError) {
            return Center(child: Text(state.message));
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
