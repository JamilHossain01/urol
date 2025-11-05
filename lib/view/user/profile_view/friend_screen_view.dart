import 'package:cached_network_image/cached_network_image.dart';
import 'package:calebshirthum/view/user/profile_view/find_friend_profile_view.dart';
import 'package:calebshirthum/view/user/profile_view/widgets/discover_friends_widget.dart';
import 'package:calebshirthum/view/user/profile_view/widgets/my_friends_tab_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../uitilies/app_colors.dart';
import '../../../common widget/custom text/custom_text_widget.dart';
import '../../../common widget/custom_app_bar_widget.dart';

class FriendsScreen extends StatefulWidget {
  const FriendsScreen({super.key});

  @override
  State<FriendsScreen> createState() => _FriendsScreenState();
}

class _FriendsScreenState extends State<FriendsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Map<String, dynamic>> friends = [
    {
      'name': 'Caleb Shirthum',
      'gym': 'The Arena Combat Academy',
      'disciplines': ['Jiu Jitsu', 'Wrestling'],
      'imageUrl':
          'https://images.unsplash.com/photo-1552053831-71594a27632d?ixlib=rb-4.0.3&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=400&fit=max',
    },
    {
      'name': 'Sarah Martinez',
      'gym': 'Elite Combat Training',
      'disciplines': ['Jiu Jitsu', 'Wrestling', 'Judo'],
      'imageUrl':
          'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?ixlib=rb-4.0.3&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=400&fit=max',
    },
    {
      'name': 'Marcus Johnson',
      'gym': 'Iron Fist Gym',
      'disciplines': ['Jiu Jitsu', 'MMA', 'Wrestling'],
      'imageUrl':
          'https://images.unsplash.com/photo-1530268729831-4f9721fa1d75?ixlib=rb-4.0.3&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=400&fit=max',
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: CustomText(
          text: 'Friends',
          fontSize: 20.sp,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppColors.mainColor,
          unselectedLabelColor: Colors.grey,
          indicatorColor: AppColors.mainColor,
          indicatorWeight: 2,
          tabs: const [
            Tab(
              icon: Icon(Icons.people, size: 20),
              text: 'My Friends',
            ),
            Tab(
              icon: Icon(Icons.search, size: 20),
              text: 'Discover',
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          MyFriendsTabWidget(),
          DiscoverFriendsWidget(),
        ],
      ),
    );
  }
}
