class TopScorersResponseModel {
  final int success;
  final List<TopScorerModel> result;

  TopScorersResponseModel({
    required this.success,
    required this.result,
  });

  factory TopScorersResponseModel.fromJson(Map<String, dynamic> json) {
    return TopScorersResponseModel(
      success: json['success'],
      result: (json['result'] as List)
          .map((item) => TopScorerModel.fromJson(item))
          .toList(),
    );
  }
}

class TopScorerModel {
  final int? playerPlace;
  final String? playerName;
  final int? playerKey;
  final String? teamName;
  final int? teamKey;
  final int? goals;
  final int? assists;
  final int? penaltyGoals;

  TopScorerModel({
    this.playerPlace,
    this.playerName,
    this.playerKey,
    this.teamName,
    this.teamKey,
    this.goals,
    this.assists,
    this.penaltyGoals,
  });

  factory TopScorerModel.fromJson(Map<String, dynamic> json) {
    return TopScorerModel(
      playerPlace: json['player_place'],
      playerName: json['player_name'],
      playerKey: json['player_key'],
      teamName: json['team_name'],
      teamKey: json['team_key'],
      goals: json['goals'],
      assists: json['assists'],
      penaltyGoals: json['penalty_goals'],
    );
  }
}
