import 'package:geolocator/geolocator.dart';

class LocationService {
  // GPS Location
  Future<Position?> getGPSLocation() async {
    try {
      // Define location settings
      final LocationSettings locationSettings = LocationSettings(
        accuracy: LocationAccuracy.high,
      );

      // Request current position with specified settings
      return await Geolocator.getCurrentPosition(
        locationSettings: locationSettings,
      );
    } catch (e) {
      print('Error getting GPS location: $e');
      return null;
    }
  }
}
