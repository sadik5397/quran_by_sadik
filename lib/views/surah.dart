import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../component/animated_icon.dart';
import '../component/no_data.dart';
import '../provider/pr_sura.dart';
import '../util/page_navigation.dart';
import 'qari.dart';

class AllSurah extends StatelessWidget {
  const AllSurah({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<ProviderSurah>(context, listen: false).initialize();
    return Scaffold(
        appBar: AppBar(title: const Text("All Surah"), actions: [IconButton(onPressed: () => route(context, const AllQari()), icon: const Icon(Icons.headset_mic_rounded))]),
        body: Consumer<ProviderSurah>(builder: (context, p, child) {
          return p.surahList.isEmpty
              ? NoData.loading()
              : ListView.builder(
                  itemCount: p.surahList.length,
                  itemBuilder: (context, index) => ListTile(
                        leading: CircleAvatar(child: Text(p.surahList[index]["id"].toString())),
                        title: Text(p.surahList[index]["name"]["simple"]),
                        subtitle: Text('${p.surahList[index]["name"]["arabic"]} | Total Ayah: ${p.surahList[index]["ayat"]}'),
                        onTap: () => p.togglePlayPause(index),
                        trailing: CircleAvatar(child: AnimatedPlayPauseIcon(index: index)),
                      ));
        }));
  }
}
