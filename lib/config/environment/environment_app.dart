import 'environment.dart';

const dev = Environment(name: 'dev', host: 'https://dev.to');
const prod = Environment(name: 'prod', host: 'https://prod.example.com');

final environments = [dev, prod];

late final Environment env;

initEnv() {
  final String startEnv = String.fromEnvironment('env', defaultValue: 'dev');
  env = environments.firstWhere((element) => element.name == startEnv);
}