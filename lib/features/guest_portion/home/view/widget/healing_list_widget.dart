import 'package:flutter/material.dart';
import 'package:sakeena/features/guest_portion/home/model/doors_model.dart';
import 'package:sakeena/features/guest_portion/home/view/widget/doors_widget.dart';


class HealingDoorsCarouselSection extends StatefulWidget {
  final List<DoorsModel> doors;

  const HealingDoorsCarouselSection({
    super.key,
    required this.doors,
  });

  @override
  State<HealingDoorsCarouselSection> createState() => _HealingDoorsCarouselSectionState();
}

class _HealingDoorsCarouselSectionState extends State<HealingDoorsCarouselSection> {
  final ScrollController _scrollController = ScrollController();

  // Scroll carousel views sequentially to the left or right manually via buttons
  void _scroll(bool forward) {
    double targetOffset = forward 
        ? _scrollController.offset + 340 // Shifts roughly two cards forward
        : _scrollController.offset - 340;

    _scrollController.animateTo(
      targetOffset.clamp(0.0, _scrollController.position.maxScrollExtent),
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const Color titleTealColor = Color(0xFF2C5E6B);

    if (widget.doors.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // --- Header Section Block Text ---
        const SizedBox(height: 24),
        const Text(
          "Choose Your Door to Healing",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: titleTealColor,
            fontFamily: 'Serif', // Gives it that polished look from the design
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "Each door leads to a path of healing, strength, and spiritual growth.",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 13,
            color: Colors.grey.shade600,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 24),

        // --- Main Horizontal Carousel Wrapper Track ---
        SizedBox(
          height: 290, // Covers both the card body and the dual text layers underneath
          child: ListView.builder(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: widget.doors.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(right: 12.0),
                child: DoorCard(
                  door: widget.doors[index],
                  onTap: () {
                    // Route to dynamic healing module path screen
                  },
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 12),

        // --- Custom Lower Arrow Bubble Navigation Row ---
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () => _scroll(false),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Icon(Icons.chevron_left, size: 20, color: Colors.grey.shade600),
              ),
            ),
            const SizedBox(width: 16),
            GestureDetector(
              onTap: () => _scroll(true),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Icon(Icons.chevron_right, size: 20, color: Colors.grey.shade600),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}