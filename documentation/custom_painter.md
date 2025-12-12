# CustomPainter во Flutter

Мы рассмотрим назначение `CustomPainter`, его ключевые компоненты, связанные классы, примеры кода,
анимации и лучшие
практики.

## Введение

Flutter — это фреймворк для создания кросс-платформенных приложений, который позволяет разработчикам
создавать сложные пользовательские интерфейсы. Одним из мощных инструментов для кастомной графики
является `CustomPainter`. Он позволяет рисовать произвольные формы, линии, градиенты и другие
элементы на холсте (`Canvas`), что полезно для создания уникальных UI-элементов, таких как графики,
анимации, иконки или даже игр.

`CustomPainter` часто используется вместе с виджетом `CustomPaint`, который интегрирует рисование в
дерево виджетов Flutter. Это позволяет комбинировать кастомную графику с другими виджетами, такими
как кнопки или текст.

**Когда использовать CustomPainter?**

- Для создания нестандартных форм (например, кривые, многоугольники).
- Для анимаций графики.
- Для визуализации данных (графики, диаграммы).
- Когда встроенные виджеты (как `Container` или `ClipPath`) недостаточно гибки.

**Преимущества:**

- Полный контроль над рендерингом.
- Оптимизация производительности через кэширование и условные перерисовки.
- Интеграция с анимациями Flutter.

**Недостатки:**

- Требует знаний математики (координаты, углы, векторы).
- Может быть ресурсоемким при сложных вычислениях.

## Что такое CustomPainter и CustomPaint

- **CustomPainter**: Абстрактный класс из библиотеки `rendering`. Вы наследуете от него и реализуете
  логику рисования. Он определяет интерфейс для кастомного рендеринга.
- **CustomPaint**: Виджет из библиотеки `widgets`, который использует `CustomPainter` для рисования
  на холсте. Он создает `RenderCustomPaint` — объект рендеринга, который вызывает методы
  `CustomPainter`.

**Конструктор CustomPaint:**

```dart
CustomPaint(
    painter: MyPainter(), // Фоновый painter (рисуется перед child)
    foregroundPainter: MyForegroundPainter(), // Передний painter (рисуется после child)
    child: SomeWidget(), // Дочерний виджет, рисуется между painter и foregroundPainter
    size: Size(200, 200), // Размер холста, если child не указан
    isComplex: true, // Флаг для кэширования (для сложных рисунков)
    willChange:false, // Флаг, если painter изменится скоро (для анимаций)
)
```

**Порядок слоев в CustomPaint:**

1. `painter` (фон).
2. `child` (если есть).
3. `foregroundPainter` (передний план).

Если `child` не указан, размер холста определяется параметром `size`. Иначе — размером `child`.

## Ключевые методы CustomPainter

При создании класса, наследующего от `CustomPainter`, нужно реализовать два обязательных метода:

1. **paint(Canvas canvas, Size size)**:
    - Вызывается каждый раз, когда нужно перерисовать элемент.
    - `canvas`: Объект для рисования (методы вроде `drawLine`, `drawCircle`).
    - `size`: Размеры доступного холста.
    - Здесь описывается вся логика рисования.
    - Важно: Рисование за пределами `size` возможно, но может быть обрезано.

2. **shouldRepaint(CustomPainter oldDelegate)**:
    - Возвращает `bool`: `true`, если нужно перерисовать (например, если изменились параметры).
    - `oldDelegate`: Предыдущая версия painter.
    - Для статичных рисунков возвращайте `false` для оптимизации.

Дополнительные методы (опциональные):

- **hitTest(Offset position)**: Для обработки касаний (hit-testing).
- **shouldRebuildSemantics(CustomPainter oldDelegate)**: Для обновления семантики (доступность,
  screen readers).
- **semanticsBuilder**: Возвращает callback для семантики (например, метки для VoiceOver).

**Пример базового CustomPainter:**

```dart
class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Логика рисования здесь
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false; // Не перерисовывать, если ничего не изменилось
  }
}
```

CustomPainter может слушать `Listenable` (например, `AnimationController`) для автоматической
перерисовки:

```dart
class MyPainter extends CustomPainter {
  MyPainter({Listenable? repaint}) : super(repaint: repaint);
}
```

## Связанные классы

### Canvas

- Основной инструмент для рисования.
- Координатная система: (0,0) — левый верхний угол, ось Y вниз.
- Методы:
    - `drawLine(Offset start, Offset end, Paint paint)`: Линия.
    - `drawCircle(Offset center, double radius, Paint paint)`: Круг.
    - `drawRect(Rect rect, Paint paint)`: Прямоугольник.
    - `drawRRect(RRect rrect, Paint paint)`: Скругленный прямоугольник.
    - `drawArc(Rect rect, double startAngle, double sweepAngle, bool useCenter, Paint paint)`: Дуга.
    - `drawPath(Path path, Paint paint)`: Путь (сложная форма).
    - `drawPaint(Paint paint)`: Заливка всего холста.
    - `save()` / `restore()`: Сохранение/восстановление состояния (для клиппинга, трансформаций).
    - `clipRect(Rect rect)`: Обрезка области.

### Paint

- Определяет стиль рисования.
- Свойства:
    - `color`: Цвет.
    - `style`: `PaintingStyle.fill` (заливка) или `PaintingStyle.stroke` (контур).
    - `strokeWidth`: Толщина линии.
    - `strokeCap`: Концы линии (`StrokeCap.round`, `butt`, `square`).
    - `blendMode`: Режим смешивания (например, `BlendMode.srcOver`).
    - `shader`: Градиент или текстура (например, `RadialGradient`).

**Пример:**

```dart

Paint paint = Paint()
  ..color = Colors.blue
  ..style = PaintingStyle.fill
  ..strokeWidth = 2.0;
```

### Path

- Для создания сложных форм.
- Методы:
    - `moveTo(double x, double y)`: Перейти в точку.
    - `lineTo(double x, double y)`: Линия к точке.
    - `quadraticBezierTo(double x1, double y1, double x2, double y2)`: Квадратичная кривая Безье.
    - `addRect(Rect rect)` / `addOval(Rect rect)`: Добавить фигуру.
    - `close()`: Замкнуть путь.

**Пример пути:**

```dart

Path path = Path();
path.moveTo(0,0);
path.lineTo(100, 100);
path.close();
canvas.drawPath(path, paint);

```

### Другие

- **Rect**: Прямоугольник (`Rect.fromPoints(Offset a, Offset b)`).
- **RRect**: Скругленный прямоугольник (`RRect.fromRectAndRadius(rect, Radius.circular(10))`).
- **Offset**: Точка (x, y).
- **Size**: Размер (width, height).
- **BlendMode**: Режимы смешивания цветов.
- **RadialGradient** / **LinearGradient**: Градиенты.

## Использование с виджетами

Вставьте `CustomPaint` в дерево виджетов:

```dart
Scaffold(
        body: Center(
            child: CustomPaint(
            size: Size(300, 300),
            painter: MyPainter(),
        ),
    ),
)
```

Для наложения на другие виджеты используйте `Stack` или `child` в `CustomPaint`.

## Примеры: Базовые формы

### Заливка фона

```dart
void paint(Canvas canvas, Size size) {
  Paint paint = Paint()
    ..color = Colors.blue.shade300;
  canvas.drawPaint(paint);
}
```

### Линия

```dart
void paint(Canvas canvas, Size size) {
  Paint paint = Paint()
    ..color = Colors.teal
    ..strokeWidth = 5
    ..strokeCap = StrokeCap.round;

  Offset start = Offset(0, size.height / 2);
  Offset end = Offset(size.width, size.height / 2);
  canvas.drawLine(start, end, paint);
}
```

### Круг

```dart
void paint(Canvas canvas, Size size) {
  Paint paint = Paint()
    ..color = Colors.teal
    ..style = PaintingStyle.stroke
    ..strokeWidth = 5;

  Offset center = Offset(size.width / 2, size.height / 2);
  canvas.drawCircle(center, 100, paint);
}
```

### Прямоугольник

```dart
void paint(Canvas canvas, Size size) {
  Paint paint = Paint()
    ..color = Colors.pink.shade300;
  Rect rect = Rect.fromPoints(Offset(50, 50), Offset(250, 250));
  canvas.drawRect(rect, paint);
}
```

### Дуга

```dart
void paint(Canvas canvas, Size size) {
  Paint paint = Paint()
    ..color = Colors.orange
    ..style = PaintingStyle.stroke
    ..strokeWidth = 10;

  Rect rect = Rect.fromCircle(center: Offset(size.width / 2, size.height / 2), radius: 100);
  canvas.drawArc(rect, math.pi / 6, math.pi * 4 / 6, false, paint);
}
```

## Примеры: Сложные формы и пути

### Домик (из туториала Яндекса)

Вот полный пример рисования домика с использованием различных методов:

```dart
import 'dart:math' as math;

class HousePainter extends CustomPainter {
  static const _groundHeight = 100.0;
  static const _houseHeight = 275.0;
  static const _houseWidth = 250.0;
  static const _houseOnGroundOffset = 20.0;
  static const _doorHeight = _houseHeight * 0.5;
  static const _doorWidth = _houseWidth * 0.3;
  static const _doorHandleHeight = 5.0;
  static const _doorHandleWidth = 15.0;
  static const _windowRadius = 35.0;
  static const _windowRoofThickness = 10.0;

  @override
  void paint(Canvas canvas, Size size) {
    _drawSky(canvas);
    _drawGround(canvas, size);
    _drawWalls(canvas, size);
    _drawDoor(canvas, size);
    _drawDoorHandle(canvas, size);
    _drawWindow(canvas, size);
    _drawWindowRoof(canvas, size);
    _drawRoof(canvas, size);
  }

  void _drawSky(Canvas canvas) {
    canvas.drawPaint(Paint()
      ..color = Colors.blue.shade300);
  }

  void _drawGround(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.green.shade300
      ..strokeWidth = _groundHeight;

    final dY = size.height - paint.strokeWidth / 2;
    final start = Offset(0, dY);
    final end = Offset(size.width, dY);
    canvas.drawLine(start, end, paint);
  }

  void _drawWalls(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.pink.shade300;
    final centerX = size.width / 2;
    final halfWidth = _houseWidth / 2;
    final groundY = size.height - _groundHeight + _houseOnGroundOffset;
    final leftBottom = Offset(centerX - halfWidth, groundY);
    final rightTop = Offset(centerX + halfWidth, groundY - _houseHeight);
    final rect = Rect.fromPoints(leftBottom, rightTop);
    canvas.drawRect(rect, paint);
  }

  void _drawDoor(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.orange.shade700;
    const radius = Radius.circular(16);
    final centerX = size.width / 2;
    final halfWidth = _houseWidth / 2;
    final groundY = size.height - _groundHeight + _houseOnGroundOffset;
    final doorBottomY = groundY - 10;
    final doorLeftX = centerX - halfWidth + 20;
    final leftBottom = Offset(doorLeftX, doorBottomY);
    final rightTop = Offset(doorLeftX + _doorWidth, doorBottomY - _doorHeight);
    final rect = Rect.fromPoints(leftBottom, rightTop);
    final rrect = RRect.fromRectAndRadius(rect, radius);
    canvas.drawRRect(rrect, paint);
  }

  void _drawDoorHandle(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black;
    // ... (аналогично, полный код в источнике)
  }

  // Другие методы: _drawWindow, _drawWindowRoof, _drawRoof (с Path для треугольной крыши)

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
```

### Многоугольник

```dart
void paint(Canvas canvas, Size size) {
  int sides = 5; // Пятиугольник
  double radius = 100;
  Paint paint = Paint()
    ..color = Colors.teal
    ..style = PaintingStyle.stroke
    ..strokeWidth = 5;

  Path path = Path();
  double angle = (math.pi * 2) / sides;
  Offset center = Offset(size.width / 2, size.height / 2);
  Offset start = Offset(radius * math.cos(0.0), radius * math.sin(0.0)) + center;
  path.moveTo(start.dx, start.dy);

  for (int i = 1; i <= sides; i++) {
    double x = radius * math.cos(angle * i) + center.dx;
    double y = radius * math.sin(angle * i) + center.dy;
    path.lineTo(x, y);
  }
  path.close();
  canvas.drawPath(path, paint);
}
```

## Анимации с CustomPainter

Для анимаций используйте `AnimationController` и передайте его как `repaint` в `CustomPainter`. Это
заставит перерисовывать холст при изменении анимации, без перестройки дерева виджетов.

**Пример: Вращающийся многоугольник**

1. В StatefulWidget:

```dart
class AnimatedPainter extends StatefulWidget {
  @override
  _AnimatedPainterState createState() => _AnimatedPainterState();
}

class _AnimatedPainterState extends State<AnimatedPainter> with TickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(vsync: this, duration: Duration(seconds: 4));
    animation = Tween<double>(begin: -math.pi, end: math.pi).animate(controller)
      ..addListener(() => setState(() {}));
    controller.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: ShapePainter(animation.value),
      child: Container(),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
```

2. В CustomPainter:

```dart
class ShapePainter extends CustomPainter {
  final double rotation;

  ShapePainter(this.rotation);

  @override
  void paint(Canvas canvas, Size size) {
    // ... (код многоугольника)
    canvas.save();
    canvas.translate(size.width / 2, size.height / 2);
    canvas.rotate(rotation);
    canvas.translate(-size.width / 2, -size.height / 2);
    canvas.drawPath(path, paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant ShapePainter old) => old.rotation != rotation;
}
```

## Оптимизация и лучшие практики

- **shouldRepaint**: Возвращайте `false` для статичных рисунков.
- **isComplex и willChange**: Используйте для кэширования сложных рисунков.
- **RepaintBoundary**: Оберните CustomPaint для изоляции перерисовок.
- **Слои**: Используйте `canvas.saveLayer()` / `restore()` для изоляции (но sparingly, так как
  дорого).
- **Производительность**: Избегайте тяжелых вычислений в `paint`. Кэшируйте вычисления.
- **Семантика**: Реализуйте `semanticsBuilder` для доступности.
- **QuadTree**: Для сложных сцен с коллизиями (например, в играх).
- **Пакетные операции**: Используйте `drawRawAtlas` или `drawRawPoints` для множества элементов.
- **Камера**: Реализуйте систему камеры для зума/прокрутки.

**Избегайте ошибок:**

- Не рисуйте за пределами `size` без необходимости.
- Используйте `BlendMode` правильно, чтобы избежать стирания предыдущих слоев.
- Для анимаций предпочтите `repaint: controller` вместо `setState()`.

## Дополнительные ресурсы

- Официальная
  документация: [CustomPainter class](https://api.flutter.dev/flutter/rendering/CustomPainter-class.html)
- Туториал на
  Habr: [Исчерпывающее руководство по CustomPaint](https://habr.com/ru/companies/otus/articles/935384/)
-

Medium: [A Deep Dive Into CustomPaint](https://medium.com/flutter-community/a-deep-dive-into-custompaint-in-flutter-47ab44e3f216)

- Codemagic
  Blog: [How to draw and animate with CustomPaint](https://blog.codemagic.io/flutter-custom-painter/)
- Яндекс
  Образование: [CustomPainter: работа с графикой](https://education.yandex.ru/handbook/flutter/article/custompainter-rabota-s-grafikoi)
