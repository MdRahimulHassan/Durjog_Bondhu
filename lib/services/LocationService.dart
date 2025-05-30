import 'package:geolocator/geolocator.dart';

class LocationService {
  Future<Position> getCurrentLocation() async {
    if (!await Geolocator.isLocationServiceEnabled()) {
      throw 'Location services disabled';
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw 'Permission denied';
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw 'Permanent permission denial';
    }

    return await Geolocator.getCurrentPosition();
  }
}