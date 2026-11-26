import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app/app.dart';
import 'app/env.dart';

void bootstrap(Env env) {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ProviderScope(
      overrides: [envProvider.overrideWithValue(env)],
      child: const ListyWaveApp(),
    ),
  );
}
