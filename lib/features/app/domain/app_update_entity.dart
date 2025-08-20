class AppUpdateEntity {
  final String version;
  final String build;
  final bool isRequired;
  final bool isNewAvailable;

  AppUpdateEntity({
    required this.version,
    required this.build,
    required this.isRequired,
    required this.isNewAvailable,
  });
}
