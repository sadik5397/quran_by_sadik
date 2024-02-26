import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'provider/pr_qari.dart';
import 'provider/pr_sura.dart';
import 'util/page_navigation.dart';
import 'views/surah.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => ProviderSurah()),
      ChangeNotifierProvider(create: (_) => ProviderQari()),
    ], child: MaterialApp(navigatorKey: navigatorKey, debugShowCheckedModeBanner: false, title: 'Quran by S.a. Sadik', home: const AllSurah()));
  }
}
