import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';
import 'package:sakeena/features/guest_portion/home/model/faculty_details_model.dart';
import 'package:sakeena/features/guest_portion/home/provider/home_guest_provider.dart';

class ConsultantDetailsScreen extends StatelessWidget {
  const ConsultantDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Actively watch background notifyListeners state streams from provider
    final provider = context.watch<HomeGuestProvider>();

    // Design System Color Configurations
    const Color textPrimary = Color(0xFF0F172A);
    const Color bgSurface = Color(0xFFF8FAFC);
    const Color tealBrand = Color(0xFF2C7A7B);

    return Scaffold(
      backgroundColor: bgSurface,
      appBar: AppBar(
        title: const Text(
          "Consultant Profile",
          style: TextStyle(
            color: textPrimary,
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        foregroundColor: textPrimary,
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 18.0),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      // 1. Handle Loading State directly from Provider boolean flag
      body: provider.isDetailsLaoding
          ? const Center(child: CircularProgressIndicator(color: tealBrand))
          // 2. Handle Empty or Missing Object Payload Bound Guards
          : (provider.consultationMemberDeatils == null ||
                provider.consultationMemberDeatils!.id == null)
          ? const Center(
              child: Padding(
                padding: EdgeInsets.all(24.0),
                child: Text(
                  "Profile data is currently unavailable. Please verify connection bounds and retry.",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Color(0xFF64748B), fontSize: 14.0),
                ),
              ),
            )
          // 3. Render Profile Content flawlessly with normal scrolling physics
          : SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- 1. PROFILE HEADER CARD ---
                  _buildProfileHeaderCard(
                    provider.consultationMemberDeatils!,
                    tealBrand,
                    textPrimary,
                    const Color(0xFF64748B),
                  ),
                  const SizedBox(height: 20.0),

                  // --- 2. RESPONSIVE ABOUT & ACHIEVEMENTS GRID ---
                  LayoutBuilder(
                    builder: (context, constraints) {
                      if (constraints.maxWidth > 750) {
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 3,
                              child: _buildAboutCard(
                                provider.consultationMemberDeatils!,
                                textPrimary,
                                const Color(0xFF64748B),
                              ),
                            ),
                            const SizedBox(width: 20.0),
                            Expanded(
                              flex: 2,
                              child:
                                  provider
                                          .consultationMemberDeatils
                                          ?.achievements
                                          ?.isNotEmpty ==
                                      true
                                  ? _buildAchievementsCard(
                                      textPrimary,
                                      provider
                                          .consultationMemberDeatils!
                                          .achievements!
                                          .first,
                                    )
                                  : const SizedBox.shrink(), // Takes up absolutely zero space when empty
                            ),
                          ],
                        );
                      } else {
                        return Column(
                          children: [
                            _buildAboutCard(
                              provider.consultationMemberDeatils!,
                              textPrimary,
                              const Color(0xFF64748B),
                            ),
                            const SizedBox(height: 20.0),
                            provider
                                        .consultationMemberDeatils
                                        ?.achievements
                                        ?.isNotEmpty ==
                                    true
                                ? _buildAchievementsCard(
                                    textPrimary,
                                    provider
                                        .consultationMemberDeatils!
                                        .achievements!
                                        .first,
                                  )
                                : const SizedBox.shrink(), // Takes up absolutely zero space when empty
                          ],
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 20.0),

                  // --- 3. EDUCATION TIMELINE TRACK CARD ---
                  _buildEducationCard(
                    provider.consultationMemberDeatils!,
                    textPrimary,
                    tealBrand,
                  ),
                ],
              ),
            ),
    );
  }

  // ==========================================
  // COMPONENT BUILDERS (MATCHING IMAGE SPEC)
  // ==========================================

  Widget _buildProfileHeaderCard(
    FacultyDetailsModel data,
    Color tealBrand,
    Color textPrimary,
    Color textSecondary,
  ) {
    final String firstName = data.user?.firstName ?? "";
    final String lastName = data.user?.lastName ?? "";
    final String combinedName = "$firstName $lastName".trim();
    final String finalDisplayName = combinedName.isNotEmpty
        ? combinedName
        : "Consultant Profile";

    final String initialLetter = finalDisplayName.isNotEmpty
        ? finalDisplayName.substring(0, 1).toUpperCase()
        : "U";

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: const Color(0xFFE2E8F0), width: 1.0),
      ),
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        runAlignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 20.0,
        runSpacing: 20.0,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                children: [
                  CircleAvatar(
                    radius: 45.0,
                    backgroundColor: const Color(0xFFE2E8F0),
                    backgroundImage:
                        (data.profilePicture != null &&
                            data.profilePicture!.isNotEmpty)
                        ? NetworkImage(data.profilePicture!)
                        : null,
                    child:
                        (data.profilePicture == null ||
                            data.profilePicture!.isEmpty)
                        ? Text(
                            initialLetter,
                            style: TextStyle(
                              color: textSecondary,
                              fontSize: 28.0,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        : null,
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 3.0,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE6F4EA),
                        borderRadius: BorderRadius.circular(12.0),
                        border: Border.all(color: Colors.white, width: 2.0),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 6.0,
                            height: 6.0,
                            decoration: const BoxDecoration(
                              color: Color(0xFF137333),
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 4.0),
                          const Text(
                            "Available",
                            style: TextStyle(
                              color: Color(0xFF137333),
                              fontSize: 10.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 20.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      finalDisplayName,
                      style: TextStyle(
                        color: textPrimary,
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6.0),
                    Text(
                      data.professionalTitle ?? "Consultant Specialist",
                      style: TextStyle(
                        color: textSecondary,
                        fontSize: 13.0,
                        height: 1.3,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 12.0),
                    Wrap(
                      spacing: 16.0,
                      runSpacing: 8.0,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.mail_outline,
                              size: 16.0,
                              color: textSecondary,
                            ),
                            const SizedBox(width: 6.0),
                            Text(
                              data.user?.email ?? "info@consultant.com",
                              style: TextStyle(
                                color: textSecondary,
                                fontSize: 13.0,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        // Wrap this specific component inside a Flexible to let the outer Wrap layout handle it safely
                        Row(
                          // mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment
                              .start, // Align to top if text breaks into 2 lines
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 2.0,
                              ), // Keeps icon balanced with line-height
                              child: Icon(
                                Icons.location_on_outlined,
                                size: 16.0,
                                color: textSecondary,
                              ),
                            ),
                            const SizedBox(width: 4.0),
                            Flexible(
                              child: Text(
                                data.location ?? "Global Presence",
                                maxLines: 2,
                                overflow: TextOverflow
                                    .ellipsis, // Elegantly clips if it exceeds 2 lines
                                style: TextStyle(
                                  color: textSecondary,
                                  fontSize: 10.0,
                                  fontWeight: FontWeight.w400,
                                  // Clean line spacing for multi-line blocks
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          ElevatedButton(
            onPressed: (data.offersConsultations ?? true) ? () {} : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: tealBrand,
              foregroundColor: Colors.white,
              disabledBackgroundColor: Colors.grey.shade300,
              elevation: 0,
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 14.0,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            child: const Text(
              "One-to-one Counselling",
              style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAboutCard(
    FacultyDetailsModel data,
    Color textPrimary,
    Color textSecondary,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "About",
            style: TextStyle(
              color: textPrimary,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 14.0),
          Text(
            data.about ??
                "No structural description profile has been documented.",
            style: TextStyle(
              color: textSecondary,
              fontSize: 13.5,
              height: 1.6,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAchievementsCard(Color textPrimary, String value) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Achievements",
            style: TextStyle(
              color: textPrimary,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10.0),
          Html(data: value),
        ],
      ),
    );
  }

  Widget _buildEducationCard(
    FacultyDetailsModel data,
    Color textPrimary,
    Color tealBrand,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Education",
            style: TextStyle(
              color: textPrimary,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20.0),
          _buildEducationItemRow(
            tealBrand: tealBrand,
            textPrimary: textPrimary,
            title: data.education ?? "No educational background documented.",
            isBullet: true,
          ),
        ],
      ),
    );
  }

  Widget _buildEducationItemRow({
    required Color tealBrand,
    required Color textPrimary,
    required String title,
    required bool isBullet,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: tealBrand.withOpacity(0.08),
            shape: BoxShape.circle,
          ),
          child: Icon(Icons.school_outlined, size: 18.0, color: tealBrand),
        ),
        const SizedBox(width: 14.0),
        Expanded(
          child: Text(
            isBullet ? "• $title" : title,
            style: TextStyle(
              color: textPrimary,
              fontSize: 14.0,
              fontWeight: isBullet ? FontWeight.bold : FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
