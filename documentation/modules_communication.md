# Проекция методов общения микросервисов на модули Flutter

## Введение

### Что такое модули в Flutter?

Flutter — это фреймворк для кросс-платформенной разработки мобильных приложений. В модульной
архитектуре приложение разделяется на независимые модули (features или packages), каждый из которых
содержит свою логику, UI, состояние и зависимости. Это похоже на микросервисы, но в монолитном
приложении: модули живут в одном процессе, без сетевого общения. Примеры библиотек для модульности:
`flutter_modular`, `auto_route`, `get_it` для DI (Dependency Injection).

### Почему общение между модулями важно?

Модульная архитектура повышает maintainability, позволяет командам работать независимо и облегчает
тестирование. Общение обеспечивает:

- **Координацию**: Модули обмениваются данными (например, аутентификация влияет на корзину).
- **Масштабируемость**: Легко добавлять/удалять модули.
- **Устойчивость**: Обработка ошибок через try-catch или streams.
- **Гибкость**: Каждый модуль может использовать разные state management (Provider, Bloc, Riverpod).

Сложности: Управление зависимостями, избежание tight coupling, обеспечение thread-safety.

### Независимая маршрутизация

В Flutter маршрутизация (navigation) может быть модульной: каждый модуль определяет свои роуты, а
глобальный роутер (например, из `go_router` или `flutter_modular`) интегрирует их. Это позволяет
навигировать между модулями без знания внутренней структуры других.

## Проекция методов общения

В микросервисах общение — сетевое; в Flutter — локальное (через память, события). Синхронное: прямые
вызовы; асинхронное: через шины/потоки. Нет настоящих сетевых протоколов, но аналогии через
библиотеки.

### 1. Синхронное общение

Модуль A вызывает метод модуля B и ждет результат. Подходит для немедленных операций (e.g.,
получение данных из другого модуля).

#### 1.1. Аналог HTTP/REST API: Прямые вызовы через интерфейсы или Provider

- **Описание**: Модули экспонируют интерфейсы (abstract classes) или сервисы через DI (get_it).
  Вызовы — как REST-эндпоинты, но локально.
- **Преимущества**: Простота, низкая latency (нет сети).
- **Недостатки**: Tight coupling (если не через абстракции), blocking UI если не async.
- **Сценарии**: Получение пользовательских данных из модуля Auth для модуля Profile.
- **Пример**: Используйте `get_it` для регистрации сервисов.
  ```dart
  // В модуле Auth (auth_module.dart)
  abstract class AuthService {
    String getUserId();
  }

  // Регистрация в main.dart
  GetIt locator = GetIt.instance;
  locator.registerSingleton<AuthService>(AuthServiceImpl());

  // В модуле Profile
  String userId = locator<AuthService>().getUserId(); // Синхронный вызов
  ```
- **Связь с маршрутизацией**: Роуты могут передавать параметры (e.g.,
  `Navigator.pushNamed(context, '/profile', arguments: userId)`).

#### 1.2. Аналог gRPC: Typed вызовы через Bloc или Riverpod

- **Описание**: Строгая типизация через state management. Bloc events как unary calls, streams как
  bidirectional.
- **Преимущества**: Типобезопасность, reactive updates.
- **Недостатки**: Boilerplate код.
- **Сценарии**: Высоконагруженные UI (e.g., чат-модуль).
- **Пример**: Bloc для межмодульного общения.
  ```dart
  // В модуле Chat (chat_bloc.dart)
  class ChatBloc extends Bloc<ChatEvent, ChatState> {
    void addMessage(String msg) => add(SendMessageEvent(msg));
  }

  // В другом модуле
  BlocProvider.of<ChatBloc>(context).addMessage('Hello'); // Синхронный вызов
  ```

#### 1.3. Аналог GraphQL: Query-based с Riverpod или Provider

- **Описание**: Клиент запрашивает только нужные данные через selectors.
- **Преимущества**: Гибкость, no over-fetching.
- **Недостатки**: Сложность в setup.
- **Сценарии**: Динамичные UI.
- **Пример**: Riverpod providers.
  ```dart
  // В модуле Data
  final dataProvider = Provider<Map<String, dynamic>>((ref) => {'name': 'Andrey', 'age': 30});

  // В другом модуле
  final name = ref.watch(dataProvider.select((data) => data['name'])); // Selective query
  ```

### 2. Асинхронное общение

Модуль A отправляет событие, не дожидаясь. Подходит для decoupling (e.g., уведомления).

#### 2.1. Аналог Message Queues: Event Bus или Streams

- **Описание**: Библиотеки вроде `event_bus` или Dart Streams. Модуль публикует событие, другой
  подписывается.
- **Преимущества**: Loose coupling, scalability (множество слушателей).
- **Недостатки**: No ordering guarantee, memory leaks если не dispose.
- **Сценарии**: Фоновые задачи (e.g., обновление после логина).
- **Пример**: С `event_bus`.
  ```dart
  // main.dart
  EventBus eventBus = EventBus();

  // В модуле Auth
  eventBus.fire(UserLoggedInEvent(user));

  // В модуле Cart
  eventBus.on<UserLoggedInEvent>().listen((event) => updateCart(event.user));
  ```

#### 2.2. Аналог Event-Driven Architecture (EDA): RxDart или Bloc Streams

- **Описание**: События через Subjects (RxDart). Модули реагируют на события.
- **Преимущества**: Reactivity, composable.
- **Недостатки**: Eventual consistency (данные не сразу синхронизированы).
- **Сценарии**: Реал-тайм обновления (e.g., уведомления).
- **Пример**: RxDart BehaviorSubject.
  ```dart
  // Глобальный subject
  BehaviorSubject<User> userSubject = BehaviorSubject();

  // Публикация
  userSubject.add(user);

  // Подписка
  userSubject.stream.listen((user) => print(user.name));
  ```

#### 2.3. Аналог WebSockets: Streams для реал-тайм

- **Описание**: Dart Streams для bidirectional общения (e.g., в чате).
- **Преимущества**: Низкая latency в app.
- **Недостатки**: Stateful, сложнее в multi-module.
- **Сценарии**: Локальный чат или updates.

## Сравнение методов в Flutter-контексте

| Метод (микросервисы) | Аналог в Flutter    | Тип         | Преимущества | Недостатки  | Сценарии          |
|----------------------|---------------------|-------------|--------------|-------------|-------------------|
| HTTP/REST            | Интерфейсы/Provider | Синхронный  | Простота     | Coupling    | CRUD-операции     |
| gRPC                 | Bloc/Riverpod       | Синхронный  | Типизация    | Boilerplate | Reactive UI       |
| GraphQL              | Selectors           | Синхронный  | Гибкость     | Setup       | Динамичные данные |
| Message Queues       | Event Bus           | Асинхронный | Decoupling   | No order    | Фон задачи        |
| EDA                  | RxDart              | Асинхронный | Reactivity   | Consistency | События           |
| WebSockets           | Streams             | Асинхронный | Real-time    | Stateful    | Чаты              |

## Независимая маршрутизация между модулями

- **Описание**: Каждый модуль имеет свой роутер (e.g., в `flutter_modular`: Module с binds и
  routes). Глобальный ModularApp интегрирует.
- **Преимущества**: Независимость, deep linking.
- **Недостатки**: Конфликты роутов.
- **Пример с flutter_modular**:
  ```dart
  // auth_module.dart
  class AuthModule extends Module {
    @override
    List<ModularRoute> get routes => [
      ChildRoute('/', child: (_, __) => AuthScreen()),
    ];
  }

  // main.dart
  ModularApp(
    module: AppModule(), // Агрегирует все модули
    child: MaterialApp.router(routerConfig: Modular.routerConfig),
  );

  // Навигация между модулями
  Modular.to.navigate('/profile'); // Из другого модуля
  ```
- **Интеграция с общением**: Роуты могут передавать данные (arguments) или использовать DI для
  shared state.

## Лучшие практики

- **DI**: Используйте `get_it` или Modular binds для сервисов.
- **Error Handling**: Try-catch, Stream errors.
- **Security**: Не актуально внутри app, но для shared prefs — encryption.
- **Monitoring**: Logging с `logger`, Flipper для debug.
- **Data Consistency**: Используйте single source of truth (e.g., global provider).
- **Hybrid**: Комбинируйте (Provider для sync, EventBus для async).
- **Testing**: Unit tests для модулей, integration для общения.

## Заключение

Проекция микросервисных методов на Flutter показывает, как сетевые концепции адаптируются к
локальному общению. Начните с простого DI, добавляйте async для decoupling. Модульная маршрутизация
усиливает независимость. Экспериментируйте!
