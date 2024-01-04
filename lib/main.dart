import 'package:flutter/material.dart';
import 'package:teslo_shop/config/config.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  await Enviroment.initEnviroment();
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //Cuando estamos en un buils siempre manejemos con un watch
    final appRouter = ref.watch(goRouterProvider);
    return MaterialApp.router(
      routerConfig: appRouter,
      theme: AppTheme().getTheme(),
      debugShowCheckedModeBanner: false,
    );
  }
}
