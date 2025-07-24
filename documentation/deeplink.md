# Работа с DeepLink

## iOS

Существует два способа глубинных ссылок: **Custom URL schemes** и **Universal Links**.

- **Custom URL schemes** позволяют работать с любой схемой вида: `your_scheme://any_host`. Однако
  необходимо убедиться, что схема уникальна. Этот подход не будет работать, если приложение не
  установлено.

- **Universal Links** немного сложнее. Они позволяют работать только по схеме `https` с указанным
  хостом, правами доступа и размещённым файлом — `apple-app-site-association`. Универсальные ссылки
  позволяют запускать приложение по URL: `https://your_host`.

## Android

На Android есть два схожих способа: **App Links** и **Deep Links**.

- **App Links** позволяют работать по протоколу `https` и требуют указания хоста и размещённого
  файла (аналогично Universal Links в iOS).
- **Deep Links** позволяют использовать собственную схему и не требуют хоста или размещенного
  файла (аналогично Custom URL schemes в iOS).

---

## Настройка

### iOS

Добавить следующий фрагмент в файл Info.plist:

```xml

<key>CFBundleURLTypes</key><array>
<dict>
    <key>CFBundleURLName</key>
    <string>test.tdd.app</string>
    <key>CFBundleURLSchemes</key>
    <array>
        <string>tdd</string>
    </array>
</dict>
</array>
```

Для App Links необходимо подготовить файл `apple-app-site-association` и разместить по адресу
`https://example.com/.well-known/apple-app-site-association`.

Пример `apple-app-site-association`:

```json
{
  "applinks": {
    "details": [
      {
        "appIDs": [
          "ABCDE12345.com.example.app"
        ],
        "components": [
          {
            "#": "no_universal_links",
            "exclude": true,
            "comment": "Matches any URL with a fragment that equals no_universal_links and instructs the system not to open it as a universal link."
          },
          {
            "/": "/buy/*",
            "comment": "Matches any URL with a path that starts with /buy/."
          },
          {
            "/": "/help/website/*",
            "exclude": true,
            "comment": "Matches any URL with a path that starts with /help/website/ and instructs the system not to open it as a universal link."
          },
          {
            "/": "/help/*",
            "?": {
              "articleNumber": "????"
            },
            "comment": "Matches any URL with a path that starts with /help/ and that has a query item with name 'articleNumber' and a value of exactly four characters."
          }
        ]
      }
    ]
  }
}
```

ABCDE12345.com.example.app -> TeamID.BundleIdentifier

### Android

Добавить следующий фрагмент в `AndroidManifest.xml`:

```xml
<!-- App Link example -->
<intent-filter android:autoVerify="true">
    <action android:name="android.intent.action.VIEW" />
    <category android:name="android.intent.category.DEFAULT" />
    <category android:name="android.intent.category.BROWSABLE" />
    <data android:scheme="https" android:host="www.example.com" />
</intent-filter>

    <!-- Deep Link example -->
<intent-filter>
<action android:name="android.intent.action.VIEW" />
<category android:name="android.intent.category.DEFAULT" />
<category android:name="android.intent.category.BROWSABLE" />
<data android:scheme="tdd" android:host="test.tdd.app" />
</intent-filter>
```

Для App Link подготовьте `assetlinks.json` и разместите по адресу
`https://example.com/.well-known/assetlinks.json`.

Пример `assetlinks.json`:

```json
[
  {
    "relation": [
      "delegate_permission/common.handle_all_urls"
    ],
    "target": {
      "namespace": "android_app",
      "package_name": "com.example",
      "sha256_cert_fingerprints": [
        "14:6D:E9:83:C5:73:06:50:D8:EE:B9:95:2F:34:FC:64:16:A0:83:42:E6:1D:BE:A8:8A:04:96:B2:3F:CF:44:E5"
      ]
    }
  }
]
```

sha256_cert_fingerprints -> keytool -list -v -keystore <путь_к_файлу_keystore> -alias <алиас_ключа> -storepass <пароль_хранилища> 

---

## Работа с auto_route

`auto_route` автоматически обрабатывает deep links, поэтому дополнительная логика для их работы с
платформой не требуется.

Для корректной работы необходимо:

- В роутах указывать параметр `path`.
- Для обработки url использовать `deepLinkTransformer`, например:

    ```dart
    MaterialApp.router(
      routerConfig: _appRouter.config(
        deepLinkTransformer: DeepLink.prefixStripper('prefix'),
      ),
    );
    ```

- В определении роутов:

    ```dart
    AutoRoute(
      path: Routes.listing,
      page: ShellRoute.page,
      children: [
        AutoRoute(path: '', page: ArticlesRoute.page),
        AutoRoute(path: '${Routes.description}/:id', page: DetailsRoute.page),
      ],
    ),
    ```

Первый уровень path должен начинаться с «/», дочерние — без «/».

Параметры, передаваемые в path (например, id в `${Routes.description}/:id`), должны быть объявлены в
параметрах виджета как path-параметры. Аналогично и с query параметрами. Для этого используйте
аннотацию `@pathParam` и `@queryParam`, например:

```dart
@RoutePage()
class DetailsScreen extends StatefulWidget {
  final int id;
  final String? title;

  const DetailsScreen({
    super.key,
    @pathParam required this.id,
    @queryParam this.title,
  });

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}
```

Если требуется обработка только определённых маршрутов, предусмотрен `deepLinkBuilder`, например:

```dart
MaterialApp.router(
    routerConfig: _appRouter.config(
    deepLinkBuilder: (deepLink) {
      if (deepLink.path.startsWith('/products')) {
        // continue with the platform link
      return deepLink;
      } else {
        return DeepLink.defaultPath;
        // или DeepLink.path('/')
        // или DeepLink([HomeRoute()])
      }
    },
  ),
);
```

---

## Кастомная работа с DeepLink

Для кастомной работы с deep link можно использовать сторонние пакеты,
например [app_links](https://pub.dev/packages/app_links), или реализовать собственное решение.

При создании своей реализации учитывайте, что переход в приложение может быть совершен по ссылке как
во время работы приложения, так и при его запуске.

### Пример передачи URL с платформы

#### iOS

```swift
@main
@objc class AppDelegate: FlutterAppDelegate {
    private let DEEP_LINK_CHANNEL: String = "com.example.flutter_test_tdd/channel"
    private let DEEP_LINK_EVENT: String = "com.example.flutter_test_tdd/event"
    private let METHOD_DEEP_LINK_INIT: String = "deepLinkInit"

    private var methodChannel: FlutterMethodChannel?
    private var eventChannel: FlutterEventChannel?

    private let linkStreamHandler = LinkStreamHandler()
    private var initialLink: String?

    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let controller = window.rootViewController as! FlutterViewController
        methodChannel = FlutterMethodChannel(name: DEEP_LINK_CHANNEL, binaryMessenger: controller.binaryMessenger)
        methodChannel?.setMethodCallHandler({ (call: FlutterMethodCall, result: FlutterResult) in
            guard call.method == self.METHOD_DEEP_LINK_INIT else {
                result(FlutterMethodNotImplemented)
                return
            }
            result(self.initialLink)
        })

        eventChannel = FlutterEventChannel(name: DEEP_LINK_EVENT, binaryMessenger: controller.binaryMessenger)
        GeneratedPluginRegistrant.register(with: self)
        eventChannel?.setStreamHandler(linkStreamHandler)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }

    override func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
        initialLink = url.absoluteString
        eventChannel?.setStreamHandler(linkStreamHandler)
        return linkStreamHandler.handleLink(url.absoluteString)
    }
}

class LinkStreamHandler: NSObject, FlutterStreamHandler {
    var eventSink: FlutterEventSink?
    var queuedLinks = [String]()

    func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        self.eventSink = events
        queuedLinks.forEach({ events($0) })
        queuedLinks.removeAll()
        return nil
    }

    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        self.eventSink = nil
        return nil
    }

    func handleLink(_ link: String) -> Bool {
        guard let eventSink = eventSink else {
            queuedLinks.append(link)
            return false
        }
        eventSink(link)
        return true
    }
}
```

#### Android

```kotlin
class MainActivity : FlutterActivity() {
    private val DEEP_LINK_CHANNEL = "com.example.flutter_test_tdd/channel"
    private val DEEP_LINK_EVENT = "com.example.flutter_test_tdd/event"
    private val METHOD_DEEP_LINK_INIT = "deepLinkInit"

    private var initUrl: String? = null
    private var urlReceiver: BroadcastReceiver? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            DEEP_LINK_CHANNEL
        ).setMethodCallHandler { call, result ->
            if (call.method == METHOD_DEEP_LINK_INIT) {
                if (initUrl != null) {
                    result.success(initUrl)
                }
            }
        }

        EventChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            DEEP_LINK_EVENT
        ).setStreamHandler(
            object : EventChannel.StreamHandler {
                override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
                    urlReceiver = createChangeReceiver(events)
                }

                override fun onCancel(arguments: Any?) {
                    urlReceiver = null
                }
            }
        )
    }

    fun createChangeReceiver(sink: EventChannel.EventSink?): BroadcastReceiver? =
        object : BroadcastReceiver() {
            override fun onReceive(
                context: android.content.Context?,
                intent: android.content.Intent
            ) {
                val url = intent.dataString
                if (url != null) {
                    sink?.success(url)
                }
            }
        }

    override fun onCreate(savedInstanceState: Bundle?, persistentState: PersistableBundle?) {
        super.onCreate(savedInstanceState, persistentState)
        val intent = getIntent()
        initUrl = intent.dataString
    }

    override fun onNewIntent(intent: android.content.Intent) {
        super.onNewIntent(intent)
        if (intent.action == android.content.Intent.ACTION_VIEW) {
            urlReceiver?.onReceive(applicationContext, intent)
        }
    }
}
```

### Пример приема URL во Flutter приложении

```dart
class DeepLinkBloc extends Bloc<DeepLinkEvent, DeepLinkState> {
  final GetInitDeeplinkUseCase _getInitDeeplink;
  final GetDeepLinkStreamUseCase _getDeepLinkStream;

  StreamSubscription? _subscription;

  DeepLinkBloc(this._getInitDeeplink, this._getDeepLinkStream)
          : super(DeepLinkInitial()) {
    on<DeepLinkUpdateEvent>(_onDeeplinkUpdateEvent);
    _initDeepLink().then((value) => add(DeepLinkUpdateEvent(deeplink: value)));
  }

  Future<Uri?> _initDeepLink() async {
    _subscription = _getDeepLinkStream.execute().listen(_handleDataStream);
    final initialLink = (await _getInitDeeplink()).data;
    return initialLink;
  }

  void _handleDataStream(Uri? deepLink) {
    if (deepLink != null) {
      add(DeepLinkUpdateEvent(deeplink: deepLink));
    }
  }

  Future<void> _onDeeplinkUpdateEvent(
          DeepLinkUpdateEvent event,
          Emitter<DeepLinkState> emit,
          ) async {
    final deeplink = event.deeplink;
    if (deeplink != null) {
      emit(DeepLinkLoaded(deeplink));
    }
  }

  @override
  Future<void> close() async {
    await _subscription?.cancel();
    return super.close();
  }
}

class GetInitDeeplinkUseCase extends UseCase<Uri?, void> {
  final DeepLinkRepository _repository;

  GetInitDeeplinkUseCase(this._repository);

  @override
  Future<Uri?> execute([void params]) => _repository.getInitialDeepLink();
}

class GetDeepLinkStreamUseCase extends StreamUseCase<Uri?, void> {
  final DeepLinkRepository _repository;

  GetDeepLinkStreamUseCase(this._repository);

  @override
  Stream<Uri?> execute([void params]) => _repository.getDeepLinkStream();
}

class DeepLinkRepositoryImpl extends DeepLinkRepository {
  final DeepLinkPlatformSource _deepLinkPlatformSource;

  DeepLinkRepositoryImpl(this._deepLinkPlatformSource);

  @override
  Stream<Uri?> getDeepLinkStream() =>
          _deepLinkPlatformSource.getDeepLinkStream().transform(
            StreamTransformer.fromHandlers(
              handleData: (data, sink) => sink.add(Uri.tryParse(data)),
            ),
          );

  @override
  Future<Uri?> getInitialDeepLink() async {
    final deepLink = await _deepLinkPlatformSource.getInitialDeepLink();
    return Uri.tryParse(deepLink ?? '');
  }
}

class DeepLinkPlatformSourceImpl extends DeepLinkPlatformSource {
  static const deepLinkChannel = 'com.example.flutter_test_tdd/channel';
  static const deepLinkEvent = 'com.example.flutter_test_tdd/event';
  static const methodDeepLinkInit = 'deepLinkInit';

  late final MethodChannel _methodChannel;
  late final EventChannel _eventChannel;

  DeepLinkPlatformSourceImpl() {
    _methodChannel = const MethodChannel(deepLinkChannel);
    _eventChannel = const EventChannel(deepLinkEvent);
  }

  @override
  Future<String?> getInitialDeepLink() =>
          _methodChannel.invokeMethod(methodDeepLinkInit);

  @override
  Stream<dynamic> getDeepLinkStream() => _eventChannel.receiveBroadcastStream();
}
```

---

## Полезные ссылки

- [App Links - Android Developers](https://developer.android.com/training/app-links/verify-android-applinks?hl=ru)
- [Deep Linking - Android Developers](https://developer.android.com/training/app-links/deep-linking?hl=ru)
- [Supporting Associated Domains - Apple Developer](https://developer.apple.com/documentation/xcode/supporting-associated-domains)
- [Defining a Custom URL Scheme for Your App - Apple Developer](https://developer.apple.com/documentation/xcode/defining-a-custom-url-scheme-for-your-app)
- [auto_route: Deep linking](https://pub.dev/packages/auto_route#deep-linking)
- [Deep linking & navigation - Flutter Docs](https://docs.flutter.dev/ui/navigation/deep-linking)
- [Deep links and Flutter applications: how to handle them properly (Medium)](https://medium.com/flutter-community/deep-links-and-flutter-applications-how-to-handle-them-properly-8c9865af9283)
