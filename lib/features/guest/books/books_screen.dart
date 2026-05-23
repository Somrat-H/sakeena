import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:sakeena/core/app_theme.dart';
import 'package:sakeena/widgets/book_card.dart';
import 'package:sakeena/widgets/custom_app_bar.dart';
import 'package:sakeena/widgets/filter_section.dart';
import 'dart:async';

class BooksPage extends StatefulWidget {
  const BooksPage({super.key});

  @override
  State<BooksPage> createState() => _BooksPageState();
}

class _BooksPageState extends State<BooksPage> {
  String selectedCategory = 'All';
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;
  String searchQuery = '';

  final categories = ['All', 'Mental Health', 'Spiritual Growth'];

  final books = [
    {
      'title': 'Healing the Anxious Heart',
      'author': 'Dr. Sarah Ahmed',
      'price': '\$99',
      'image': 'assets/images/book_image.png',
      'tag': 'Both',
      'tagColor': Colors.green,
    },
    {
      'title': 'Peace Movements in Islam',
      'author': 'Sheikh Hassan',
      'price': '\$99',
      'image': 'assets/images/book_two.png',
      'tag': 'eBook',
      'tagColor': Colors.blue,
    },
    {
      'title': 'Islamic Counseling Guide',
      'author': 'Dr. Fatima Rahman',
      'price': '\$89',
      'image': 'assets/images/book_three.png',
      'tag': 'Physical',
      'tagColor': Colors.purple,
    },
  ];

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 400), () {
      setState(() {
        searchQuery = query.toLowerCase();
      });
    });
  }


  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filteredBooks = books.where((book) {
    final title = (book['title'] as String).toLowerCase();
    final author = (book['author'] as String).toLowerCase();

    return title.contains(searchQuery) || author.contains(searchQuery);
  }).toList();
  
    return Scaffold(
      appBar: const CustomAppBar(),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            // Header
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () => context.pop(),
                        icon: const Icon(
                          Icons.arrow_back,
                          color: AppTheme.primaryColor,
                        ),
                      ),
                      Text(
                        'Books & Publications',
                        style: TextStyle(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'Discover curated Islamic and psychology books',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),

            // Search Bar
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: TextField(
                controller: _searchController,
                onChanged: _onSearchChanged,
                decoration: InputDecoration(
                  hintText: 'Search books...',
                  prefixIcon: const Icon(Icons.search),
                  contentPadding: EdgeInsets.symmetric(vertical: 12.h),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide(color: AppTheme.primaryColor),
                  ),
                ),
              ),
            ),

            // Filters
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: FilterSection(
         
                items: categories,
                selectedItem: selectedCategory,
                onSelected: (value) => setState(() => selectedCategory = value),
                isHorizontal: true,
              ),
            ),

            SizedBox(height: 24.h),

            // Books List
            ...filteredBooks.asMap().entries.map((entry) {
              int index = entry.key;
              Map book = entry.value;

              return Padding(
                padding: EdgeInsets.only(
                  bottom: index == books.length - 1 ? 0 : 16.h,
                ),
                child: _CenteredBookCard(
                  child: BookCard(
                    title: book['title'] as String,
                    author: book['author'] as String,
                    price: book['price'] as String,
                    imagePath: book['image'] as String,
                    tagText: book['tag'] as String,
                    tagColor: book['tagColor'] as Color,
                  ),
                ),
              );
            }).toList(),

            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}

// ------------------ Centered Book Card ------------------

class _CenteredBookCard extends StatelessWidget {
  final Widget child;

  const _CenteredBookCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(width: 0.95.sw, child: child),
    );
  }
}
