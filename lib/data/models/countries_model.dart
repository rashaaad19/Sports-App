class CountryResponseModel {
  final int success;
  final List<CountryModel> result;

  CountryResponseModel({
    required this.success,
    required this.result,
  });

  factory CountryResponseModel.fromJson(Map<String, dynamic> json) {
    return CountryResponseModel(
      success: json['success'],
      result: (json['result'] as List)
          .map((item) => CountryModel.fromJson(item))
          .toList(),
    );
  }
}

class CountryModel {
  final int? countryKey;
  final String? countryName;
  final String? countryIso2;
  final String? countryLogo;

  CountryModel({
    required this.countryKey,
    required this.countryName,
    required this.countryIso2,
    this.countryLogo,
  });

  factory CountryModel.fromJson(Map<String, dynamic> json) {
    return CountryModel(
      countryKey: json['country_key'],
      countryName: json['country_name'],
      countryIso2: json['country_iso2'],
      countryLogo: json['country_logo'],
    );
  }
}
