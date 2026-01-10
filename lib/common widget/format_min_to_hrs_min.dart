String? toSafeTime(dynamic value) {
  if (value == null) return null;

  final v = value.toString().trim();

  // already HH:mm → return as is
  if (RegExp(r'^\d{2}:\d{2}$').hasMatch(v)) {
    return v;
  }

  // minute string → convert
  final minutes = int.tryParse(v);
  if (minutes == null) return null;

  final h = (minutes ~/ 60).toString().padLeft(2, '0');
  final m = (minutes % 60).toString().padLeft(2, '0');
  return '$h:$m';
}
