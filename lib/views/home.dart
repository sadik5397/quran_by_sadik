import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/pr_home.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<ProviderHome>(context, listen: false).initialize();
    return Scaffold(
      appBar: AppBar(),
      body: Consumer<ProviderHome>(builder: (context, p, child) => Center(child: Text(p.text))),
    );
  }
}
