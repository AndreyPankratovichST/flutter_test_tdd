# ScrollPhysics во Flutter

## Введение

ScrollPhysics — это мощный механизм в Flutter, который определяет поведение прокрутки
scrollable-виджетов. Он отвечает за то, как виджеты реагируют на жесты пользователя, анимации и
достижение границ контента.

## Что такое ScrollPhysics?

ScrollPhysics — это класс, который имитирует физику прокрутки. Он вычисляет позицию прокрутки на
основе жестов пользователя (таких как перетаскивание и флинг) и управляет анимациями, чтобы придать
прокрутке естественное и отзывчивое поведение.

Основные задачи ScrollPhysics:

- Определение поведения при достижении границ контента (остановка или отскок).
- Обработка пользовательского ввода (драг и флинг).
- Создание анимаций для инерционной прокрутки.
- Обеспечение кроссплатформенного поведения (например, на iOS используется отскок, а на Android —
  зажатие с свечением).

ScrollPhysics является immutable (неизменяемым), и его экземпляры комбинируются через цепочку
родителей для сложного поведения.

## Типы ScrollPhysics и их использование

Flutter предоставляет несколько встроенных реализаций ScrollPhysics. Вот таблица с описаниями:

| Тип Physics                   | Поведение                                          | Типичный случай использования                                    |
|-------------------------------|----------------------------------------------------|------------------------------------------------------------------|
| BouncingScrollPhysics         | Отскок при достижении границы                      | Списки на iOS                                                    |
| ClampingScrollPhysics         | Резкая остановка с эффектом свечения               | Списки на Android                                                |
| AlwaysScrollableScrollPhysics | Прокрутка всегда активна                           | Когда контент может меняться и нужно всегда позволять прокрутку  |
| NeverScrollableScrollPhysics  | Прокрутка отключена                                | Когда прокрутка не нужна                                         |
| FixedExtentScrollPhysics      | Привязка к пунктам фиксированного размера          | Колесо выбора (например, ListWheelScrollView)                    |
| PageScrollPhysics             | Привязка к границам страниц                        | PageView для постраничной навигации                              |
| RangeMaintainingScrollPhysics | Поддерживает видимый диапазон элементов стабильным | Списки с динамическим контентом, где нужно минимизировать сдвиги |

Примеры использования:

```dart
// Применение BouncingScrollPhysics
ListView
(
physics: const BouncingScrollPhysics(),
children: [/* ... */],
)

// Отключение прокрутки
SingleChildScrollView(
physics: const NeverScrollableScrollPhysics(),
child: /* ... */,
)

// Комбинирование physics (предпочтительно через конструктор)
const BouncingScrollPhysics(parent: ClampingScrollPhysics());

// Альтернатива через applyTo
ScrollPhysics combinedPhysics = const BouncingScrollPhysics().applyTo(const ClampingScrollPhysics());
```

## Как работает ScrollPhysics

ScrollPhysics работает через несколько ключевых методов, которые вызываются во время жестов
прокрутки:

1. `applyPhysicsToUserOffset(ScrollMetrics position, double offset)` — преобразует смещение
   указателя пользователя в смещение прокрутки (например, добавляет сопротивление при overscroll).
2. `applyBoundaryConditions(ScrollMetrics position, double value)` — проверяет и ограничивает
   прокрутку в допустимых пределах, возвращая overscroll.
3. `createBallisticSimulation(ScrollMetrics position, double velocity)` — создает симуляцию для
   инерционной прокрутки после жеста.

Дополнительные методы:

- `shouldAcceptUserOffset(ScrollMetrics position)` — определяет, принимает ли виджет
  пользовательский ввод (учитывает `allowUserScrolling`).
- `toleranceFor(ScrollMetrics metrics)` — возвращает Tolerance для симуляций (по умолчанию
  `Tolerance.defaultTolerance`).
- `allowImplicitScrolling` — позволяет implicit прокрутку (например, через
  `RenderObject.showOnScreen`).
- `dragStartDistanceMotionThreshold` — минимальное расстояние для старта драга.

Процесс работы при драге (перетаскивании):

```dart
// Во время перетаскивания вызывается applyPhysicsToUserOffset
double applyPhysicsToUserOffset(ScrollMetrics position, double offset) {
  // Применяет физику к смещению (например, сопротивление при overscroll)
  return offset; // Базовая реализация; кастомизируется в подклассах
}
```

Процесс работы при флинге (быстром свайпе):

```dart
// При отпускании вызывается createBallisticSimulation
Simulation? createBallisticSimulation(ScrollMetrics position, double velocity) {
  // Создает симуляцию для продолжения движения по инерции
  return null; // Базовая реализация; в подклассах возвращает Simulation
}
```

## Создание собственного ScrollPhysics

Когда создавать свой ScrollPhysics:

- Требуется уникальный эффект (например, магнитная прокрутка, кастомное замедление).
- Необходимо изменить логику обработки границ или инерции.

Когда не создавать:

- Достаточно использовать встроенные типы.
- Требуется лишь изменить параметры существующей физики.

Пример: Кастомный Physics для пошаговой прокрутки.

```dart
import 'package:flutter/physics.dart';
import 'package:flutter/widgets.dart';

class CustomSnapScrollPhysics extends ScrollPhysics {
  final double itemDimension;
  final double minFlingVelocity = 50.0; // Минимальная скорость для флинга (стандартное значение)

  const CustomSnapScrollPhysics({
    required this.itemDimension,
    ScrollPhysics? parent,
  }) : super(parent: parent);

  @override
  CustomSnapScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return CustomSnapScrollPhysics(
      itemDimension: itemDimension,
      parent: buildParent(ancestor),
    );
  }

  @override
  Simulation? createBallisticSimulation(ScrollMetrics position,
      double velocity,) {
    final Tolerance tolerance = toleranceFor(position);
    // Определяем целевой пиксель
    final double targetPixel;
    if (velocity.abs() >=
        tolerance.velocity) { 
      targetPixel =
          position.pixels + velocity * 50.0; // Коэффициент для реализма
    } else {
      targetPixel = position.pixels;
    }

    // Рассчитываем индекс целевого элемента
    int index = (targetPixel / itemDimension).round();
    double targetSnapPixel = index * itemDimension;

    // Ограничиваем границами
    targetSnapPixel = targetSnapPixel.clamp(
      position.minScrollExtent,
      position.maxScrollExtent,
    );

    if (targetSnapPixel == position.pixels) return null;

    return SpringSimulation(
      SpringDescription.withDampingRatio(
        mass: 0.5,
        stiffness: 100.0,
        ratio: 1.1,
      ),
      position.pixels,
      targetSnapPixel,
      velocity,
      tolerance: tolerance,
    );
  }
}

// Использование
ListView.builder
(
scrollDirection: Axis.horizontal,
physics: const CustomSnapScrollPhysics(itemDimension: 150.0),
itemCount: 10,
itemBuilder: (context, index) => Container(
width: 150,
margin: const EdgeInsets.all(8),
color: Colors.blue,
child: Center(child: Text('Item $index
'
)
)
,
)
,
)
```

Объяснение примера:

- Наследование от ScrollPhysics обязательно.
- Метод `applyTo` создает копию physics с новым родителем.
- Метод `createBallisticSimulation` определяет логику инерционной прокрутки.
- `SpringSimulation` обеспечивает плавное "притягивание" к целевому элементу.
- Использование `toleranceFor` для точности.

## Класс Simulation и его варианты

Класс Simulation является базовым для всех симуляций во Flutter. Он моделирует поведение объекта в
одномерном пространстве под воздействием сил. Основные методы: `x(double time)` (позиция),
`dx(double time)` (скорость), `isDone(double time)` (завершена ли симуляция).

Основные реализации Simulation:

| Класс Simulation         | Назначение                                   | Параметры                                                                            |
|--------------------------|----------------------------------------------|--------------------------------------------------------------------------------------|
| SpringSimulation         | Моделирует пружину с заданными параметрами   | SpringDescription (mass, stiffness, damping), start, end, initialVelocity, tolerance |
| GravitySimulation        | Моделирует свободное падение под гравитацией | acceleration, start, end, initialVelocity (friction optional)                        |
| FrictionSimulation       | Моделирует трение для замедления             | drag (коэффициент трения), position, velocity, tolerance                             |
| BouncingScrollSimulation | Специализированная симуляция для отскока     | spring, position, velocity, leadingExtent, trailingExtent, tolerance                 |

Примеры использования Simulation:

```dart
import 'package:flutter/physics.dart';

// SpringSimulation
final SpringDescription spring = SpringDescription(
  mass: 1,
  stiffness: 100,
  damping: 10,
);

final SpringSimulation simulation = SpringSimulation(
  spring,
  0.0, // начальная позиция
  300.0, // конечная позиция
  10.0, // начальная скорость
  tolerance: Tolerance.defaultTolerance,
);

// Использование с AnimationController
AnimationController controller = AnimationController(vsync: this);
controller.animateWith
(
simulation
);
```

```dart
// GravitySimulation (с friction)
final GravitySimulation simulation = GravitySimulation(
  9.8, // ускорение
  0.0, // начальная позиция
  300.0, // конечная позиция
  0.0, // начальная скорость
); // Friction можно добавить в подклассе или кастомно
```

```dart
// FrictionSimulation
final FrictionSimulation simulation = FrictionSimulation(
  0.5, // коэффициент трения
  100.0, // начальная позиция  
  50.0, // начальная скорость
  tolerance: Tolerance.defaultTolerance,
);
```

Как ScrollPhysics использует Simulation:  
Метод `createBallisticSimulation` в ScrollPhysics возвращает объект Simulation, который затем
используется для анимации инерционной прокрутки. Например:

- `BouncingScrollPhysics` создает `BouncingScrollSimulation` для эффекта отскока.
- `ClampingScrollPhysics` создает `FrictionSimulation` для постепенного замедления.

Создание собственной Simulation:  
Вы можете создать собственный класс симуляции, унаследовав от Simulation:

```dart
class CustomSimulation extends Simulation {
  @override
  double x(double time) {
    // Возвращает позицию в момент времени
    return time * time; // Пример: квадратичная функция
  }

  @override
  double dx(double time) {
    // Возвращает скорость в момент времени  
    return 2 * time; // Производная от x
  }

  @override
  bool isDone(double time) {
    // Определяет, завершилась ли симуляция
    return time >= 1.0;
  }
}
```

## Заключение

ScrollPhysics — это гибкий инструмент для настройки поведения прокрутки. Вы можете:

- Использовать встроенные реализации для кроссплатформенного соответствия.
- Комбинировать physics для сложного поведения.
- Создавать кастомные physics для уникальных сценариев.
- Работать с Simulation для точного управления анимациями.

Ключевые выводы:

1. ScrollPhysics определяет "ощущение" прокрутки в приложении.
2. Стандартные реализации покрывают 90% use-cases.
3. Создание кастомного ScrollPhysics требует понимания физики жестов.
4. Класс Simulation является основой для всех инерционных анимаций.
5. Правильный выбор physics значительно улучшает UX.

[ScrollPhysics](https://api.flutter.dev/flutter/widgets/ScrollPhysics-class.html)
[Simulation](https://api.flutter.dev/flutter/physics/Simulation-class.html).