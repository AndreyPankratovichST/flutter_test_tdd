extension StringExt on String? {
  bool get isNullOrEmpty => this == null || this!.isEmpty;

  int? get toInt => int.tryParse(this ?? '');
}