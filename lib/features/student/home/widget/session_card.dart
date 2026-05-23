import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SessionConsultationCard extends StatelessWidget {
  final String teacherName;
  final String dateTimeText;
  final String consultationType;
  final String? avatarUrl;
  final VoidCallback onReschedule;
  final VoidCallback onJoinSession;

  const SessionConsultationCard({
    super.key,
    required this.teacherName,
    required this.dateTimeText,
    required this.consultationType,
    this.avatarUrl,
    required this.onReschedule,
    required this.onJoinSession,
  });

  // Matching your primary teal tone from the screens
  final Color primaryTeal = const Color(0xFF2C7A7B); 

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          // If the screen width is narrow (mobile breakdown), stack vertically
          bool isMobile = constraints.maxWidth < 550;

          return isMobile 
              ? _buildVerticalLayout() 
              : _buildHorizontalLayout();
        },
      ),
    );
  }

  // Desktop/Tablet Responsive Horizontal View
  Widget _buildHorizontalLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildAvatar(),
        SizedBox(width: 14.w),
        Expanded(
          child: _buildDetailsSection(),
        ),
        SizedBox(width: 16.w),
        _buildActionButtons(),
      ],
    );
  }

  // Native Mobile Compact Stacked View
  Widget _buildVerticalLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            _buildAvatar(),
            SizedBox(width: 12.w),
            Expanded(child: _buildDetailsSection()),
          ],
        ),
        Divider(height: 24.h, color: Colors.grey.shade100),
        SizedBox(
          width: double.infinity,
          child: _buildActionButtons(isFullWidth: true),
        ),
      ],
    );
  }

  // --- UI Subcomponents ---

  Widget _buildAvatar() {
    return CircleAvatar(
      radius: 26.r,
      backgroundColor: primaryTeal.withOpacity(0.1),
      backgroundImage: avatarUrl != null ? NetworkImage(avatarUrl!) : null,
      child: avatarUrl == null
          ? Text(
              teacherName.isNotEmpty ? teacherName[0].toUpperCase() : 'T',
              style: TextStyle(
                color: primaryTeal,
                fontWeight: FontWeight.bold,
                fontSize: 18.sp,
              ),
            )
          : null,
    );
  }

  Widget _buildDetailsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          teacherName,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontFamily: 'Arimo',
          ),
        ),
        SizedBox(height: 6.h),
        Row(
          children: [
            Icon(Icons.calendar_today_outlined, size: 14.sp, color: Colors.grey.shade600),
            SizedBox(width: 6.w),
            Expanded(
              child: Text(
                dateTimeText,
                style: TextStyle(
                  fontSize: 13.sp,
                  color: Colors.grey.shade600,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
          decoration: BoxDecoration(
            color: const Color(0xE0E0F2F1), // Soft tint accent
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Text(
            consultationType,
            style: TextStyle(
              fontSize: 11.sp,
              fontWeight: FontWeight.w600,
              color: primaryTeal,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons({bool isFullWidth = false}) {
    final buttons = [
      OutlinedButton(
        onPressed: onReschedule,
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: primaryTeal),
          shape: const StadiumBorder(),
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        ),
        child: Text(
          "Re Schedule",
          style: TextStyle(color: primaryTeal, fontSize: 13.sp, fontWeight: FontWeight.w600),
        ),
      ),
      if (!isFullWidth) SizedBox(width: 10.w) else SizedBox(height: 8.h),
      ElevatedButton(
        onPressed: onJoinSession,
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryTeal,
          elevation: 0,
          shape: const StadiumBorder(),
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 10.h),
        ),
        child: Text(
          "Join Session",
          style: TextStyle(color: Colors.white, fontSize: 13.sp, fontWeight: FontWeight.w600),
        ),
      ),
    ];

    return isFullWidth 
        ? Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: buttons)
        : Row(mainAxisSize: MainAxisSize.min, children: buttons);
  }
}