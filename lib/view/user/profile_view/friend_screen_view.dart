import 'package:cached_network_image/cached_network_image.dart';
import 'package:calebshirthum/view/user/profile_view/find_friend_profile_view.dart';
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

  final List<Map<String, dynamic>> discoverUsers = [
    {
      'name': 'Caleb Shirthum',
      'gym': 'Knockout Club',
      'disciplines': ['Jiu Jitsu', 'Wrestling'],
      'imageUrl':
      'https://images.unsplash.com/photo-1552053831-71594a27632d?ixlib=rb-4.0.3&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=400&fit=max',
      'isFollowing': false,
    },
    {
      'name': 'Kristin Watson',
      'gym': 'Knockout Club',
      'disciplines': ['Jiu Jitsu', 'Wrestling'],
      'imageUrl':
      'https://images.unsplash.com/photo-1544718045-84e628b0ff82?ixlib=rb-4.0.3&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=400&fit=max',
      'isFollowing': false,
    },
    {
      'name': 'Brooklyn Sims',
      'gym': 'Knockout Club',
      'disciplines': ['Jiu Jitsu', 'Wrestling'],
      'imageUrl':
      'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?ixlib=rb-4.0.3&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=400&fit=max',
      'isFollowing': false,
    },
    {
      'name': 'Courtney Henry',
      'gym': 'Knockout Club',
      'disciplines': ['Jiu Jitsu', 'Wrestling'],
      'imageUrl':
      'https://images.unsplash.com/photo-1559839734-2b71ea197ec2?ixlib=rb-4.0.3&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=400&fit=max',
      'isFollowing': false,
    },
    {
      'name': 'Savannah Nguyen',
      'gym': 'Knockout Club',
      'disciplines': ['Jiu Jitsu', 'Wrestling'],
      'imageUrl':
      'https://images.unsplash.com/photo-1508187613440-360d3b14d4b8?ixlib=rb-4.0.3&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=400&fit=max',
      'isFollowing': false,
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
          _buildMyFriendsTab(),
          _buildDiscoverTab(),
        ],
      ),
    );
  }

  Widget _buildMyFriendsTab() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(16.w),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search users...',
              hintStyle: TextStyle(
                fontSize: 14.sp,
                color: Colors.grey[600],
              ),
              prefixIcon: Icon(
                Icons.search,
                color: Colors.grey[600],
                size: 20.sp,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.grey[100],
              contentPadding:
              EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
            ),
          ),
        ),
        Expanded(
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            itemCount: friends.length,
            separatorBuilder: (context, index) => SizedBox(height: 12.h),
            itemBuilder: (context, index) {
              final friend = friends[index];
              return _buildFriendCard(friend);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildDiscoverTab() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(16.w),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search users...',
              hintStyle: TextStyle(
                fontSize: 14.sp,
                color: Colors.grey[600],
              ),
              prefixIcon: Icon(
                Icons.search,
                color: Colors.grey[600],
                size: 20.sp,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.grey[100],
              contentPadding:
              EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
            ),
          ),
        ),
        Expanded(
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            itemCount: discoverUsers.length,
            separatorBuilder: (context, index) => SizedBox(height: 12.h),
            itemBuilder: (context, index) {
              final user = discoverUsers[index];
              return _buildDiscoverCard(user);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildFriendCard(Map<String, dynamic> friend) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(40.r),
                child: CachedNetworkImage(
                  imageUrl: friend['imageUrl'],
                  width: 60.w,
                  height: 60.h,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    width: 60.w,
                    height: 60.h,
                    color: Colors.grey[200],
                    child: const Icon(Icons.person, color: Colors.grey),
                  ),
                  errorWidget: (context, url, error) => Container(
                    width: 60.w,
                    height: 60.h,
                    color: Colors.grey[200],
                    child: const Icon(Icons.person, color: Colors.grey),
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: friend['name'],
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                    SizedBox(height: 4.h),
                    CustomText(
                      text: friend['gym'],
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey,
                    ),
                    SizedBox(height: 8.h),
                    Wrap(
                      spacing: 6.w,
                      runSpacing: 4.h,
                      children:
                      (friend['disciplines'] as List).map((discipline) {
                        return Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 8.w, vertical: 4.h),
                          decoration: BoxDecoration(
                            color: AppColors.mainColor,
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: CustomText(
                            text: discipline,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 4.h),
          SizedBox(
            width: double.infinity,
            child: TextButton(
              onPressed: () {
                Get.to(() => FindProfileView(follow: 'Unfollow'));
              },
              style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                side: BorderSide(color: AppColors.mainColor),
              ),
              child: CustomText(
                text: 'View',
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.mainColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDiscoverCard(Map<String, dynamic> user) {
    final isFollowing = user['isFollowing'] as bool;
    final followColor = isFollowing ? Colors.red : Colors.green;
    final followText = isFollowing ? 'Following' : 'Follow';

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(40.r),
                child: CachedNetworkImage(
                  imageUrl: user['imageUrl'],
                  width: 60.w,
                  height: 60.h,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    width: 60.w,
                    height: 60.h,
                    color: Colors.grey[200],
                    child: const Icon(Icons.person, color: Colors.grey),
                  ),
                  errorWidget: (context, url, error) => Container(
                    width: 60.w,
                    height: 60.h,
                    color: Colors.grey[200],
                    child: const Icon(Icons.person, color: Colors.grey),
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: user['name'],
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                    SizedBox(height: 4.h),
                    CustomText(
                      text: user['gym'],
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey,
                    ),
                    SizedBox(height: 8.h),
                    Wrap(
                      spacing: 6.w,
                      runSpacing: 4.h,
                      children:
                      (user['disciplines'] as List).map((discipline) {
                        return Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 8.w, vertical: 4.h),
                          decoration: BoxDecoration(
                            color: AppColors.mainColor,
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: CustomText(
                            text: discipline,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  SizedBox(
                    width: 64.w,
                    height: 30.h,
                    child: TextButton(
                      onPressed: () {
                        Get.to(() => FindProfileView(follow: "Follow"));
                      },
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        side: BorderSide(color: AppColors.mainColor),
                      ),
                      child: CustomText(
                        text: 'View',
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.mainColor,
                      ),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  SizedBox(
                    width: 64.w,
                    height: 30.h,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          user['isFollowing'] = !isFollowing;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: followColor,
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Center(
                          child: CustomText(
                            text: followText,
                            fontSize: 14.sp,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
