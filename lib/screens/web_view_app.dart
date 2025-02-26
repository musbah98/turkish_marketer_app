import 'package:flutter/material.dart';
import 'package:turkish_marketer/utils/common_widgets/loading_dialog.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewApp extends StatefulWidget {
  const WebViewApp({super.key});

  @override
  State<WebViewApp> createState() => _WebViewAppState();
}

class _WebViewAppState extends State<WebViewApp> {
  late final WebViewController controller;
  bool isLoading = true; // Track loading state

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) {
            setState(() {
              isLoading = true; // Show loader when page starts loading
            });
            LoadingAlertDialog.show(context);
          },
          onPageFinished: (url) {
            setState(() {
              isLoading = false; // Hide loader when page finishes loading
            });
            LoadingAlertDialog.dismiss();
          },
        ),
      )
      ..loadRequest(
        Uri.parse('https://x.com'),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 45,
        //leading: backArrow,
        //title: const Text('Flutter WebView'),
      ),
      body: Stack(
        children: [
          WebViewWidget(
            controller: controller,
          ),
          // Show loading indicator while WebView is loading
          // isLoading
          //     ? const Center(
          //         child: CircularProgressIndicator(),
          //       )
          //     : Container(), // Hide when page is done loading
        ],
      ),
    );
  }
}
