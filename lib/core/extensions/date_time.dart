extension DateTimeEx on DateTime {
  String get print {
    final delimiter = '.';
    StringBuffer buffer = StringBuffer();
    buffer.write(day);
    buffer.write(delimiter);
    buffer.write(month);
    buffer.write(delimiter);
    buffer.write(year);
    return buffer.toString();
  }
}
