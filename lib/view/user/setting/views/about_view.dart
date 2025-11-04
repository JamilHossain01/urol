import 'package:calebshirthum/common%20widget/html_view.dart';
import 'package:calebshirthum/uitilies/custom_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../common widget/custom_app_bar_widget.dart';
import '../../../../common widget/not_found_widget.dart';
import '../controllers/settings_meta_controller.dart';

class AboutUsView extends StatefulWidget {
  const AboutUsView({super.key});

  @override
  State<AboutUsView> createState() => _AboutUsViewState();
}

class _AboutUsViewState extends State<AboutUsView> {
  final SettingsMetaDataController _settingsMetaDataController =
      Get.put(SettingsMetaDataController());

  @override
  void initState() {
    super.initState();
    _settingsMetaDataController.getTerms(meta: "about");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: 'About Us'),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Obx(() {
          if (_settingsMetaDataController.isLoading.value) {
            return CustomLoader();
          }

          final htmlData =
              _settingsMetaDataController.profile.value.data?.value;

          if (htmlData == null || htmlData.toString().trim().isEmpty) {
            return Center(
                child: NotFoundWidget(
              imagePath: "assets/images/not_found.png",
              message: "No data found",
            ));
          }

          return HTMLView(htmlData: htmlData.toString());
        }),
      ),
    );
  }
}
