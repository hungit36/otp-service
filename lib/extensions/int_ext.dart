extension IntExtensions on int {
  String get formatOTPTime => _formatOTPTime();

  String get formatOTPTimeNotHour => _formatOTPTime(isFull: false);

  String _formatOTPTime({bool isFull = true}) {
    final duration = Duration(seconds: this);
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return [if (isFull) hours, minutes, seconds].join(':');
  }
}
