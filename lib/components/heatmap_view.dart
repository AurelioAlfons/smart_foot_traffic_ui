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
    // platformViewRegistry. The viewID is generated using a stable hash of the URL
    // to avoid reloading and flickering on rebuilds.
    if (kIsWeb) {
      final String viewID = url.hashCode.toString(); // 🔁 Stable view ID

      final iframe = html.IFrameElement()
        ..src = url
        ..style.border = 'none'
        ..style.width = '100%'
        ..style.height = '100%'
        ..allow = 'fullscreen'; // ✅ Allow fullscreen + JS content

      // ignore: undefined_prefixed_name
      ui.platformViewRegistry
          .registerViewFactory(viewID, (int viewId) => iframe);

      // The HtmlElementView widget is used to display the IFrameElement in the
      // Flutter Web widget tree. SizedBox ensures proper dimensions.
      return SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: HtmlElementView(viewType: viewID),
      );
    } else {
      // For Android and iOS, use the WebView widget from the webview_flutter package.
      return const Center(child: Text('WebView supported only on Android/iOS'));
    }
  }
}
