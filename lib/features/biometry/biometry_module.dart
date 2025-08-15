import 'package:cherrypick/cherrypick.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_test_tdd/features/biometry/data/repository/biometry_repository_impl.dart';
import 'package:flutter_test_tdd/features/biometry/data/source/biometry_platform_source.dart';
import 'package:flutter_test_tdd/features/biometry/data/source/biometry_platform_source_impl.dart';
import 'package:flutter_test_tdd/features/biometry/data/source/biometry_local_data_source.dart';
import 'package:flutter_test_tdd/features/biometry/data/source/biometry_local_data_source_impl.dart';
import 'package:flutter_test_tdd/features/biometry/domain/repository/biometry_repository.dart';
import 'package:flutter_test_tdd/features/biometry/domain/usecase/authenticate_user.dart';
import 'package:flutter_test_tdd/features/biometry/domain/usecase/check_biometry_availability.dart';
import 'package:flutter_test_tdd/features/biometry/domain/usecase/enable_biometry.dart';
import 'package:flutter_test_tdd/features/biometry/domain/usecase/disable_biometry.dart';
import 'package:flutter_test_tdd/features/biometry/presentation/bloc/biometry/biometry_bloc.dart';

final class BiometryModule extends Module {
  @override
  void builder(Scope currentScope) {
    bind<BiometryPlatformSource>().toProvide(
      () => BiometryPlatformSourceImpl(),
    );
    bind<BiometryLocalDataSource>().toProvide(
      () => BiometryLocalDataSourceImpl(
        currentScope.resolve<SharedPreferences>(),
      ),
    );
    bind<BiometryRepository>().toProvide(
      () => BiometryRepositoryImpl(
        platformSource: currentScope.resolve<BiometryPlatformSource>(),
        localDataSource: currentScope.resolve<BiometryLocalDataSource>(),
      ),
    );
    bind<CheckBiometryAvailabilityUseCase>().toProvide(
      () => CheckBiometryAvailabilityUseCase(
        currentScope.resolve<BiometryRepository>(),
      ),
    );
    bind<AuthenticateUserUseCase>().toProvide(
      () => AuthenticateUserUseCase(currentScope.resolve<BiometryRepository>()),
    );
    bind<EnableBiometryUseCase>().toProvide(
      () => EnableBiometryUseCase(currentScope.resolve<BiometryRepository>()),
    );
    bind<DisableBiometryUseCase>().toProvide(
      () => DisableBiometryUseCase(currentScope.resolve<BiometryRepository>()),
    );
    bind<BiometryBloc>().toProvide(
      () => BiometryBloc(
        checkAvailabilityUseCase: currentScope
            .resolve<CheckBiometryAvailabilityUseCase>(),
        authenticateUseCase: currentScope.resolve<AuthenticateUserUseCase>(),
        enableUseCase: currentScope.resolve<EnableBiometryUseCase>(),
        disableUseCase: currentScope.resolve<DisableBiometryUseCase>(),
      ),
    );
  }
}
