import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common widget/custom text/custom_text_widget.dart';
import '../../../../common widget/custom_app_bar_widget.dart';
import '../../../../uitilies/app_colors.dart';



class PrivacyPolicyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: CustomAppBar(title: 'Privacy Policy'),

      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              maxLines: 100,
              textAlign: TextAlign.start,
              text: "Facilisis lorem vulputate sed quis a vel. Egestas proin cursus ipsum enim felis. Tincidunt neque ultrices nullam enim aenean. Eu cum ut faucibus fames volutpat. Et euismod velit integer odio ut nulla aenean morbi aliquet. Odio purus aliquet augue dis mollis ultrices interdum. Quis ligula nunc donec aliquam. Leo eu augue aenean diam accumsan nunc maecenas. Mauris accumsan id quis quis nisl. Lorem donec quam enim dolor eget faucibus arcu. Amet sem quis in nisi amet. Fermentum tempor sit cursus maecenas tempus sed mauris laoreet. Odio quam feugiat risus aliquet a. Fringilla platea elit dapibus orci non mi nibh.Nulla scelerisque ornare in sit elit. Vitae luctus adipiscing blandit pharetra. Quis et auctor faucibus donec eget sit nisl non magna. Risus in aliquam eget tortor euismod interdum turpis penatibus cras. Metus dui turpis sollicitudin eu scelerisque sollicitudin. Amet venenatis pretium adipiscing consequat eget. Magna ut congue sed non ornare. Faucibus nullam pretium feugiat in accumsan nisl cras sed tempor. Senectus sed ut arcu sed pretium metus. Turpis in dui tortor risus sed. Turpis feugiat est sit metus pharetra. Ut risus amet diam in phasellus auctor iaculis. Vitae commodo nisl praesent elementum mauris pellentesque cras praesent duis. Tempor fermentum consequat donec viverra massa scelerisque. Sit in nulla nisl felis ut a nascetur ac.",
              color: AppColors.mainTextColors,
              fontWeight: FontWeight.w500,
              fontSize: 12.sp,
            ),
          ],
        ),
      ),
    );
  }
}