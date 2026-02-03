String toSafeTime(dynamic time) {
  if (time == null) return '';

  int totalMinutes;

  if (time is int) {
    totalMinutes = time; // if API already gives minutes
  } else if (time is String) {
    // if API gives "13:30"
    final parts = time.split(':');
    if (parts.length != 2) return '';
    final hour = int.tryParse(parts[0]) ?? 0;
    final minute = int.tryParse(parts[1]) ?? 0;
    totalMinutes = hour * 60 + minute;
  } else {
    return '';
  }

  int hour = totalMinutes ~/ 60;
  int minute = totalMinutes % 60;
  final period = hour >= 12 ? 'PM' : 'AM';
  hour = hour % 12;
  if (hour == 0) hour = 12;

  return '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')} $period';
}
