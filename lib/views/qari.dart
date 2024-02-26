import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../component/no_data.dart';
import '../provider/pr_qari.dart';
import '../util/page_navigation.dart';
import '../views/surah.dart';

class AllQari extends StatelessWidget {
  const AllQari({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<ProviderQari>(context, listen: false).initialize();
    return Scaffold(
        appBar: AppBar(title: const Text("All Qari"), actions: [IconButton(tooltip: "Change Qari", onPressed: () => route(context, const AllSurah()), icon: const Icon(Icons.headset_mic_rounded))]),
        body: Consumer<ProviderQari>(builder: (context, p, child) {
          return p.qariList.isEmpty
              ? NoData.loading()
              : ListView.builder(
                  itemCount: p.qariList.length,
                  itemBuilder: (context, index) => ListTile(
                      leading: CircleAvatar(child: Text(p.qariList[index]["id"].toString())),
                      title: Text(p.qariList[index]["name"].toString()),
                      subtitle: Text(p.qariList[index]["arabic_name"] ?? p.qariList[index]["description"].toString().split(",").first),
                      onTap: () {}));
        }));
  }
}
