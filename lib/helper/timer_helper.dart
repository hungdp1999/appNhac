
class TimerHelper {
  static String formatDuration(Duration duration) {
    if (duration == null) {
      return '00:00:00';
    }

    String twoDigits(int n) {
      if (n >= 10) {
        return '$n';
      }
      return '0$n';
    }

    final twoDigitHours = twoDigits(duration.inHours);
    final twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60).toInt());
    final twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60).toInt());

    if (duration.inHours <= 0) {
      return '$twoDigitMinutes:$twoDigitSeconds';
    }

    return '$twoDigitHours:$twoDigitMinutes:$twoDigitSeconds';
  }
}
