import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

import '../util/http_functions.dart';
import '../util/local_save.dart';
import '../util/print.dart';

class ProviderSurah with ChangeNotifier {
  void refresh() {
    notifyListeners();
  }

  List surahList = [];
  List<bool> isPlaying = [];
  List<bool> isLoading = [];
  int? selectedIndex;
  int? lastIndex;
  final player = AudioPlayer();

  Duration? currentSuraDuration;
  Duration? currentSuraPosition;

  String selectedQari = "";
  String selectedQariPath = "";

  initialize() async {
    // await test();
    await getSurahList();
    player.onDurationChanged.listen((newDuration) {
      currentSuraDuration = newDuration;
      refresh();
    });
    player.onPositionChanged.listen((newDuration) {
      currentSuraPosition = newDuration;
      refresh();
    });
    player.onPlayerStateChanged.listen((state) {
      if (state == PlayerState.completed) {
        Print.info("Audio Completed");
        player.stop();
        currentSuraPosition = Duration.zero;
        currentSuraDuration = Duration.zero;
        // togglePlayPause(randomNumber(10));
      }
      refresh();
    });
  }

  Future<void> test() async {
    await Http.get("https://api.alquran.cloud");
  }

  void togglePlayPause(int index) async {
    selectedIndex = index;
    // Pause the playing one
    if (isPlaying.indexWhere((element) => element == true) != index) {
      player.pause();
      isPlaying = List.generate(surahList.length, (index) => false);
    }
    refresh();
    // Toggle Current One
    if (isPlaying[index]) {
      isPlaying[index] = false;
      player.pause();
    } else if (lastIndex == selectedIndex) {
      isLoading[index] = true;
      refresh();
      await player.resume();
      isPlaying[index] = true;
      isLoading[index] = false;
    } else {
      String fileNumber = index < 9
          ? "00${index + 1}"
          : index < 99
              ? "0${index + 1}"
              : (index + 1).toString();
      String audioUrl = "https://download.quranicaudio.com/quran/$selectedQariPath$fileNumber.mp3";
      lastIndex = selectedIndex;
      currentSuraPosition = Duration.zero;
      currentSuraDuration = Duration.zero;
      isLoading[index] = true;
      refresh();
      await player.play(UrlSource(audioUrl));
      isPlaying[index] = true;
      isLoading[index] = false;
    }
    refresh();
  }

  Future<void> getSurahList() async {
    selectedQariPath = await LocalSave.get(key: "qariPath") ?? "mishaari_raashid_al_3afaasee/";
    selectedQari = await LocalSave.get(key: "qari") ?? "Mishari Rashid al-`Afasy";
    surahList = await Http.get("https://quranicaudio.com/api/surahs");
    isPlaying = List.generate(surahList.length, (index) => false);
    isLoading = List.generate(surahList.length, (index) => false);
    refresh();
  }
}
