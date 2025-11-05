import 'package:cached_network_image/cached_network_image.dart';
import 'package:calebshirthum/common%20widget/not_found_widget.dart';
import 'package:calebshirthum/uitilies/custom_loader.dart';
import 'package:calebshirthum/view/user/profile_view/controller/add_friend_controller.dart';
import 'package:calebshirthum/view/user/profile_view/controller/discover_friends_controller.dart';
import 'package:calebshirthum/view/user/profile_view/widgets/discover_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../uitilies/app_colors.dart';
import '../find_friend_profile_view.dart';

class DiscoverFriendsWidget extends StatefulWidget {
  const DiscoverFriendsWidget({super.key});

  @override
  State<DiscoverFriendsWidget> createState() => _DiscoverFriendsWidgetState();
}

class _DiscoverFriendsWidgetState extends State<DiscoverFriendsWidget> {
  final DiscoverFriendsController _discoverFriendsController =
      Get.put(DiscoverFriendsController());

  final TextEditingController _searchController = TextEditingController();

  final AddFriendController _addFriendController =
      Get.put(AddFriendController());

  @override
  void initState() {
    super.initState();
    _discoverFriendsController.getDiscover("");
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// 🔍 Search Field
        Padding(
          padding: EdgeInsets.all(16.w),
          child: TextField(
            controller: _searchController,
            onChanged: (value) {
              _discoverFriendsController.getDiscover(value);
            },
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

        /// 👥 Friend List
        Expanded(
          child: Obx(() {
            if (_discoverFriendsController.isLoading.value) {
              return CustomLoader();
            }

            final friends =
                _discoverFriendsController.friend.value.data?.data ?? [];

            if (friends.isEmpty) {
              return Center(
                  child: NotFoundWidget(
                message: "No users found",
                imagePath: "assets/images/not_found.png",
              ));
            }

            return ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              itemCount: friends.length,
              separatorBuilder: (context, index) => SizedBox(height: 12.h),
              itemBuilder: (context, index) {
                final user = friends[index];
                return DiscoverCardWidget(
                  name: "${user.firstName ?? ''} ${user.lastName ?? ''}",
                  gym: user.homeGym ?? 'N/A',
                  imageUrl: user.image ?? "",
                  disciplines: user.disciplines,
                  followText: "Follow",
                  followColor: AppColors.mainColor,
                  onFollowTap: () {
                    print("Follow ${user.firstName}");

                    _addFriendController.addFriend(id: user.id.toString());
                  },
                  viewTap: () {
                    final user = friends[index];

                    Get.to(() => FindProfileView(
                          firstName: user.firstName ?? "N/A",
                          lastName: user.lastName ?? "",
                          quote: user.favouriteQuote ?? "Quote not available",
                          gymName: user.homeGym ?? "Home Gym not available",
                          imageUrl: user.image?.isNotEmpty == true
                              ? user.image!
                              : "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_640.png",
                          beltRank: user.beltRank ?? "N/A",
                          disciplines: user.disciplines ?? [],
                          height: user.height?.amount?.toString() ?? "N/A",
                          weight: user.weight?.toString() ?? "N/A",
                          eventDate: user.competition?.eventDate?.toString(),
                          eventLocation: user.competition == null
                              ? null
                              : "${user.competition?.city ?? 'N/A'}, ${user.competition?.state ?? 'N/A'}",
                          eventDivision: user.competition?.division,
                          eventBadge: user.competition?.result,
                          eventName: user.competition?.eventName,
                          eventStatus: user
                              .competition, statusOfFollow: true, friendId: user.id.toString(),
                        ));
                  },
                );
              },
            );
          }),
        ),
      ],
    );
  }
}
