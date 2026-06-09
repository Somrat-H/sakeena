import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:intl/intl.dart';
import 'package:sakeena/features/guest_portion/video/model/video_library_model.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoDetailsScreen extends StatefulWidget {
  final Videos videoData;

  const VideoDetailsScreen({
    super.key,
    required this.videoData,
  });

  @override
  State<VideoDetailsScreen> createState() => _VideoDetailsScreenState();
}

class _VideoDetailsScreenState extends State<VideoDetailsScreen> {
  YoutubePlayerController? _controller;
  bool _isPlayerReady = false;

  @override
  void initState() {
    super.initState();
    _initializePlayer();
  }

  void _initializePlayer() {
    final String videoUrl = widget.videoData.videoUrl ?? "";

    String? videoId = YoutubePlayer.convertUrlToId(videoUrl);

    // Fallback manual parser logic
    if (videoId == null && videoUrl.isNotEmpty) {
      try {
        videoId = videoUrl.split('/').last.split('?').first;
      } catch (_) {
        videoId = null;
      }
    }

    if (videoId != null && videoId.isNotEmpty) {
      _controller = YoutubePlayerController(
        initialVideoId: videoId,
        flags: const YoutubePlayerFlags(
          autoPlay: true,
          mute: false,
          disableDragSeek: false,
          loop: false,
          isLive: false,
          forceHD: false,
          enableCaption: true,
          showLiveFullscreenButton: true,
        ),
      )..addListener(_listener);
    }
  }

  void _listener() {
    if (mounted && _controller != null && _controller!.value.isReady) {
      setState(() {
        _isPlayerReady = true;
      });
    }
  }

  @override
  void deactivate() {
    _controller?.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller?.removeListener(_listener);
    _controller?.dispose();
    super.dispose();
  }

  String _formatToSlashDate(dynamic inputDate) {
    if (inputDate == null) return "29/05/2026";
    try {
      final DateTime parsedDate = DateTime.parse(inputDate.toString().trim());
      return DateFormat('dd/MM/yyyy').format(parsedDate);
    } catch (_) {
      return inputDate.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    final String title = widget.videoData.title ?? "Video Discourse Title";
    final String description = widget.videoData.content ?? "About description missing.";
    final String category = widget.videoData.category?.name ?? "Education";
    final String author = widget.videoData.authorDetail?.fullName ?? "Sakeena Institute";
    final int views = widget.videoData.viewCount ?? 2;

    const Color surfaceBeige = Color(0xFFF7F4EB);
    const Color textPrimary = Color(0xFF0F172A);
    const Color textSecondary = Color(0xFF64748B);

    // If controller fails to load, construct standard portrait safety fallback layout tree
    if (_controller == null) {
      return Scaffold(
        backgroundColor: surfaceBeige,
        appBar: AppBar(backgroundColor: surfaceBeige, elevation: 0, leading: const BackButton(color: textSecondary)),
        body: const Center(child: Text("Invalid Video Stream Address")),
      );
    }

    // --- WRAP THE WHOLE TREE SO THE PLAYER HANDLES FULL-SCREEN NATIVELY ---
    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: _controller!,
        showVideoProgressIndicator: true,
        progressIndicatorColor: const Color(0xFFFF0000),
        progressColors: const ProgressBarColors(
          playedColor: Color(0xFFFF0000),
          handleColor: Color(0xFFFF0000),
        ),
        onReady: () {
          _isPlayerReady = true;
        },
      ),
      builder: (context, player) {
        return Scaffold(
          backgroundColor: surfaceBeige,
          body: SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // --- 1. TOP DOCK NAVIGATION HEADER BAR ---
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton.icon(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.arrow_back_ios_new, size: 14.0, color: textSecondary),
                        label: const Text(
                          "Back to Videos",
                          style: TextStyle(color: textSecondary, fontSize: 13.0, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),

                  // --- 2. YOUTUBE LIVE INLINE STREAMING PLAYER AREA ---
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16.0),
                      child: player, // Native wrapped view block inserted seamlessly here
                    ),
                  ),
                  const SizedBox(height: 16.0),

                  // --- 3. VIDEO METADATA DESCRIPTION DETAILS ---
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                    child: Container(
                      padding: const EdgeInsets.all(24.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16.0),
                        border: Border.all(color: const Color(0xFFE2E8F0), width: 1.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Category tag chip wrapper
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
                            decoration: BoxDecoration(
                              color: const Color(0xFFE6F4EA),
                              borderRadius: BorderRadius.circular(6.0),
                            ),
                            child: Text(
                              category,
                              style: const TextStyle(color: Color(0xFF137333), fontSize: 11.0, fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(height: 12.0),

                          // Title heading
                          Text(
                            title,
                            style: const TextStyle(color: textPrimary, fontSize: 20.0, fontWeight: FontWeight.bold, height: 1.35),
                          ),
                          const SizedBox(height: 12.0),

                          // Author avatar profile row integration
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                radius: 16.0,
                                backgroundColor: const Color(0xFFEDF2F7),
                                backgroundImage: widget.videoData.authorDetail?.profilePicture != null && widget.videoData.authorDetail!.profilePicture!.isNotEmpty
                                    ? NetworkImage(widget.videoData.authorDetail!.profilePicture!)
                                    : null,
                                child: widget.videoData.authorDetail?.profilePicture == null || widget.videoData.authorDetail!.profilePicture!.isEmpty
                                    ? const Icon(Icons.person_outline, size: 16.0, color: textSecondary)
                                    : null,
                              ),
                              const SizedBox(width: 10.0),
                              Expanded(
                                child: Text(
                                  author,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(color: Color(0xFF1E3A8A), fontSize: 14.0, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16.0),

                          // Views + Formatted Dates Row metrics
                          Row(
                            children: [
                              Icon(Icons.visibility_outlined, size: 15.0, color: textSecondary.withOpacity(0.8)),
                              const SizedBox(width: 4.0),
                              Text("$views views", style: const TextStyle(color: textSecondary, fontSize: 12.0)),
                              const SizedBox(width: 16.0),
                              Icon(Icons.calendar_today_outlined, size: 14.0, color: textSecondary.withOpacity(0.8)),
                              const SizedBox(width: 4.0),
                              Text(_formatToSlashDate(widget.videoData.createdAt), style: const TextStyle(color: textSecondary, fontSize: 12.0)),
                            ],
                          ),
                          const SizedBox(height: 20.0),
                          const Divider(color: Color(0xFFEDF2F7), height: 1.0),
                          const SizedBox(height: 20.0),

                          const Text(
                            "About this video",
                            style: TextStyle(color: textPrimary, fontSize: 15.5, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8.0),

                          // Document description rich layout engine
                          Html(
                            data: description,
                            style: {
                              "body": Style(
                                margin: Margins.zero,
                                padding: HtmlPaddings.zero,
                                fontSize: FontSize(13.5),
                                color: const Color(0xFF334155),
                                lineHeight: const LineHeight(1.6),
                              ),
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}