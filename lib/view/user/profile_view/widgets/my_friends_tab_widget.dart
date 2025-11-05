import 'package:calebshirthum/common%20widget/not_found_widget.dart';
import 'package:calebshirthum/view/user/profile_view/controller/get_my_friends_controller.dart';
import 'package:calebshirthum/view/user/profile_view/widgets/friends_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../uitilies/custom_loader.dart';
import '../find_friend_profile_view.dart';

class MyFriendsTabWidget extends StatefulWidget {
  const MyFriendsTabWidget({super.key});

  @override
  State<MyFriendsTabWidget> createState() => _MyFriendsTabWidgetState();
}

class _MyFriendsTabWidgetState extends State<MyFriendsTabWidget> {
  final GetMyFriendsController _getMyFriendsController =
      Get.put(GetMyFriendsController());

  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getMyFriendsController.getFriends("");
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// 🔍 Search field
        Padding(
          padding: EdgeInsets.all(16.w),
          child: TextField(
            controller: _searchController,
            onChanged: (value) {
              _getMyFriendsController.getFriends(value);
            },
            decoration: InputDecoration(
              hintText: 'Search friends...',
              hintStyle: TextStyle(fontSize: 14.sp, color: Colors.grey[600]),
              prefixIcon:
                  Icon(Icons.search, color: Colors.grey[600], size: 20.sp),
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

        /// 👥 Friends list
        Expanded(
          child: Obx(() {
            if (_getMyFriendsController.isLoading.value) {
              return CustomLoader();
            }

            final friends = _getMyFriendsController.friend.value.data ?? [];

            if (friends.isEmpty) {
              return Center(
                child: NotFoundWidget(
                  message: "No friends found",
                  imagePath: "assets/images/not_found.png",
                ),
              );
            }

            return ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              itemCount: friends.length,
              separatorBuilder: (context, index) => SizedBox(height: 12.h),
              itemBuilder: (context, index) {
                final friendData = friends[index].friend;
                if (friendData == null) return const SizedBox.shrink();

                return FriendsCardWidget(
                  name:
                      "${friendData.firstName ?? 'N/A'} ${friendData.lastName ?? ''}",
                  gym: friendData.homeGym ?? 'N/A',
                  imageUrl: friendData.image ??
                      'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_640.png',
                  disciplines: friendData.disciplines,
                  onViewTap: () {
                    Get.to(() => FindProfileView(
                          firstName: friendData.firstName ?? "N/A",
                          lastName: friendData.lastName ?? "",
                          quote: friendData.favouriteQuote ??
                              "Quote not available",
                          gymName:
                              friendData.homeGym ?? "Home Gym not available",
                          imageUrl: friendData.image?.isNotEmpty == true
                              ? friendData.image!
                              : "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_640.png",
                          beltRank: friendData.beltRank ?? "N/A",
                          disciplines: friendData.disciplines ?? [],
                          height:
                              friendData.height?.amount?.toString() ?? "N/A",
                          weight: friendData.weight?.toString() ?? "N/A",
                          eventDate:
                              friendData.competition?.eventDate?.toString(),
                          eventLocation: friendData.competition == null
                              ? null
                              : "${friendData.competition?.city ?? 'N/A'}, ${friendData.competition?.state ?? 'N/A'}",
                          eventDivision: friendData.competition?.division,
                          eventBadge: friendData.competition?.result,
                          eventName: friendData.competition?.eventName,
                          eventStatus: friendData.competition,
                          statusOfFollow: false,
                          friendId: friendData.id.toString(),
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
