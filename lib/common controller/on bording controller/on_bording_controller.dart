// import 'package:get/get.dart';
//
// import '../../uitilies/app_images.dart';
// import '../../uitilies/app_string.dart';
//
// class OnBoardingController extends GetxController {
//   var currentStep = 0.obs;
//
//   final List<String> images = [
//     AppImages.onboardOne,
//     AppImages.onboardTwo,
//   ];
//
//   final List<String> subtitles = [
//     AppImages.onboardSubTitle,
//     AppString.splashTextOne,
//   ];
//
//   final List<String> contentText = [
//     "",
//     "Unlock exclusive restaurant discounts now. Enjoy dining deals and instant savings today!"
//   ];
//
//   void nextStep() {
//     if (currentStep < images.length - 1) {
//       currentStep++;
//     } else {
//     }
//   }
//
//   void previousStep() {
//     if (currentStep > 0) {
//       currentStep--;
//     }
//   }
//
//   String get currentImage => images[currentStep.value];
//   dynamic get currentSubtitle => subtitles[currentStep.value];
//   String get text => contentText[currentStep.value];
// }
