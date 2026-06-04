import 'package:flutter/material.dart';
import 'package:sakeena/features/guest_portion/home/model/doors_model.dart';

class DoorCard extends StatelessWidget {
  final DoorsModel door;
  final VoidCallback? onTap;

  const DoorCard({
    super.key,
    required this.door,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    const Color darkBlueText = Color(0xFF1A365D);

    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        
        width: 160, 
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
           
            Stack(
              alignment: Alignment.center, // Centering child objects inside Stack layers
              children: [
                // 1. Arch background image layer (Passed from backend /doors API)
                Image.asset(
                  "assets/images/door.png",
                   height: 220,
                  width: 200,
                  fit: BoxFit.fill,
                 
                ),
                
                // 2. Subtle Dark Vignette for text contrast legibility
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.black.withOpacity(0.1), Colors.black.withOpacity(0.4)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
            
                // 3. Center Content (Icon and Main Header Label Placed inside Center)
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center, // Centers elements vertically
                      crossAxisAlignment: CrossAxisAlignment.center, // Centers elements horizontally
                      children: [
                        // Network or fallback central icon representation
                        if (door.icon != null)
                          Image.network(
                            door.icon!,
                            height: 32,
                            width: 32,
                            color: Colors.black87,
                            errorBuilder: (_, __, ___) => const Icon(Icons.psychology_outlined, size: 30, color: Colors.black87),
                          )
                        else
                          const Icon(Icons.psychology_outlined, size: 30, color: Colors.black87),
                        
                        const SizedBox(height: 12),
                        
                        // Door title (e.g., "Anxiety", "Trauma")
                        Text(
                          door.title ?? "",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // --- Subtitle Path Narrative Text Below Card ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                door.content ?? "Path to Peace", // Changed force unwrap '!' to a safe null-safety fallback string
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                  height: 1.3,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}