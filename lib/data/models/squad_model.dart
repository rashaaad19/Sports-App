class PlayersResponse {
  final int success;
  final List<Player> result;

  PlayersResponse({
    required this.success,
    required this.result,
  });

  factory PlayersResponse.fromJson(Map<String, dynamic> json) {
    return PlayersResponse(
      success: json['success'],
      result: List<Player>.from(json['result'].map((x) => Player.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'result': List<dynamic>.from(result.map((x) => x.toJson())),
    };
  }
}

class Player {
  final int playerKey;
  final String playerName;
  final String? playerNumber;
  final String? playerCountry;
  final String playerType;
  final String? playerAge;
  final String? playerMatchPlayed;
  final String? playerGoals;
  final String? playerYellowCards;
  final String? playerRedCards;
  final String? playerMinutes;
  final String playerInjured;
  final String? playerSubstituteOut;
  final String? playerSubstitutesOnBench;
  final String? playerAssists;
  final String? playerIsCaptain;
  final String? playerShotsTotal;
  final String? playerGoalsConceded;
  final String? playerFoulsCommited;
  final String? playerTackles;
  final String? playerBlocks;
  final String? playerCrossesTotal;
  final String? playerInterceptions;
  final String? playerClearances;
  final String? playerDispossesed;
  final String? playerSaves;
  final String? playerInsideBoxSaves;
  final String? playerDuelsTotal;
  final String? playerDuelsWon;
  final String? playerDribbleAttempts;
  final String? playerDribbleSucc;
  final String? playerPenComm;
  final String? playerPenWon;
  final String? playerPenScored;
  final String? playerPenMissed;
  final String? playerPasses;
  final String? playerPassesAccuracy;
  final String? playerKeyPasses;
  final String? playerWoordworks;
  final String? playerRating;
  final String teamName;
  final int teamKey;
  final String? playerImage;

  Player({
    required this.playerKey,
    required this.playerName,
    this.playerNumber,
    this.playerCountry,
    required this.playerType,
    this.playerAge,
    this.playerMatchPlayed,
    this.playerGoals,
    this.playerYellowCards,
    this.playerRedCards,
    this.playerMinutes,
    required this.playerInjured,
    this.playerSubstituteOut,
    this.playerSubstitutesOnBench,
    this.playerAssists,
    this.playerIsCaptain,
    this.playerShotsTotal,
    this.playerGoalsConceded,
    this.playerFoulsCommited,
    this.playerTackles,
    this.playerBlocks,
    this.playerCrossesTotal,
    this.playerInterceptions,
    this.playerClearances,
    this.playerDispossesed,
    this.playerSaves,
    this.playerInsideBoxSaves,
    this.playerDuelsTotal,
    this.playerDuelsWon,
    this.playerDribbleAttempts,
    this.playerDribbleSucc,
    this.playerPenComm,
    this.playerPenWon,
    this.playerPenScored,
    this.playerPenMissed,
    this.playerPasses,
    this.playerPassesAccuracy,
    this.playerKeyPasses,
    this.playerWoordworks,
    this.playerRating,
    required this.teamName,
    required this.teamKey,
    this.playerImage,
  });

  factory Player.fromJson(Map<String, dynamic> json) {
    return Player(
      playerKey: json['player_key'],
      playerName: json['player_name'],
      playerNumber: json['player_number'],
      playerCountry: json['player_country'],
      playerType: json['player_type'],
      playerAge: json['player_age'],
      playerMatchPlayed: json['player_match_played'],
      playerGoals: json['player_goals'],
      playerYellowCards: json['player_yellow_cards'],
      playerRedCards: json['player_red_cards'],
      playerMinutes: json['player_minutes'],
      playerInjured: json['player_injured'],
      playerSubstituteOut: json['player_substitute_out'],
      playerSubstitutesOnBench: json['player_substitutes_on_bench'],
      playerAssists: json['player_assists'],
      playerIsCaptain: json['player_is_captain'],
      playerShotsTotal: json['player_shots_total'],
      playerGoalsConceded: json['player_goals_conceded'],
      playerFoulsCommited: json['player_fouls_commited'],
      playerTackles: json['player_tackles'],
      playerBlocks: json['player_blocks'],
      playerCrossesTotal: json['player_crosses_total'],
      playerInterceptions: json['player_interceptions'],
      playerClearances: json['player_clearances'],
      playerDispossesed: json['player_dispossesed'],
      playerSaves: json['player_saves'],
      playerInsideBoxSaves: json['player_inside_box_saves'],
      playerDuelsTotal: json['player_duels_total'],
      playerDuelsWon: json['player_duels_won'],
      playerDribbleAttempts: json['player_dribble_attempts'],
      playerDribbleSucc: json['player_dribble_succ'],
      playerPenComm: json['player_pen_comm'],
      playerPenWon: json['player_pen_won'],
      playerPenScored: json['player_pen_scored'],
      playerPenMissed: json['player_pen_missed'],
      playerPasses: json['player_passes'],
      playerPassesAccuracy: json['player_passes_accuracy'],
      playerKeyPasses: json['player_key_passes'],
      playerWoordworks: json['player_woordworks'],
      playerRating: json['player_rating'],
      teamName: json['team_name'],
      teamKey: json['team_key'],
      playerImage: json['player_image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'player_key': playerKey,
      'player_name': playerName,
      'player_number': playerNumber,
      'player_country': playerCountry,
      'player_type': playerType,
      'player_age': playerAge,
      'player_match_played': playerMatchPlayed,
      'player_goals': playerGoals,
      'player_yellow_cards': playerYellowCards,
      'player_red_cards': playerRedCards,
      'player_minutes': playerMinutes,
      'player_injured': playerInjured,
      'player_substitute_out': playerSubstituteOut,
      'player_substitutes_on_bench': playerSubstitutesOnBench,
      'player_assists': playerAssists,
      'player_is_captain': playerIsCaptain,
      'player_shots_total': playerShotsTotal,
      'player_goals_conceded': playerGoalsConceded,
      'player_fouls_commited': playerFoulsCommited,
      'player_tackles': playerTackles,
      'player_blocks': playerBlocks,
      'player_crosses_total': playerCrossesTotal,
      'player_interceptions': playerInterceptions,
      'player_clearances': playerClearances,
      'player_dispossesed': playerDispossesed,
      'player_saves': playerSaves,
      'player_inside_box_saves': playerInsideBoxSaves,
      'player_duels_total': playerDuelsTotal,
      'player_duels_won': playerDuelsWon,
      'player_dribble_attempts': playerDribbleAttempts,
      'player_dribble_succ': playerDribbleSucc,
      'player_pen_comm': playerPenComm,
      'player_pen_won': playerPenWon,
      'player_pen_scored': playerPenScored,
      'player_pen_missed': playerPenMissed,
      'player_passes': playerPasses,
      'player_passes_accuracy': playerPassesAccuracy,
      'player_key_passes': playerKeyPasses,
      'player_woordworks': playerWoordworks,
      'player_rating': playerRating,
      'team_name': teamName,
      'team_key': teamKey,
      'player_image': playerImage,
    };
  }
}
