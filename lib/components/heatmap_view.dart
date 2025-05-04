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
    // This is a workaround to display a webview in Flutter Web.
    // The webview is created using an IFrameElement and registered with the
    // platformViewRegistry. The viewID is generated using the URL and the
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

      // The HtmlElementView widget is used to display the IFrameElement in the
      return HtmlElementView(viewType: viewID);
    } else {
      // For Android and iOS, use the WebView widget from the webview_flutter package.
      return const Center(child: Text('WebView supported only on Android/iOS'));
    }
  }
}
