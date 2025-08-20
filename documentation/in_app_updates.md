# Работа с In-App Updates

## Назначение

In-App Updates (обновление приложения внутри самого приложения) позволяет уведомлять пользователя о новых версиях и предлагать обновиться без необходимости покидать приложение или открывать магазин вручную. Поддерживается
---

- **На Android**: официально Google Play Core (Flexible и Immediate update), сторонние пакеты (
  например, [in_app_update](https://pub.dev/packages/in_app_update)).
- **На iOS**: стандартного механизма нет, используются сторонние решения (например, проверка версии
  через App Store, пользователь перенаправляется в магазин,
  пакет [upgrader](https://pub.dev/packages/upgrader)).

## Платформенные особенности

### Android

Поддержка системных In-App Updates реализуется
пакетом [in_app_update](https://pub.dev/packages/in_app_update) (внутри — Play Core API). Возможны
два режима:

- **Flexible**: пользователь может отложить обновление, процесс выполняется "фоном".
- **Immediate**: принудительное обновление, пользователь не сможет продолжить работу без обновления.

Требования:

- Приложение опубликовано в Google Play и имеет доступ к Play Core сервисам;
- Работает только для prod-сборок (apk/aab, загруженных через Play Store).

### iOS

Нет штатной поддержки in-app update, распространён подход:

- Регулярная проверка актуальной версии.
- Если в App Store появилась новая версия — выводится баннер или диалог «Доступно обновление».
- Для перехода к обновлению пользователь переводится на страницу приложения в App Store.

Рекомендуемые
пакеты: [upgrader](https://pub.dev/packages/upgrader), [new_version](https://pub.dev/packages/new_version).

---

## Настройка

### Android

1. Добавьте зависимость:

```yaml
dependencies:
  in_app_update: ^4.0.1
```

2. Никаких особых изменений в AndroidManifest.xml в большинстве случаев не требуется.

### iOS

1. Добавьте зависимость:

```yaml
dependencies:
  upgrader: ^10.0.0
```

2. Для App Store запросов проверьте наличие `CFBundleIdentifier` и укажите корректный Apple ID
   приложения для iOS в настройках пакета (или настройте auto-detect).

---

## Пример использования во Flutter

### Android (in_app_update)

```dart
import 'package:in_app_update/in_app_update.dart';

Future<void> checkForAndroidUpdate() async {
  try {
    final info = await InAppUpdate.checkForUpdate();
    if (info.updateAvailability == UpdateAvailability.updateAvailable) {
      // По вашему сценарию - Flexible или Immediate
      await InAppUpdate.performImmediateUpdate();
      // или
      // await InAppUpdate.startFlexibleUpdate();
    }
  } catch (e) {
    // Обработка ошибок
    debugPrint('Update check error: $e');
  }
}
```

### iOS (upgrader)

```dart
import 'package:upgrader/upgrader.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: UpgradeAlert(
        child: HomeScreen(),
        upgrader: Upgrader(
          // Можно указать параметры проверки
          // countryCode: 'RU',
          // dialogStyle: UpgradeDialogStyle.material,
          durationUntilAlertAgain: Duration(days: 1),
        ),
      ),
    );
  }
}
```

---

## Рекомендации по архитектуре

- Для групповой проверки на обеих платформах используйте абстракцию/сервис с выборкой нужной
  реализации по платформе (см. Platform.isAndroid/Platform.isIOS).
- Для разделения логики можно использовать bloc или provider.

**Пример абстракции:**

```dart
abstract class AppUpdateService {
  Future<void> checkForUpdate();
}

class AndroidAppUpdateService implements AppUpdateService {
  @override
  Future<void> checkForUpdate() async => checkForAndroidUpdate();
}

class IOSAppUpdateService implements AppUpdateService {
  @override
  Future<void> checkForUpdate() async {}
}
```

---

## Обработка ошибок и рекомендации

- Обрабатывайте все ошибки (например, отсутствие Play Store, плохой интернет, отказ пользователя,
  внутренние ошибки пакетов).
- Не вызывать обновление слишком часто: показывать не чаще 1 раза в сутки или в смену версии.
- Не форсировать Immediate Update без крайней необходимости (нарушает пользовательский опыт).

---

## Тестирование

- На Android in_app_update работает только на релизных сборках, опубликованных/загруженных через
  Play Store (на debug-сборках работать не будет!).
- На iOS тестирование возможно через изменение версии в App Store и проверки с помощью
  TestFlight/production.

---

## Полезные ссылки

- [in_app_update (pub.dev)](https://pub.dev/packages/in_app_update)
- [upgrader (pub.dev)](https://pub.dev/packages/upgrader)
- [Официальная документация Google In-App Updates](https://developer.android.com/guide/playcore/in-app-updates)
- [App Store version check (Medium)](https://medium.com/flutter-community/in-app-updates-flutter-in-android-and-ios-7cfb1f3e0b33)
- [new_version (pub.dev)](https://pub.dev/packages/new_version)

---

На практике рекомендуется всегда отображать нефорсированные уведомления (Flexible), а актуальную
логику обновления выносить в отдельный сервис со сбросом флагов при обновлении версии приложения.