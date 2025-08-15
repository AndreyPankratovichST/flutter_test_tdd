enum BiometryType { fingerprint, face, iris, none }

class BiometryStatus {
  final bool isAvailable;
  final BiometryType type;
  final bool isEnabled;
  final String? errorMessage;

  const BiometryStatus({
    required this.isAvailable,
    required this.type,
    required this.isEnabled,
    this.errorMessage,
  });

  BiometryStatus copyWith({
    bool? isAvailable,
    BiometryType? type,
    bool? isEnabled,
    String? errorMessage,
  }) {
    return BiometryStatus(
      isAvailable: isAvailable ?? this.isAvailable,
      type: type ?? this.type,
      isEnabled: isEnabled ?? this.isEnabled,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
