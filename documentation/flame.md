# Разработка 2D‑игр во Flutter с использованием Flame

## 1. Введение

Flame — это специализированный 2D‑игровой движок поверх Flutter, который предоставляет игровой цикл, систему компонентов, управление вводом, рендеринг, коллизии и вспомогательные инструменты для разработки игр. В отличие от обычных Flutter‑виджетов, Flame ориентирован на высокочастотное обновление состояния (game loop) и прямую работу с Canvas.

Flame не является полноценным движком наподобие Unity или Godot. Его философия — минимализм, прозрачность и тесная интеграция с Flutter. Это делает его особенно подходящим для:

* мобильных 2D‑игр;
* интерактивных сцен;
* визуализаций;
* образовательных проектов.

---

## 2. Архитектура Flame

### 2.1 Game Loop

В основе Flame лежит класс `Game`, который реализует классический игровой цикл:

1. `update(dt)` — обновление состояния игры
2. `render(Canvas)` — отрисовка текущего состояния

`dt` (delta time) — время в секундах, прошедшее с предыдущего кадра. Использование `dt` позволяет делать логику независимой от FPS.

### 2.2 FlameGame

`FlameGame` — стандартная реализация `Game`, включающая:

* менеджер компонентов;
* автоматический вызов `update` и `render` у компонентов;
* камеру;
* мир (World).

В большинстве случаев игры наследуются именно от `FlameGame`.

---

## 3. Интеграция с Flutter

### 3.1 GameWidget

Flame интегрируется во Flutter через `GameWidget`.

```dart
void main() {
  runApp(
    GameWidget(
      game: MyGame(),
    ),
  );
}
```

`GameWidget`:

* управляет жизненным циклом игры;
* синхронизируется с Flutter rendering pipeline;
* поддерживает overlays (UI поверх игры).

### 3.2 Overlays

Overlays — это обычные Flutter‑виджеты поверх игры (меню, HUD, пауза).

```dart
GameWidget(
  game: game,
  overlayBuilderMap: {
    'pause': (context, game) => PauseMenu(),
  },
)
```

Управление:

```dart
overlays.add('pause');
overlays.remove('pause');
```

---

## 4. Компонентная система

### 4.1 Component

`Component` — базовая единица логики. Он может:

* обновляться (`update`);
* загружаться (`onLoad`);
* быть добавленным/удалённым из дерева.

### 4.2 PositionComponent

`PositionComponent` добавляет:

* позицию (`position`);
* размер (`size`);
* поворот (`angle`);
* якорь (`anchor`).

```dart
class Player extends PositionComponent {
  @override
  void update(double dt) {
    position.x += 100 * dt;
  }
}
```

### 4.3 Иерархия компонентов

Компоненты могут иметь дочерние компоненты. Координаты дочерних компонентов считаются относительно родителя.

```dart
parent.add(child);
```

---

## 5. Система координат и камера

### 5.1 Координаты

* (0,0) — левый верхний угол игрового мира;
* ось X направлена вправо;
* ось Y направлена вниз;
* единица измерения — логические пиксели.

### 5.2 CameraComponent

Камера управляет тем, какая часть мира видна.

```dart
camera.follow(player);
```

Камера может:

* масштабироваться;
* следовать за объектами;
* ограничиваться границами мира.

---

## 6. Загрузка ресурсов

### 6.1 Images

```dart
final image = await images.load('player.png');
```

Для оптимизации используется кеш.

### 6.2 Sprite

```dart
sprite = Sprite(image);
```

### 6.3 SpriteComponent

```dart
class Enemy extends SpriteComponent {
  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load('enemy.png');
    size = Vector2(64, 64);
  }
}
```

---

## 7. Анимации

### 7.1 SpriteAnimation

```dart
final animation = SpriteAnimation.fromFrameData(
  image,
  SpriteAnimationData.sequenced(
    amount: 4,
    stepTime: 0.1,
    textureSize: Vector2(32, 32),
  ),
);
```

### 7.2 SpriteAnimationComponent

```dart
add(
  SpriteAnimationComponent(
    animation: animation,
    size: Vector2(64, 64),
  ),
);
```

Поддерживается:

* зацикливание;
* отслеживание завершения;
* переключение анимаций.

---

## 8. Ввод пользователя

### 8.1 Событийная модель

Flame использует callback‑ориентированную систему событий.

### 8.2 TapCallbacks

```dart
class MyGame extends FlameGame with TapCallbacks {
  @override
  void onTapDown(TapDownEvent event) {
    print(event.localPosition);
  }
}
```

### 8.3 Drag, Keyboard, Mouse

Поддерживаются:

* DragCallbacks;
* KeyboardEvents;
* HoverCallbacks;
* ScrollCallbacks.

---

## 9. Коллизии

### 9.1 CollisionCallbacks

```dart
class Ball extends CircleComponent with CollisionCallbacks {
  @override
  void onCollision(Set<Vector2> points, PositionComponent other) {
    // обработка столкновения
  }
}
```

### 9.2 Hitbox

```dart
add(RectangleHitbox());
```

Типы hitbox:

* RectangleHitbox;
* CircleHitbox;
* PolygonHitbox.

---

## 10. Слои, приоритет и порядок отрисовки

Каждый компонент имеет `priority`.

```dart
priority = 10;
```

Чем выше значение — тем позже отрисовывается компонент.

---

## 11. Время и эффекты

### 11.1 Effects

```dart
add(
  MoveEffect.to(
    Vector2(200, 200),
    EffectController(duration: 1),
  ),
);
```

Поддерживаются эффекты:

* движения;
* вращения;
* масштабирования;
* прозрачности.

Эффекты могут комбинироваться и цепляться.

---

## 12. Расширения Flame

Наиболее важные пакеты:

* flame_audio — звук и музыка;
* flame_forge2d — физика (Box2D);
* flame_tiled — тайловые карты;
* flame_bloc — интеграция с BLoC;
* flame_rive — Rive‑анимации.

---

## 13. Архитектура игры

Рекомендуемые принципы:

* разделение логики и представления;
* использование World как корня игрового состояния;
* UI выносить в overlays;
* состояния игры оформлять через state‑machine или BLoC.

---

## 14. Итог

Flame предоставляет низкоуровневый, но гибкий инструмент для создания 2D‑игр во Flutter. Он требует архитектурной дисциплины, но взамен даёт полный контроль над игровым процессом, рендерингом и вводом.

Этот подход особенно хорошо сочетается с принципами чистой архитектуры и декларативного UI Flutter.
