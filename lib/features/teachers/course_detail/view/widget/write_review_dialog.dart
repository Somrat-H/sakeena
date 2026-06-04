import 'package:flutter/material.dart';

class WriteReviewDialog extends StatefulWidget {
  final int courseId;

  const WriteReviewDialog({super.key, required this.courseId});

  @override
  State<WriteReviewDialog> createState() => _WriteReviewDialogState();
}

class _WriteReviewDialogState extends State<WriteReviewDialog> {
  int _selectedRating = 0;
  final TextEditingController _reviewController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Layout Theme Palette Matching Your Brand Design
  static const Color textPrimary = Color(0xFF1E293B);   // Deep Slate Gray
  static const Color textSecondary = Color(0xFF64748B); // Muted Subtitle Gray
  static const Color starActive = Color(0xFFF59E0B);    // Orange Tint
  static const Color starInactive = Color(0xFFCBD5E1);  // Light Gray Border Star
  static const Color tealBrand = Color(0xFF8CAFB2);     // Soft Desaturated Muted Teal Button Tone

  @override
  void dispose() {
    _reviewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
  
    return Dialog(
      backgroundColor: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- 1. HEADER TITLE ROW WITH CLOSE BUTTON ---
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Write a Review",
                    style: TextStyle(
                      color: textPrimary,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close, color: textSecondary, size: 20.0),
                    splashRadius: 20.0,
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
              const SizedBox(height: 4.0),
              
              // --- 2. SUBTITLE TEXT ---
              const Text(
                "Share your thoughts about this course with other students.",
                style: TextStyle(
                  color: textSecondary,
                  fontSize: 13.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 20.0),

              // --- 3. INTERACTIVE STAR SELECTION ROW ---
              Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(5, (index) {
                  final int starValue = index + 1;
                  final bool isSelected = starValue <= _selectedRating;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedRating = starValue;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Icon(
                        isSelected ? Icons.star : Icons.star_border,
                        color: isSelected ? starActive : starInactive,
                        size: 28.0,
                      ),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 20.0),

              // --- 4. REVIEW TEXTAREA TEXTFORMFIELD ---
              TextFormField(
                controller: _reviewController,
                maxLines: 4,
                maxLength: 500,
                buildCounter: (context, {required currentLength, required isFocused, maxLength}) => const SizedBox.shrink(),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter your review comments';
                  }
                  if (_selectedRating == 0) {
                    return 'Please select a star rating rating selection';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  hintText: "Your review...",
                  hintStyle: TextStyle(color: textSecondary.withOpacity(0.5), fontSize: 14.0),
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding: const EdgeInsets.all(16.0),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: Color(0xFFF1F5F9), width: 1.5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: Color(0xFF2C7A7B), width: 1.5),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: Colors.redAccent, width: 1.0),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: Colors.redAccent, width: 1.5),
                  ),
                ),
              ),
              const SizedBox(height: 24.0),

              // --- 5. BOTTOM ACTION ACTION ACTION ROW ---
              Row(
                children: [
                  // Cancel dismiss trigger
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14.0),
                        side: const BorderSide(color: Color(0xFFCBD5E1), width: 1.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      child: const Text(
                        "Cancel",
                        style: TextStyle(
                          color: textPrimary,
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12.0),
                  // Form validation action button
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (_selectedRating == 0) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Please select a star rating before submitting.")),
                          );
                          return;
                        }
                        if (_formKey.currentState?.validate() ?? false) {
                          // Execute background POST logic using: 
                          // _selectedRating and _reviewController.text
                          Navigator.pop(context);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: tealBrand,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(vertical: 14.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      child: const Text(
                        "Submit Review",
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}