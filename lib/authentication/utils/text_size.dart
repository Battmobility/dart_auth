import 'package:flutter/material.dart';

class TextSize {
  static Size sizeFor(String text, TextStyle style, BuildContext context) {
    return (TextPainter(
            text: TextSpan(text: text, style: style),
            maxLines: 1,
            textScaler: TextScaler.linear(
                MediaQuery.of(context).textScaler.scale(style.fontSize ?? 12)),
            textDirection: TextDirection.ltr)
          ..layout())
        .size;
  }
}
