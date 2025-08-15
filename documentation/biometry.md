# Работа с биометрией

## Обзор

Биометрическая аутентификация позволяет пользователям входить в приложение используя отпечаток пальца, Face ID или радужную оболочку глаза. В приложении используется пакет `local_auth` для работы с биометрией на обеих платформах.

## Архитектура

Модуль биометрии построен по принципам Clean Architecture и включает следующие слои:

### Domain Layer
- **Entity**: `BiometryStatus` - доменная модель статуса биометрии
- **Repository**: `BiometryRepository` - абстракция для работы с биометрией
- **Use Cases**: 
  - `CheckBiometryAvailabilityUseCase` - проверка доступности биометрии
  - `AuthenticateUserUseCase` - аутентификация пользователя
  - `EnableBiometryUseCase` - включение биометрии
  - `DisableBiometryUseCase` - отключение биометрии

### Data Layer
- **DTO**: `BiometryStatusDto` - модель данных для передачи
- **Mapper**: `BiometryMapper` - преобразование между DTO и Entity
- **Sources**:
  - `BiometryPlatformSource` - работа с платформенными API
  - `BiometryLocalDataSource` - локальное хранение настроек

### Presentation Layer
- **BLoC**: `BiometryBloc` - управление состоянием
- **UI**: Диалоговое окно с настройками биометрии

---

## Настройка платформ

### iOS

Добавить в `ios/Runner/Info.plist`:

```xml
<key>NSFaceIDUsageDescription</key>
<string>This app uses Face ID to authenticate users securely and provide quick access to protected features.</string>
```

### Android

Добавить в `android/app/src/main/AndroidManifest.xml`:

```xml
<uses-permission android:name="android.permission.USE_BIOMETRIC" />
<uses-permission android:name="android.permission.USE_FINGERPRINT" />
```

## Обязательно заменить FlutterActivity на FlutterFragmentActivity в MainActivity.kts

---

## Использование

### Проверка доступности биометрии

```dart
class CheckBiometryAvailabilityUseCase extends UseCase<BiometryStatus, void> {
  final BiometryRepository _repository;

  CheckBiometryAvailabilityUseCase(this._repository);

  @override
  Future<BiometryStatus> execute([void params]) => _repository.checkAvailability();
}
```

### Аутентификация пользователя

```dart
class AuthenticateUserUseCase extends UseCase<bool, String> {
  final BiometryRepository _repository;
  
  AuthenticateUserUseCase(this._repository);
  
  @override
  Future<bool> execute([String? params]) {
    assert(
      params != null && params.isNotEmpty,
      'AuthenticateUserUseCase requires a non-empty reason',
    );
    return _repository.authenticateUser(params!);
  }
}
```

### Управление состоянием через BLoC

```dart
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
  })  : _checkAvailabilityUseCase = checkAvailabilityUseCase,
        _authenticateUseCase = authenticateUseCase,
        _enableUseCase = enableUseCase,
        _disableUseCase = disableUseCase,
        super(BiometryInitial()) {
    on<CheckBiometryAvailability>(_onCheckAvailability);
    on<AuthenticateUser>(_onAuthenticateUser);
    on<EnableBiometry>(_onEnableBiometry);
    on<DisableBiometry>(_onDisableBiometry);
  }

  Future<void> _onCheckAvailability(
    CheckBiometryAvailability event,
    Emitter<BiometryState> emit,
  ) async {
    emit(BiometryLoading());
    
    final result = await _checkAvailabilityUseCase();
    result.fold(
      (failure) => emit(BiometryError(failure.toString())),
      (status) => emit(BiometryStatusLoaded(status)),
    );
  }
}
```

### Отображение в UI

```dart
@RoutePage()
class BiometryScreen extends StatelessWidget {
  const BiometryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          context.read<BiometryBloc>()..add(const CheckBiometryAvailability()),
      child: Dialog(
        insetPadding: EdgeInsets.symmetric(
          horizontal: context.spacingL,
          vertical: context.spacingXL,
        ),
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: context.dialogMaxWidth),
          child: Padding(
            padding: EdgeInsets.all(context.spacingL),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: const [BiometryDialogContent()],
            ),
          ),
        ),
      ),
    );
  }
}
```

---

## Возможности пакета local_auth

### Поддерживаемые типы биометрии

Пакет `local_auth` поддерживает следующие типы биометрической аутентификации:

#### iOS
- **Touch ID** - отпечаток пальца (iPhone 5s и новее)
- **Face ID** - распознавание лица (iPhone X и новее)
- **Passcode** - код-пароль (fallback)

#### Android
- **Fingerprint** - отпечаток пальца
- **Face Recognition** - распознавание лица (Android 10+)
- **Iris Recognition** - распознавание радужной оболочки глаза
- **Pattern/PIN/Password** - графический ключ, PIN или пароль (fallback)

### Основные методы API

#### Проверка доступности биометрии

```dart
import 'package:local_auth/local_auth.dart';

final LocalAuthentication auth = LocalAuthentication();

// Проверка поддержки биометрии устройством
final bool canCheckBiometrics = await auth.canCheckBiometrics;

// Проверка доступности биометрии
final List<BiometricType> availableBiometrics = 
    await auth.getAvailableBiometrics();

// Проверка поддержки конкретного типа
final bool canAuthenticateWithBiometrics = 
    await auth.isDeviceSupported();
```

#### Аутентификация

```dart
// Простая аутентификация
final bool didAuthenticate = await auth.authenticate(
  localizedReason: 'Please authenticate to access the app',
);

// Расширенная аутентификация с настройками
final bool didAuthenticate = await auth.authenticate(
  localizedReason: 'Please authenticate to access the app',
  options: const AuthenticationOptions(
    stickyAuth: true,
    biometricOnly: true,
    useErrorDialogs: true,
  ),
);
```

#### Настройки аутентификации

```dart
AuthenticationOptions(
  // Сохранять состояние аутентификации между вызовами
  stickyAuth: true,
  
  // Использовать только биометрию (без fallback на PIN/пароль)
  biometricOnly: true,
  
  // Показывать системные диалоги ошибок
  useErrorDialogs: true,
  
  // Заголовок диалога аутентификации
  authMessages: const <AuthMessages>[
    AndroidAuthMessages(
      signInTitle: 'Biometric Authentication',
      cancelButton: 'Cancel',
      biometricHint: 'Verify your identity',
    ),
    IOSAuthMessages(
      cancelButton: 'Cancel',
      goToSettingsButton: 'Settings',
      goToSettingsDescription: 'Please set up your Touch ID.',
      lockOut: 'Please reenable your Touch ID.',
    ),
  ],
)
```

### Обработка ошибок

```dart
try {
  final bool didAuthenticate = await auth.authenticate(
    localizedReason: 'Please authenticate',
  );
  
  if (didAuthenticate) {
    // Успешная аутентификация
  } else {
    // Пользователь отменил аутентификацию
  }
} on PlatformException catch (e) {
  switch (e.code) {
    case 'NotAvailable':
      // Биометрия недоступна
      break;
    case 'NotEnrolled':
      // Биометрия не настроена
      break;
    case 'PasscodeNotSet':
      // PIN/пароль не установлен
      break;
    case 'LockedOut':
      // Слишком много неудачных попыток
      break;
    case 'PermanentlyLockedOut':
      // Биометрия заблокирована навсегда
      break;
    case 'UserCancel':
      // Пользователь отменил
      break;
    case 'UserFallback':
      // Пользователь выбрал fallback
      break;
    case 'SystemCancel':
      // Система отменила аутентификацию
      break;
    case 'InvalidContext':
      // Неверный контекст
      break;
  }
}
```

### Получение информации о биометрии

```dart
// Получение всех доступных типов биометрии
final List<BiometricType> availableBiometrics = 
    await auth.getAvailableBiometrics();

// Проверка конкретного типа
if (availableBiometrics.contains(BiometricType.fingerprint)) {
  // Доступен отпечаток пальца
}

if (availableBiometrics.contains(BiometricType.face)) {
  // Доступно распознавание лица
}

if (availableBiometrics.contains(BiometricType.iris)) {
  // Доступно распознавание радужной оболочки
}
```

### Настройка сообщений для разных платформ

```dart
final authMessages = <AuthMessages>[
  AndroidAuthMessages(
    signInTitle: 'Biometric Authentication',
    cancelButton: 'Cancel',
    biometricHint: 'Verify your identity',
    biometricNotRecognized: 'Biometric not recognized',
    biometricRequiredTitle: 'Biometric Required',
    biometricSuccess: 'Biometric authentication successful',
    biometricTimeout: 'Biometric authentication timeout',
    biometricWeak: 'Biometric authentication weak',
    deviceCredentialsRequiredTitle: 'Device Credentials Required',
    deviceCredentialsSetupDescription: 'Setup device credentials',
    goToSettingsButton: 'Settings',
    goToSettingsDescription: 'Go to settings to setup biometric',
    goToSettingsTitle: 'Settings',
    invalidBiometricHint: 'Invalid biometric',
    lockOut: 'Biometric authentication locked out',
    okButton: 'OK',
    passwordRequiredTitle: 'Password Required',
    passwordSetupDescription: 'Setup password',
    signInTitle: 'Sign In',
    userCancel: 'User cancelled',
  ),
  IOSAuthMessages(
    cancelButton: 'Cancel',
    goToSettingsButton: 'Settings',
    goToSettingsDescription: 'Please set up your Touch ID.',
    lockOut: 'Please reenable your Touch ID.',
    okButton: 'OK',
    userCancel: 'User cancelled',
  ),
];
```

### Лучшие практики

1. **Всегда проверяйте доступность** биометрии перед попыткой аутентификации
2. **Предоставляйте fallback** - возможность ввода PIN/пароля
3. **Обрабатывайте все ошибки** и предоставляйте понятные сообщения пользователю
4. **Не блокируйте UI** во время аутентификации
5. **Используйте stickyAuth** для сохранения состояния между вызовами
6. **Настройте сообщения** для каждой платформы отдельно

---

## Полезные ссылки

- [local_auth package](https://pub.dev/packages/local_auth)
- [Local Authentication - Apple Developer](https://developer.apple.com/documentation/localauthentication)
- [Biometric Authentication - Android Developers](https://developer.android.com/training/sign-in/biometric-auth)
- [Flutter Local Authentication](https://docs.flutter.dev/packages-and-plugins/using-packages#plugin-specific-platform-requirements)
