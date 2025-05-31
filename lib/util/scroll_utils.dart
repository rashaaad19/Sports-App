import 'package:flutter/widgets.dart';
import 'package:sportsapp/data/models/countries_model.dart';

void scrollToUserCountry(
  String? userCountry,
  List<CountryModel> countries,
  ScrollController scrollController,
) {
  if (userCountry != null) {
    for (int i = 0; i < countries.length; i++) {
      if (countries[i].countryName == userCountry) {
        //* Ensure the scroll happens after the first frame is rendered
        WidgetsBinding.instance.addPostFrameCallback((_) {
          scrollController.animateTo(
            //* Calculate the position based on the index and item height
            i * 80.0,
            duration: const Duration(seconds: 1),
            curve: Curves.easeInOut,
          );
        });
        break;
      }
    }
  }
}
