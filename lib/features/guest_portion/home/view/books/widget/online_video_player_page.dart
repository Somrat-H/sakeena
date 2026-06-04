import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class OnlineVideoPlayerPage extends StatefulWidget {
  final String videoUrl;
  final String title;

  const OnlineVideoPlayerPage({super.key, required this.videoUrl, required this.title});

  @override
  State<OnlineVideoPlayerPage> createState() => _OnlineVideoPlayerPageState();
}

class _OnlineVideoPlayerPageState extends State<OnlineVideoPlayerPage> {
  late VideoPlayerController _controller;
  bool _isInitialized = false;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    // Initialize standard stream configurations using Uri endpoint structures
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
      ..initialize().then((_) {
        setState(() {
          _isInitialized = true;
        });
        _controller.play(); // Auto-play when opened
      }).catchError((error) {
        debugPrint("Video Player Exception: $error");
        setState(() {
          _hasError = true;
        });
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(widget.title, style: const TextStyle(color: Colors.white, fontSize: 16)),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      body: Center(
        child: _hasError
            ? const Text(
                "An error occurred trying to play this video stream.",
                style: TextStyle(color: Colors.white),
              )
            : _isInitialized
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AspectRatio(
                        aspectRatio: _controller.value.aspectRatio,
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            VideoPlayer(_controller),
                            // Basic controls overlay
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _controller.value.isPlaying ? _controller.pause() : _controller.play();
                                });
                              },
                              child: Container(
                                color: Colors.transparent,
                                child: Center(
                                  child: Icon(
                                    _controller.value.isPlaying ? Icons.pause_circle_filled : Icons.play_circle_filled,
                                    color: Colors.white.withOpacity(0.7),
                                    size: 64,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Video Seek timeline slider tracker
                      VideoProgressIndicator(
                        _controller,
                        allowScrubbing: true,
                        colors: const VideoProgressColors(
                          playedColor: Color(0xFF2C7A7B),
                          bufferedColor: Colors.white30,
                          backgroundColor: Colors.white12,
                        ),
                      ),
                    ],
                  )
                : const CircularProgressIndicator(color: Color(0xFF2C7A7B)),
      ),
    );
  }
}