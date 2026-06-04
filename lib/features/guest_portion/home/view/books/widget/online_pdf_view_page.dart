import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

class OnlinePdfViewerPage extends StatefulWidget {
  final String pdfUrl;
  final String title;

  const OnlinePdfViewerPage({super.key, required this.pdfUrl, required this.title});

  @override
  State<OnlinePdfViewerPage> createState() => _OnlinePdfViewerPageState();
}

class _OnlinePdfViewerPageState extends State<OnlinePdfViewerPage> {
  String? localPath;
  bool isLoading = true;
  String errorMessage = "";

  @override
  void initState() {
    super.initState();
    _downloadAndCachePdf();
  }

  Future<void> _downloadAndCachePdf() async {
    try {
      final dir = await getTemporaryDirectory();
      // Generate a distinct local filename based on hash code to prevent collisions
      final file = File("${dir.path}/sample_${widget.pdfUrl.hashCode}.pdf");

      if (!await file.exists()) {
        final dio = Dio();
        await dio.download(widget.pdfUrl, file.path);
      }

      setState(() {
        localPath = file.path;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = "Failed to open document sample: $e";
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title, style: const TextStyle(fontSize: 16, color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: const BackButton(color: Colors.black),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator(color: Color(0xFF2C7A7B)))
          : errorMessage.isNotEmpty
              ? Center(child: Text(errorMessage, style: const TextStyle(color: Colors.red)))
              : PDFView(
                  filePath: localPath,
                  enableSwipe: true,
                  swipeHorizontal: false,
                  autoSpacing: true,
                  pageFling: true,
                  onError: (error) {
                    debugPrint("PDFView Error: $error");
                  },
                ),
    );
  }
}