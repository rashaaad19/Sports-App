import 'package:flutter/material.dart';
import 'package:sportsapp/data/models/countries_model.dart';
import 'package:sportsapp/widgets/main_app_scaffold.dart';

class LeaguesScreen extends StatefulWidget {
  final CountryModel country;
  const LeaguesScreen({super.key, required this.country});

  @override
  State<LeaguesScreen> createState() => _LeaguesScreenState();
}

class _LeaguesScreenState extends State<LeaguesScreen> {
  @override
  Widget build(BuildContext context) {
    print(widget.country);
    return MainAppScaffold(
      showBackButton: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.country.countryName ?? 'Unknown Country',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
