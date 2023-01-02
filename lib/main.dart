import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/di/injector.dart';
import 'core/routes/app_router.dart';
import 'core/themes/app_theme.dart';
import 'core/widgets/app_error_widget.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await configureInjection();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final AppRouter _appRouter = getIt<AppRouter>();
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp.router(
        restorationScopeId: 'root',
        debugShowCheckedModeBanner: false,
        routeInformationParser: _appRouter.defaultRouteParser(),
        routerDelegate: _appRouter.delegate(),
        theme: AppTheme.lightTheme,
        builder: (BuildContext context, Widget? child) {
          ErrorWidget.builder = (FlutterErrorDetails details) => AppErrorWidget(
                message: details.exceptionAsString(),
              );
          return child!;
        },
      ),
    );
  }
}
