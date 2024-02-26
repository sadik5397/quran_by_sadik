import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quran_by_sadik/provider/pr_home.dart';
import 'package:quran_by_sadik/views/home.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => ProviderHome()),
    ], child: const MaterialApp(debugShowCheckedModeBanner: false, title: 'Quran by S.a. Sadik', home: Home()));
  }
}
