import 'package:flutter/material.dart';

/// web `toasting({type, txt})` 대신 쓰는 SnackBar (PLAN §6 react-toastify).
void showToast(BuildContext context, String message) {
  ScaffoldMessenger.maybeOf(context)
    ?..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text(message)));
}
