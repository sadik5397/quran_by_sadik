import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:quran_by_sadik/util/global_function.dart';

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
              : Column(children: [
                  Expanded(
                      child: ListView.builder(
                          itemCount: p.surahList.length,
                          itemBuilder: (context, index) => ListTile(
                              selected: p.selectedIndex == index,
                              selectedTileColor: Colors.deepPurple.shade50,
                              leading: CircleAvatar(child: Text(p.surahList[index]["id"].toString())),
                              title: Text(p.surahList[index]["name"]["simple"]),
                              subtitle: Text('${p.surahList[index]["name"]["arabic"]} | Total Ayah: ${p.surahList[index]["ayat"]}'),
                              onTap: () => p.togglePlayPause(index),
                              trailing: CircleAvatar(child: AnimatedPlayPauseIcon(index: index))))),
                  // LinearProgressIndicator(value: ((p.currentSuraPosition ?? Duration.zero).inSeconds) / ((p.currentSuraDuration ?? Duration.zero).inSeconds + 1)),
                  if (p.selectedIndex != null)
                    Container(
                        alignment: Alignment.center,
                        width: double.maxFinite,
                        color: Colors.white,
                        padding: const EdgeInsets.all(12),
                        child: Text('${capitalizeAllWord("${cleanedString(p.surahList[p.selectedIndex!]["name"])}\n Qari: ${p.selectedQari}")}\n Developed by: S.a. Sadik: sadik.work/apps',
                            textAlign: TextAlign.center)),
                  Container(
                    color: Colors.white,
                    child: Slider(
                        min: 0,
                        max: (p.currentSuraDuration ?? Duration.zero).inSeconds.toDouble(),
                        value: (p.currentSuraPosition ?? Duration.zero).inSeconds.toDouble(),
                        onChanged: (value) async => await p.player.seek(Duration(seconds: value.toInt()))),
                  ),
                  Container(
                      color: Colors.white,
                      padding: const EdgeInsets.all(16).copyWith(top: 0),
                      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                        Text(DateFormat('HH:mm:ss').format(DateTime(0).add(p.currentSuraPosition ?? Duration.zero)), style: const TextStyle(fontSize: 18)),
                        const Text("    -    ", style: TextStyle(fontSize: 18)),
                        Text(DateFormat('HH:mm:ss').format(DateTime(0).add(p.currentSuraDuration ?? Duration.zero)), style: const TextStyle(fontSize: 18)),
                      ]))
                ]);
        }));
  }
}
