// ignore_for_file: prefer_final_fields, prefer_const_constructors

import 'package:calebshirthum/uitilies/app_images.dart';
import 'package:calebshirthum/view/user/calender_view/event_screen.dart';
import 'package:calebshirthum/view/user/home_view/home_screen_view.dart';
import 'package:calebshirthum/view/user/profile_view/profile_screen_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../uitilies/app_colors.dart';
import '../location_view/location_screen_view.dart';

class DashboardView extends StatefulWidget {
  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<DashboardView> {
  int _selectedIndex = 0;

  List<Widget> _pages = [
    HomeScreenView(),
    MapScreenView(),
    EventScreenView(),
    ProfileView()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _buildImageIcon(
      String selectedAssetPath, String unselectedAssetPath, bool isSelected) {
    return Image.asset(
      isSelected ? selectedAssetPath : unselectedAssetPath,
      width: 23,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _pages[_selectedIndex], // Display the selected page
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.circular(45),
        child: BottomNavigationBar(
          selectedItemColor: AppColors.mainColor,
          unselectedLabelStyle: GoogleFonts.outfit(fontSize: 12.h),
          backgroundColor: Colors.white,
          selectedLabelStyle:
              GoogleFonts.outfit(color: AppColors.mainColor, fontSize: 14.h),
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          iconSize: 22,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: _buildImageIcon(
                AppImages.homeA, // Selected state
                AppImages.home, // Unselected state
                _selectedIndex == 0,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: _buildImageIcon(
                AppImages.locationA, // Selected state
                AppImages.location,
                _selectedIndex == 1,
              ),
              label: 'Map',
            ),
            BottomNavigationBarItem(
              icon: _buildImageIcon(
                AppImages.calenderA, // Selected state
                AppImages.calender,
                _selectedIndex == 2,
              ),
              label: 'Events',
            ),
            BottomNavigationBarItem(
              icon: _buildImageIcon(
                AppImages.profileA, // Selected state
                AppImages.profile,
                _selectedIndex == 3,
              ),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
