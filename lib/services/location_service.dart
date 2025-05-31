import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

Future<String?> getUserCountry() async {
  //* Check if location services are enabled
  bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) return null;
  //* Check for location permission
  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) return null;
  }
  //* If permission is denied forever, return null
  if (permission == LocationPermission.deniedForever) return null;

  //* Get the current position of the user
  Position position = await Geolocator.getCurrentPosition();
  print('Location: ${position.latitude}, ${position.longitude}');

  //* Return List of placemarks from coordinates using geocoding package
  List<Placemark> placemarks = await placemarkFromCoordinates(
    position.latitude,
    position.longitude,
  );
  //* Return country name
  return placemarks.first.country;
}
