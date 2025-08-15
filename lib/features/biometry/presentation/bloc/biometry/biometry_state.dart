import 'package:equatable/equatable.dart';
import 'package:flutter_test_tdd/features/biometry/domain/entity/biometry_status.dart';

abstract class BiometryState extends Equatable {
  const BiometryState();

  @override
  List<Object?> get props => [];
}

class BiometryInitial extends BiometryState {
  const BiometryInitial();
}

class BiometryLoading extends BiometryState {
  const BiometryLoading();
}

class BiometryStatusLoaded extends BiometryState {
  final BiometryStatus status;

  const BiometryStatusLoaded(this.status);

  @override
  List<Object?> get props => [status];
}

class BiometryAuthenticated extends BiometryState {
  final bool success;

  const BiometryAuthenticated(this.success);

  @override
  List<Object?> get props => [success];
}

class BiometryEnabled extends BiometryState {
  final bool success;

  const BiometryEnabled(this.success);

  @override
  List<Object?> get props => [success];
}

class BiometryDisabled extends BiometryState {
  final bool success;

  const BiometryDisabled(this.success);

  @override
  List<Object?> get props => [success];
}

class BiometryError extends BiometryState {
  final String message;

  const BiometryError(this.message);

  @override
  List<Object?> get props => [message];
}
