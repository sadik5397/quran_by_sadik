import 'package:flutter/material.dart';
import 'package:quran_by_sadik/util/local_save.dart';

import '../util/http_functions.dart';

class ProviderQari with ChangeNotifier {
  void refresh() {
    notifyListeners();
  }

  List qariList = [];
  String selectedQariPath = "";
  String selectedQari = "";

  initialize() async {
    await getSurahList();
  }

  Future<void> getSurahList() async {
    qariList = await Http.get("https://quranicaudio.com/api/qaris");
    qariList.sort((a, b) => a['id'].compareTo(b['id']));
    selectedQariPath = await LocalSave.get(key: "qariPath") ?? "mishaari_raashid_al_3afaasee/";
    selectedQari = await LocalSave.get(key: "qari") ?? "Mishari Rashid al-`Afasy";
    refresh();
  }

  Future<void> changeQari(Map qariPath) async {
    await LocalSave.set(key: "qariPath", value: qariPath["relative_path"]);
    await LocalSave.set(key: "qari", value: qariPath["name"]);
    selectedQariPath = qariPath["relative_path"];
    selectedQari = qariPath["name"];
    refresh();
  }
}
