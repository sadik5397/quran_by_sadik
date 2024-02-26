import 'package:flutter/material.dart';

class NoData {
  static Widget loading() => Container(alignment: Alignment.center, padding: const EdgeInsets.symmetric(horizontal: 48), child: const LinearProgressIndicator(color: Colors.deepPurple));
  // static Widget empty() => Opacity(opacity: .5, child: CachedNetworkImage(alignment: Alignment.center, width: 350, fit: BoxFit.contain, imageUrl: "https://i.ibb.co/h7w4FzP/No-Records.png"));
  static Widget progress(num value, num total) =>
      Container(alignment: Alignment.center, padding: const EdgeInsets.symmetric(horizontal: 48), child: LinearProgressIndicator(color: Colors.deepPurple, value: value / total));
}
