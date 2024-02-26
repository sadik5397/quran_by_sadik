import 'package:flutter/material.dart';

import '../util/print.dart';

class ProviderHome with ChangeNotifier {
  void refresh() {
    notifyListeners();
  }

  String text = "";

  initialize() async {
    Print.info("Home Provider Initialized");
    text = "Home Provider Initialized";
  }
}
