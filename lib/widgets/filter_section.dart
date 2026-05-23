import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FilterSection extends StatelessWidget {
  
  final List<String> items;
  final String selectedItem;
  final Function(String) onSelected;
  final bool isHorizontal;

  const FilterSection({
    super.key,
 
    required this.items,
    required this.selectedItem,
    required this.onSelected,
    this.isHorizontal = false,
  });

  @override
  Widget build(BuildContext context) {
    const teal = Color(0xFF2C7A7B);

    final buttons = items.map((item) {
      final isSelected = selectedItem == item;
      return Padding(
        padding: EdgeInsets.only(right: 8.w),
        child: GestureDetector(
          onTap: () => onSelected(item),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: isSelected ? teal : Colors.white,
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(
                color: isSelected ? teal : Colors.grey.shade400,
              ),
            ),
            child: Center(
              child: Text(
                item,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black87,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
      );
    }).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
       
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(children: buttons),
        ),
      ],
    );
  }
}
