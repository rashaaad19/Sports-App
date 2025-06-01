class TeamResponseModel {
  final int success;
  final List<TeamModel> result;

  TeamResponseModel({
    required this.success,
    required this.result,
  });

  factory TeamResponseModel.fromJson(Map<String, dynamic> json) {
    return TeamResponseModel(
      success: json['success'],
      result: (json['result'] as List)
          .map((item) => TeamModel.fromJson(item))
          .toList(),
    );
  }
}

class TeamModel {
  final int? teamKey;
  final String? teamName;
  final String? teamLogo;

  TeamModel({
    required this.teamKey,
    required this.teamName,
    this.teamLogo,
  });

  factory TeamModel.fromJson(Map<String, dynamic> json) {
    return TeamModel(
      teamKey: json['team_key'],
      teamName: json['team_name'],
      teamLogo: json['team_logo'],
    );
  }
}
