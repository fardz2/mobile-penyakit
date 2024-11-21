import 'package:timeago/timeago.dart' as timeago;

class TimeHelper {
  static String formatTime(String dateTime) {
    // Parse the datetime string
    DateTime parsedDate = DateTime.parse(dateTime);

    // Use timeago to display the time in a human-readable format
    return timeago.format(parsedDate);
  }
}
