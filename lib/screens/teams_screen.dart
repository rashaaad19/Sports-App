import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sportsapp/cubit/teams_cubit.dart';
import 'package:sportsapp/cubit/teams_state.dart';
import 'package:sportsapp/widgets/main_app_scaffold.dart';

class TeamsScreen extends StatefulWidget {
  final int? leagueKey;
  const TeamsScreen({super.key, required this.leagueKey});

  @override
  State<TeamsScreen> createState() => _TeamsScreenState();
}

class _TeamsScreenState extends State<TeamsScreen> {
  @override
  void initState() {
    super.initState();
    final leagueId = widget.leagueKey;
    context.read<TeamsCubit>().fetchTeamsById(leagueId!);
  }

  @override
  Widget build(BuildContext context) {
    return MainAppScaffold(
      showBackButton: true,
      child: BlocBuilder<TeamsCubit, TeamsState>(
        builder: (context, state) {
          if (state is TeamsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TeamsLoaded) {
            final teams = state.teamResponse.result;

            if (teams.isEmpty) {
              return const Center(child: Text('No teams found.'));
            }

            return ListView.builder(
              itemCount: teams.length,
              itemBuilder: (context, index) {
                final team = teams[index];
                return ListTile(
                  leading: Image.network(
                    team.teamLogo ?? '',
                    width: 40,
                    height: 40,
                    errorBuilder: (_, __, ___) => const Icon(Icons.error),
                  ),
                  title: Text(team.teamName ?? 'Unknown Team'),
                  subtitle: Text('Team ID: ${team.teamKey}'),
                );
              },
            );
          } else if (state is TeamsError) {
            return Center(child: Text(state.message));
          } else {
            return const SizedBox(); // Initial state
          }
        },
      ),
    );
  }
}
