import 'package:cortijo_app/core/data/_base_api_url.dart';
import 'package:cortijo_app/core/services/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  const WebViewPage({
    required this.url,
    super.key,
    this.isPayment = false,
  });

  final String url;
  final bool isPayment;

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  late WebViewController controller;
  int inProgress = 0;

  @override
  void initState() {
    final token = LocalDataRepository().authToken;
    final user = LocalDataRepository().user;
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            setState(() {
              inProgress = progress;
            });
          },
        ),
      )
      ..loadRequest(
          widget.isPayment
              ? Uri.parse(
                  '$BASE_API_URL/api/tpv?redirect=true&user_id=${user!.id}')
              : Uri.parse(widget.url),
          method: LoadRequestMethod.get,
          headers: widget.isPayment
              ? {
                  'Accept': 'application/json',
                  'Authorization': 'Bearer $token',
                }
              : {});

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: widget.isPayment ? null : AppBar(title: const Text("Reserva")),
        body: inProgress < 100
            ? const Center(child: CircularProgressIndicator())
            : WebViewWidget(controller: controller),
      ),
    );
  }
}
