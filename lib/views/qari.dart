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
              : Column(
                  children: [
                    Container(alignment: Alignment.center, width: double.maxFinite, color: Colors.white, padding: const EdgeInsets.all(12), child: const Text("Long tap to set as default Qari")),
                    Expanded(
                      child: ListView.builder(
                          itemCount: p.qariList.length,
                          itemBuilder: (context, index) => ListTile(
                              selected: p.qariList[index]["relative_path"] == p.selectedQariPath,
                              selectedTileColor: Colors.deepPurple.shade50,
                              trailing: p.qariList[index]["relative_path"] == p.selectedQariPath ? const CircleAvatar(child: Icon(Icons.done_rounded)) : null,
                              leading: CircleAvatar(child: Text(p.qariList[index]["id"].toString())),
                              title: Text(p.qariList[index]["name"].toString()),
                              subtitle: Text(p.qariList[index]["arabic_name"] ?? p.qariList[index]["description"].toString().split(",").first),
                              onLongPress: () => p.changeQari(p.qariList[index]))),
                    ),
                  ],
                );
        }));
  }
}
