import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sakeena/features/guest_portion/home/provider/home_guest_provider.dart';

class SubscriptionPlanCard extends StatelessWidget {
  final VoidCallback? onGetPremiumPressed;

  const SubscriptionPlanCard({
    super.key,
    this.onGetPremiumPressed,
  });

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<HomeGuestProvider>();
    // Exact colors referenced from image_0de3bf.png
    const Color tealBgColor = Color(0xFF2D6A68); 
    const Color activeGreenBadge = Color(0xFF2ECC71);
    const Color premiumButtonText = Color(0xFF2D6A68);

    return Container(
      margin: const EdgeInsets.all(16.0),
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: tealBgColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- Top Row: Crown Icon, Subscription Title & Active Badge ---
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Translucent Crown Icon Box Container
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.card_membership_outlined, // Crown or subscription style icon
                  color: Colors.white,
                  size: 24,
                ),
              ),
              const SizedBox(width: 14),
              
              // Title and Active Tag
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                         Text(
                         controller.subscriptionPlanModel.name ?? "N/A" ,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: activeGreenBadge,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Text(
                            "Active",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    
                    // Description Text Block
                    Text(
                      controller.subscriptionPlanModel.description!,
 style: TextStyle(
                        color: Colors.white.withOpacity(0.85),
                        fontSize: 11,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 20),

          // --- Middle Row: Price Label & "Get Premium" Action Button ---
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Price text grouping
              Row(
                
                textBaseline: TextBaseline.alphabetic,
                children: [
                   Text(
                    "\$${controller.subscriptionPlanModel.price}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    " /month",
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),

              // Solid White "Get Premium" Button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: premiumButtonText,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: onGetPremiumPressed,
                child: const Text(
                  "Get Premium",
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),
          Divider(color: Colors.white.withOpacity(0.15), height: 1),
          const SizedBox(height: 20),

          // --- Bottom Feature Checklist Split Matrix (2 Columns) ---
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Column 1
              Expanded(
                child: Column(
                  children: [
                    _buildFeatureItem("Access to all existing courses"),
                    _buildFeatureItem("New content added monthly"),
                    _buildFeatureItem("Certificate of completion"),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              // Column 2
              Expanded(
                child: Column(
                  children: [
                    _buildFeatureItem("All upcoming courses included"),
                    _buildFeatureItem("Cancel anytime"),
                    _buildFeatureItem("Community forum access"),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Helper builder method to render clean checkmarked feature lines cleanly
  Widget _buildFeatureItem(String featureText) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.check,
            color: Colors.white.withOpacity(0.85),
            size: 14,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              featureText,
              style: TextStyle(
                color: Colors.white.withOpacity(0.9),
                fontSize: 11,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}