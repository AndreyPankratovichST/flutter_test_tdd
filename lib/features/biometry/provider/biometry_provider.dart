import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_tdd/features/biometry/data/repository/biometry_repository_impl.dart';
import 'package:flutter_test_tdd/features/biometry/data/source/biometry_local_data_source.dart';
import 'package:flutter_test_tdd/features/biometry/data/source/biometry_local_data_source_impl.dart';
import 'package:flutter_test_tdd/features/biometry/data/source/biometry_platform_source.dart';
import 'package:flutter_test_tdd/features/biometry/data/source/biometry_platform_source_impl.dart';
import 'package:flutter_test_tdd/features/biometry/domain/repository/biometry_repository.dart';
import 'package:flutter_test_tdd/features/biometry/domain/usecase/authenticate_user.dart';
import 'package:flutter_test_tdd/features/biometry/domain/usecase/check_biometry_availability.dart';
import 'package:flutter_test_tdd/features/biometry/domain/usecase/disable_biometry.dart';
import 'package:flutter_test_tdd/features/biometry/domain/usecase/enable_biometry.dart';
import 'package:flutter_test_tdd/features/biometry/presentation/bloc/biometry/biometry_bloc.dart';
import 'package:provider/provider.dart';

MultiProvider biometryProvider = MultiProvider(
  providers: [
    Provider<BiometryPlatformSource>(
      create: (_) => BiometryPlatformSourceImpl(),
    ),
    Provider<BiometryLocalDataSource>(
      create: (context) => BiometryLocalDataSourceImpl(context.read()),
    ),
    Provider<BiometryRepository>(
      create: (context) => BiometryRepositoryImpl(
        platformSource: context.read(),
        localDataSource: context.read(),
      ),
    ),

    Provider<CheckBiometryAvailabilityUseCase>(
      create: (context) => CheckBiometryAvailabilityUseCase(context.read()),
    ),
    Provider<AuthenticateUserUseCase>(
      create: (context) => AuthenticateUserUseCase(context.read()),
    ),
    Provider<EnableBiometryUseCase>(
      create: (context) => EnableBiometryUseCase(context.read()),
    ),
    Provider<DisableBiometryUseCase>(
      create: (context) => DisableBiometryUseCase(context.read()),
    ),
    BlocProvider<BiometryBloc>(
      create: (context) => BiometryBloc(
        checkAvailabilityUseCase: context.read(),
        authenticateUseCase: context.read(),
        enableUseCase: context.read(),
        disableUseCase: context.read(),
      ),
    ),
  ],
);
