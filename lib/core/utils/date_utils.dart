import 'package:intl/intl.dart';

/// Date utility functions
class AppDateUtils {
  AppDateUtils._(); // Private constructor

  /// Format date as "dd MMM yyyy" (e.g., "17 Jan 2026")
  static String formatDate(DateTime date) {
    return DateFormat('dd MMM yyyy').format(date);
  }

  /// Format time as "hh:mm a" (e.g., "5:30 AM")
  static String formatTime(DateTime time) {
    return DateFormat('hh:mm a').format(time);
  }

  /// Format time in 24-hour format (e.g., "17:30")
  static String formatTime24(DateTime time) {
    return DateFormat('HH:mm').format(time);
  }

  /// Get Islamic date (requires islamic_calendar package)
  /// TODO: Implement Islamic calendar conversion
  static String getIslamicDate(DateTime date) {
    // Placeholder - implement with islamic_calendar package
    return 'Rajab 15, 1447';
  }

  /// Check if date is today
  static bool isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  /// Check if date is tomorrow
  static bool isTomorrow(DateTime date) {
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    return date.year == tomorrow.year &&
        date.month == tomorrow.month &&
        date.day == tomorrow.day;
  }

  /// Get start of day
  static DateTime startOfDay(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  /// Get end of day
  static DateTime endOfDay(DateTime date) {
    return DateTime(date.year, date.month, date.day, 23, 59, 59);
  }

  /// Get time remaining until a specific time
  static Duration timeRemaining(DateTime targetTime) {
    return targetTime.difference(DateTime.now());
  }

  /// Format duration as "Xh Ym" (e.g., "2h 30m")
  static String formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    
    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }

  /// Format duration as countdown (e.g., "02:30:45")
  static String formatCountdown(Duration duration) {
    final hours = duration.inHours.toString().padLeft(2, '0');
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    
    return '$hours:$minutes:$seconds';
  }
}
