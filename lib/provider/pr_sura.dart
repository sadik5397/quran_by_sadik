import 'package:flutter/material.dart';

import '../util/http_functions.dart';
import '../util/print.dart';

class ProviderSurah with ChangeNotifier {
  void refresh() {
    notifyListeners();
  }

  List surahList = [];
  List<bool> isPlaying = [];

  initialize() async {
    Print.info("Home Provider Initialized");
    await getSurahList();
  }

  void togglePlayPause(int index) {
    // Pause the playing one
    if (isPlaying.indexWhere((element) => element == true) != index) {
      isPlaying = List.generate(surahList.length, (index) => false);
    }
    refresh();
    // Toggle Current One
    isPlaying[index] = !isPlaying[index];
    refresh();
  }

  Future<void> getSurahList() async {
    surahList = await Http.get("https://quranicaudio.com/api/surahs");
    isPlaying = List.generate(surahList.length, (index) => false);
    refresh();
  }
}
