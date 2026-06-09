import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:sakeena/features/guest_portion/video/model/video_library_model.dart';
import 'package:sakeena/route/go_route.dart';
import 'package:shimmer/shimmer.dart'; // <-- Import the shimmer library
import 'package:sakeena/features/guest_portion/video/provider/video_library_provider.dart';

class VideoLibraryScreen extends StatefulWidget {
  const VideoLibraryScreen({super.key});

  @override
  State<VideoLibraryScreen> createState() => _VideoLibraryScreenState();
}

class _VideoLibraryScreenState extends State<VideoLibraryScreen> {
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounceTimer;

  void _onSearchChanged(String query) {
    // 1. Cancel the active timer if the user types a new character
    if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();

    // 2. Set up a 500ms delay window
    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      if (query.trim().isNotEmpty) {
        // Trigger the search query safely via provider
        context.read<VideoLibraryProvider>().getVideosSearch("search", query.trim());
      } else {
        // Optional: Call your initial endpoint or clear list when search field becomes empty
        context.read<VideoLibraryProvider>().getVideosSearch("search", "");
      }
    });
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    _searchController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<VideoLibraryProvider>();
    final videoList = provider.videLibraryModel.vidoes ?? [];

    const Color brandTealBg = Color(0xFF3F7A7A);
    const Color surfaceBeige = Color(0xFFF7F4EB);
    const Color textDark = Color(0xFF0F172A);
    const Color textMuted = Color(0xFF64748B);

    return Scaffold(
      backgroundColor: surfaceBeige,
      body: RefreshIndicator(
        color: brandTealBg,
        onRefresh: () => context.read<VideoLibraryProvider>().getVideos(),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                color: brandTealBg,
                padding: const EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 48.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment
                      .stretch, // Allows child elements to align cleanly relative to their sides
                  children: [
                    // 1. Back Button Layer (Aligned strictly to the left edge)
                    SafeArea(
                      bottom: false,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: IconButton(
                          icon: const Icon(
                            Icons.arrow_back_ios_new,
                            color: Colors.white,
                            size: 20.0,
                          ),
                          onPressed: () => context.pop(),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8.0),

                    // 2. Main Content Stack Column (Handles center alignments cleanly)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Knowledge Pill Tag Chip
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 6.0,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: const Text(
                            "Knowledge & Insights",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16.0),

                        // Header Title
                        const Text(
                          "Video Library",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 32.0,
                            fontWeight: FontWeight.bold,
                            letterSpacing: -0.5,
                          ),
                        ),
                        const SizedBox(height: 12.0),

                        // Subtitle
                        const Text(
                          "Watch our collection of educational videos on Islamic psychology, mental wellness, and spiritual growth",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 14.0,
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 32.0),

                        // Search Box Frame Wrapper
                        ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 600),
      child: TextField(
        controller: _searchController,
        onChanged: _onSearchChanged, // Hook up the debounce logic here
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: "Search videos...",
          hintStyle: TextStyle(
            color: Colors.white.withOpacity(0.6),
            fontSize: 14.0,
          ),
          prefixIcon: Icon(
            Icons.search,
            color: Colors.white.withOpacity(0.6),
            size: 20,
          ),
          filled: true,
          fillColor: Colors.white.withOpacity(0.12),
          contentPadding: const EdgeInsets.symmetric(vertical: 14.0),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide(
              color: Colors.white.withOpacity(0.2),
              width: 1.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: const BorderSide(
              color: Colors.white,
              width: 1.5,
            ),
          ),
        ),
      ),
    )
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12.0,
                  vertical: 0,
                ),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    int crossAxisCount = 1;
                    if (constraints.maxWidth > 900) {
                      crossAxisCount = 3;
                    } else if (constraints.maxWidth > 600) {
                      crossAxisCount = 2;
                    }

                    // A. IF PROVIDER IS LOADING -> SHOW SHIMMER SKELETON
                    if (provider.isLoading) {
                      return _buildShimmerGrid(crossAxisCount);
                    }

                    // B. IF NOT LOADING & DATA IS EMPTY -> SHOW EMPTY DATA COMPONENT
                    if (videoList.isEmpty) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 80.0),
                          child: Text(
                            "No videos found in the archive library at this moment.",
                            style: TextStyle(color: textMuted, fontSize: 14.0),
                          ),
                        ),
                      );
                    }

                    // C. IF NOT LOADING & HAS DATA -> RENDER ACTUAL VIDEOS GRID
                    return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: videoList.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        crossAxisSpacing: 20.0,
                        mainAxisSpacing: 24.0,
                        childAspectRatio: 0.82,
                      ),
                      itemBuilder: (context, index) {
                        final videoItem = videoList[index];
                        return InkWell(
                          onTap: () => context.push(AppRoutes.videoDescriptionScreen, extra: videoItem),
                          child: _buildVideoCard(videoItem, textDark, textMuted));
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --- 3. SHIMMER GRID BUILDER PIECE ---
  Widget _buildShimmerGrid(int crossAxisCount) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 6, // Generates 6 cards placeholder slots while waiting
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 20.0,
        mainAxisSpacing: 24.0,
        childAspectRatio: 0.82,
      ),
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Skeleton Top Thumbnail Box
                Expanded(
                  flex: 5,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(16.0),
                      ),
                    ),
                  ),
                ),
                // Skeleton Bottom Metadata block lines
                Expanded(
                  flex: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          height: 16.0,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        Container(
                          width: 150.0,
                          height: 16.0,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        Container(
                          width: double.infinity,
                          height: 12.0,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                        ),
                        const SizedBox(height: 6.0),
                        Container(
                          width: double.infinity,
                          height: 12.0,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // --- 4. DATA VIDEO CARD ITEM ---
  Widget _buildVideoCard(Videos video, Color textDark, Color textMuted) {
    final String title = video.title ?? "Untitled Video Discourse";
    final String description =
        video.content ?? "No summary briefing description metadata supplied.";
    final String thumbnail =
        "https://i.ytimg.com/vi/${video.videoUrl!.substring(video.videoUrl!.lastIndexOf('/') + 1)}/hqdefault.jpg";
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 5,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.network(
                  thumbnail,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFF800A1D), Color(0xFF4A020D)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                    );
                  },
                ),
                Container(color: Colors.black.withOpacity(0.15)),
                Center(
                  child: Container(
                    height: 50.0,
                    width: 50.0,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.play_arrow_rounded,
                      color: Color(0xFF2C5E61),
                      size: 32.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: textDark,
                    fontSize: 14.5,
                    fontWeight: FontWeight.bold,
                    height: 1.35,
                  ),
                ),
                const SizedBox(height: 8.0),
                Html(
                  data: description,
                  style: {
                   
                    "body": Style(
                      maxLines:
                          2, 
                      textOverflow: TextOverflow
                          .ellipsis, 
                      margin: Margins
                          .zero,
                      fontSize: FontSize(12.5),
                      fontWeight: FontWeight.w400,
                      color: textMuted,
                      lineHeight: const LineHeight(1.4),
                    ),
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
