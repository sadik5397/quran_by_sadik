/*
  Copyright (c) $originalComment.match("Copyright \(c\) (\d+)", 1, "-")$today.month $today.year.
  Project: Chondo (by MasterKey)
  Portfolio: https://sadik.work or https://github.com/sadik5397
  Contact: sadik5397@gmail.com
*/

import 'package:flutter/material.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<dynamic> route(BuildContext context, Widget widget) => Navigator.push(context, MaterialPageRoute(builder: (context) => widget));

Future<dynamic> routeNoAnimation(BuildContext context, Widget widget) =>
    Navigator.push(context, PageRouteBuilder(pageBuilder: (context, animation1, animation2) => widget, transitionDuration: Duration.zero, reverseTransitionDuration: Duration.zero));

Future<dynamic> routeNoBackNoAnimation(BuildContext context, Widget widget) =>
    Navigator.pushReplacement(context, PageRouteBuilder(pageBuilder: (context, animation1, animation2) => widget, transitionDuration: Duration.zero, reverseTransitionDuration: Duration.zero));

dynamic routeBack(BuildContext context) => Navigator.pop(context);

Future<dynamic> routeNoBack(BuildContext context, Widget widget) => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => widget));

Future<Object?>? globalRoute(Widget widget) => navigatorKey.currentState?.push(MaterialPageRoute(builder: (context) => widget));

Future<Object?>? globalRouteNoBack(Widget widget) => navigatorKey.currentState?.pushReplacement(MaterialPageRoute(builder: (context) => widget));
