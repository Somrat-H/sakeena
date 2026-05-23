import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentWebViewScreen extends StatefulWidget {
  final String checkoutUrl;

  const PaymentWebViewScreen({
    super.key,
    required this.checkoutUrl,
  });

  @override
  State<PaymentWebViewScreen> createState() => _PaymentWebViewScreenState();
}

class _PaymentWebViewScreenState extends State<PaymentWebViewScreen> {
  late final WebViewController _controller;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            setState(() {
              _isLoading = true;
            });
          },
          onPageFinished: (String url) {
            setState(() {
              _isLoading = false;
            });
          },
          onNavigationRequest: (NavigationRequest request) {
            final currentUrl = request.url;

            // Catch backend redirect callbacks to close the webview automatically
            if (currentUrl.contains('/success') || currentUrl.contains('payment-success')) {
              // Pop back to detail view and pass true to trigger dashboard refresh
              Navigator.pop(context, true); 
              return NavigationDecision.prevent;
            }
            
            if (currentUrl.contains('/cancel') || currentUrl.contains('payment-cancel')) {
              Navigator.pop(context, false);
              return NavigationDecision.prevent;
            }

            return NavigationDecision.navigate;
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint("WebView Resource Error: ${error.description}");
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.checkoutUrl));
  }

  @override
  Widget build(BuildContext context) {
    const Color tealColor = Color(0xFF2C7A7B);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        title: const Text(
          "Secure Checkout",
          style: TextStyle(
            color: Colors.black87, 
            fontSize: 18, 
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black87),
          onPressed: () {
            // Prompts user validation or handles a clean checkout exit loop
            Navigator.pop(context, false);
          },
        ),
      ),
      body: Stack(
        children: [
          // The Main Web View Core Panel
          WebViewWidget(controller: _controller),

          // Intermittent Loading Wheel Cover Layer
          if (_isLoading)
            Container(
              color: Colors.white,
              child: const Center(
                child: CircularProgressIndicator(
                  color: tealColor,
                  strokeWidth: 3,
                ),
              ),
            ),
        ],
      ),
    );
  }
}