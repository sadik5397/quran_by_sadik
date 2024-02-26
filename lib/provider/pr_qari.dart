import 'package:flutter/material.dart';

import '../util/http_functions.dart';
import '../util/print.dart';

class ProviderQari with ChangeNotifier {
  void refresh() {
    notifyListeners();
  }

  List qariList = [];

  initialize() async {
    Print.info("Home Provider Initialized");
    await getSurahList();
  }

  Future<void> getSurahList() async {
    qariList = await Http.get("https://quranicaudio.com/api/qaris");
    refresh();
  }
}
