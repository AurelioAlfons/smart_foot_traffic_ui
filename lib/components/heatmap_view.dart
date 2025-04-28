import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:ui' as ui;
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

class HeatmapView extends StatelessWidget {
  final String url;

  const HeatmapView({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      final String viewID =
          url + DateTime.now().millisecondsSinceEpoch.toString();
      final iframe = html.IFrameElement()
        ..src = url
        ..style.border = 'none'
        ..width = '100%'
        ..height = '100%';

      // ignore: undefined_prefixed_name
      ui.platformViewRegistry
          .registerViewFactory(viewID, (int viewId) => iframe);

      return HtmlElementView(viewType: viewID);
    } else {
      return const Center(child: Text('WebView supported only on Android/iOS'));
    }
  }
}
