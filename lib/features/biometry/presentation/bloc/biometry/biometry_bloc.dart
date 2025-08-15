import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_tdd/features/biometry/domain/usecase/authenticate_user.dart';
import 'package:flutter_test_tdd/features/biometry/domain/usecase/check_biometry_availability.dart';
import 'package:flutter_test_tdd/features/biometry/domain/usecase/enable_biometry.dart';
import 'package:flutter_test_tdd/features/biometry/domain/usecase/disable_biometry.dart';
import 'package:flutter_test_tdd/features/biometry/presentation/bloc/biometry/biometry_event.dart';
import 'package:flutter_test_tdd/features/biometry/presentation/bloc/biometry/biometry_state.dart';

class BiometryBloc extends Bloc<BiometryEvent, BiometryState> {
  final CheckBiometryAvailabilityUseCase _checkAvailabilityUseCase;
  final AuthenticateUserUseCase _authenticateUseCase;
  final EnableBiometryUseCase _enableUseCase;
  final DisableBiometryUseCase _disableUseCase;

  BiometryBloc({
    required CheckBiometryAvailabilityUseCase checkAvailabilityUseCase,
    required AuthenticateUserUseCase authenticateUseCase,
    required EnableBiometryUseCase enableUseCase,
    required DisableBiometryUseCase disableUseCase,
  }) : _checkAvailabilityUseCase = checkAvailabilityUseCase,
       _authenticateUseCase = authenticateUseCase,
       _enableUseCase = enableUseCase,
       _disableUseCase = disableUseCase,
       super(const BiometryInitial()) {
    on<CheckBiometryAvailability>(_onCheckAvailability);
    on<AuthenticateUser>(_onAuthenticateUser);
    on<EnableBiometry>(_onEnableBiometry);
    on<DisableBiometry>(_onDisableBiometry);
  }

  Future<void> _onCheckAvailability(
    CheckBiometryAvailability event,
    Emitter<BiometryState> emit,
  ) async {
    emit(const BiometryLoading());

    final result = await _checkAvailabilityUseCase();

    result.fold(
      onSuccess: (status) => emit(BiometryStatusLoaded(status)),
      onFailure: (failure) => emit(BiometryError(failure.toString())),
    );
  }

  Future<void> _onAuthenticateUser(
    AuthenticateUser event,
    Emitter<BiometryState> emit,
  ) async {
    emit(const BiometryLoading());

    final result = await _authenticateUseCase(event.reason);

    result.fold(
      onSuccess: (success) => emit(BiometryAuthenticated(success)),
      onFailure: (failure) => emit(BiometryError(failure.toString())),
    );
  }

  Future<void> _onEnableBiometry(
    EnableBiometry event,
    Emitter<BiometryState> emit,
  ) async {
    emit(const BiometryLoading());

    final result = await _enableUseCase();

    result.fold(
      onSuccess: (success) => emit(BiometryEnabled(success)),
      onFailure: (failure) => emit(BiometryError(failure.toString())),
    );
  }

  Future<void> _onDisableBiometry(
    DisableBiometry event,
    Emitter<BiometryState> emit,
  ) async {
    emit(const BiometryLoading());

    final result = await _disableUseCase();

    result.fold(
      onSuccess: (success) => emit(BiometryDisabled(success)),
      onFailure: (failure) => emit(BiometryError(failure.toString())),
    );
  }
}
