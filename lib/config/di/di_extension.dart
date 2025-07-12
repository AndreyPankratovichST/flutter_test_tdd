part of 'di.dart';

extension BuildContextDiExt on BuildContext {
  CherryPickProvider get _provider => CherryPickProvider.of(this);

  T get<T>({String? from}) => scope.resolve<T>();

  Scope get scope => _provider.scope;
}
