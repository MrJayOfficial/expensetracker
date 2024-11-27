// import 'package:expensentracker/home.dart';
import 'package:expensentracker/pages/homepage.dart';
import 'package:expensentracker/provider/stateprovider.dart';
import 'package:flutter/material.dart';
import 'package:expensentracker/theme/themes.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';
// import 'packag';

void main() async {
  await Hive.initFlutter();
  var box = await Hive.openBox("jay");
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // const MyApp({super.key});

  // MyApp()

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provder = ref.watch(themeProvider);
    // final themeProvd = ref.watch(prv);
    return MaterialApp(theme: provder, home: const HomeScreen());

    // return const MaterialApp(home: LineChartSample());
  }
}
