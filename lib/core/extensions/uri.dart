extension UriExt on Uri {
  String get fullPath => path + (hasQuery ? '?$query' : '');
}