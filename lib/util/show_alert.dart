import 'dart:math';

import 'package:flutter/material.dart';

enum AlertType { success, error, info, warning, none }

class Alert {
  static const Color _themeColorPrimary = Colors.deepPurple;
  static const BorderRadiusGeometry _themeBorderRadius = BorderRadius.all(Radius.circular(2));
  static const EdgeInsets _themePadding = EdgeInsets.all(4);
  static SnackBar _snackbar({required AlertType type, required BuildContext context, required String label, String? title}) {
    return SnackBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        dismissDirection: DismissDirection.vertical,
        behavior: SnackBarBehavior.fixed,
        duration: const Duration(milliseconds: 3500),
        content: Align(
            alignment: Alignment.bottomRight,
            child: Container(
                width: min(MediaQuery.of(context).size.width - 200, 450),
                decoration: BoxDecoration(
                    color: type == AlertType.success
                        ? Colors.green
                        : type == AlertType.error
                            ? Colors.redAccent
                            : type == AlertType.info
                                ? Colors.blueAccent
                                : type == AlertType.warning
                                    ? Colors.deepOrangeAccent
                                    : _themeColorPrimary,
                    borderRadius: _themeBorderRadius * 2),
                padding: _themePadding * 4,
                margin: _themePadding,
                child: Row(children: [
                  Expanded(
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(title ?? "Alert:", style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold), textAlign: TextAlign.start),
                    const SizedBox(height: 8),
                    Text(label, style: TextStyle(color: Colors.white.withOpacity(.9), fontSize: 12), textAlign: TextAlign.start)
                  ])),
                  const SizedBox(width: 8),
                  IconButton(onPressed: () => ScaffoldMessenger.of(context).clearSnackBars(), icon: const Icon(Icons.cancel_outlined, color: Colors.white))
                ]))));
  }

  static error({required BuildContext context, required String label, String? title}) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(_snackbar(type: AlertType.error, context: context, label: label, title: "Something went wrong"));
  }

  static success({required BuildContext context, required String label, String? title}) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(_snackbar(type: AlertType.success, context: context, label: label, title: "Success"));
  }

  static warning({required BuildContext context, required String label, String? title}) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(_snackbar(type: AlertType.warning, context: context, label: label, title: "Warning"));
  }

  static info({required BuildContext context, required String label, String? title}) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(_snackbar(type: AlertType.info, context: context, label: label, title: "Information"));
  }

  static show({required BuildContext context, required String label, String? title}) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(_snackbar(type: AlertType.none, context: context, label: label, title: "Hi Society"));
  }
}
