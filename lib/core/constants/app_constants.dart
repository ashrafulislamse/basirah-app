/// App-wide constants
class AppConstants {
  AppConstants._(); // Private constructor

  // App info
  static const String appName = 'Basirah';
  static const String appVersion = '1.0.0';
  static const String packageName = 'com.zingswift.basirah';

  // Database
  static const String databaseName = 'basirah_db';
  static const int databaseVersion = 1;

  // Shared Preferences keys
  static const String keyThemeMode = 'theme_mode';
  static const String keyLanguage = 'language';
  static const String keyCalculationMethod = 'calculation_method';
  static const String keyNotificationsEnabled = 'notifications_enabled';
  static const String keyLocationPermission = 'location_permission';

  // Default values
  static const String defaultLanguage = 'bn'; // Bangla
  static const int defaultCalculationMethod = 1; // Islamic Foundation Bangladesh

  // API endpoints (if needed)
  // static const String baseUrl = 'https://api.basirah.app';

  // Kaaba coordinates
  static const double kaabaLatitude = 21.4225;
  static const double kaabaLongitude = 39.8262;

  // Dhaka coordinates (default location)
  static const double dhakaLatitude = 23.8103;
  static const double dhakaLongitude = 90.4125;
}
