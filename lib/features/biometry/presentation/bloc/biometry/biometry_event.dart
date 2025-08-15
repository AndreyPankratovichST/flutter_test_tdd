import 'package:equatable/equatable.dart';

abstract class BiometryEvent extends Equatable {
  const BiometryEvent();

  @override
  List<Object?> get props => [];
}

class CheckBiometryAvailability extends BiometryEvent {
  const CheckBiometryAvailability();
}

class AuthenticateUser extends BiometryEvent {
  final String reason;

  const AuthenticateUser({required this.reason});

  @override
  List<Object?> get props => [reason];
}

class EnableBiometry extends BiometryEvent {
  const EnableBiometry();
}

class DisableBiometry extends BiometryEvent {
  const DisableBiometry();
}
