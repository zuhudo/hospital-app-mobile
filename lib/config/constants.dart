class AppConstants {
  static const String appName = 'MediCare Hospital';
  static const String apiBaseUrl = 'http://localhost:3000/api';
  static const String apiVersion = 'v1';

  // Storage keys
  static const String tokenKey = 'auth_token';
  static const String userKey = 'user_data';
  static const String themeKey = 'theme_mode';

  // Pagination
  static const int defaultPageSize = 20;

  // Date formats
  static const String dateFormat = 'MMM dd, yyyy';
  static const String timeFormat = 'hh:mm a';
  static const String dateTimeFormat = 'MMM dd, yyyy • hh:mm a';
}
