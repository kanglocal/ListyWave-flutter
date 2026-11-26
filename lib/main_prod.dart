import 'app/env.dart';
import 'bootstrap.dart';

void main() => bootstrap(Env.fromEnvironment(Flavor.prod));
