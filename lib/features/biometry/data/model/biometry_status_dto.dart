enum BiometryTypeDto { fingerprint, face, iris, none }

class BiometryStatusDto {
  final bool isAvailable;
  final BiometryTypeDto type;
  final bool isEnabled;
  final String? errorMessage;

  const BiometryStatusDto({
    required this.isAvailable,
    required this.type,
    required this.isEnabled,
    this.errorMessage,
  });

  BiometryStatusDto copyWith({
    bool? isAvailable,
    BiometryTypeDto? type,
    bool? isEnabled,
    String? errorMessage,
  }) {
    return BiometryStatusDto(
      isAvailable: isAvailable ?? this.isAvailable,
      type: type ?? this.type,
      isEnabled: isEnabled ?? this.isEnabled,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is BiometryStatusDto &&
        other.isAvailable == isAvailable &&
        other.type == type &&
        other.isEnabled == isEnabled &&
        other.errorMessage == errorMessage;
  }

  @override
  int get hashCode {
    return isAvailable.hashCode ^
        type.hashCode ^
        isEnabled.hashCode ^
        errorMessage.hashCode;
  }
}
