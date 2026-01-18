import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'location_service.g.dart';

/// Location coordinates
class Coordinates {
  final double latitude;
  final double longitude;

  const Coordinates({
    required this.latitude,
    required this.longitude,
  });

  @override
  String toString() => 'Coordinates($latitude, $longitude)';
}

/// Location service for getting user's current location
class LocationService {
  /// Get current location
  /// TODO: Implement using geolocator package
  Future<Coordinates> getCurrentLocation() async {
    // TODO: Request location permission
    // TODO: Get current position
    // TODO: Handle errors (permission denied, location disabled, etc.)
    
    // Placeholder - return Dhaka coordinates
    return const Coordinates(
      latitude: 23.8103,
      longitude: 90.4125,
    );
  }

  /// Check if location permission is granted
  /// TODO: Implement using permission_handler package
  Future<bool> hasLocationPermission() async {
    // TODO: Check permission status
    return false;
  }

  /// Request location permission
  /// TODO: Implement using permission_handler package
  Future<bool> requestLocationPermission() async {
    // TODO: Request permission
    // TODO: Handle different permission states
    return false;
  }

  /// Check if location services are enabled
  Future<bool> isLocationServiceEnabled() async {
    // TODO: Check if GPS is enabled
    return false;
  }
}

/// Location service provider
@riverpod
LocationService locationService(LocationServiceRef ref) {
  return LocationService();
}

/// Current location provider
@riverpod
Future<Coordinates> currentLocation(CurrentLocationRef ref) async {
  final locationService = ref.watch(locationServiceProvider);
  return locationService.getCurrentLocation();
}
