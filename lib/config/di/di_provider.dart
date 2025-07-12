part of 'di.dart';

final class CherryPickProvider extends InheritedWidget {
  final Scope scope;

  const CherryPickProvider({
    super.key,
    required this.scope,
    required super.child,
  });

  static CherryPickProvider of(BuildContext context) {
    final inheritedElement =
        context.getElementForInheritedWidgetOfExactType<CherryPickProvider>();

    final provider = inheritedElement?.widget as CherryPickProvider?;

    assert(provider != null, 'No CherryPickProvider found in context');

    return provider!;
  }

  @override
  bool updateShouldNotify(CherryPickProvider oldWidget) => false;
}
