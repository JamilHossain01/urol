// ignore_for_file: avoid_print

import 'package:calebshirthum/uitilies/custom_toast.dart';
import 'package:calebshirthum/view/user/profile_view/controller/get_saved_gym_controller.dart';
import 'package:calebshirthum/view/user/profile_view/controller/my_gym_controller.dart';
import 'package:get/get.dart';
import '../../../../uitilies/api/api_url.dart';
import '../../../../uitilies/api/base_client.dart';
import '../model/my_gyms_model.dart';

class DeleteGymImageController extends GetxController {
  var isLoading = false.obs;
  var gums = MyGymsModel().obs;


  final MyGymController _myGymController = Get.put(MyGymController());


  @override
  void onInit() {
    super.onInit();
  }

 Future <void> deleteGymImage(
      {required dynamic gymId, required dynamic imageId}) async {
    try {
      isLoading(true);





      dynamic responseBody = await BaseClient.handleResponse(
        await BaseClient.deleteRequest(
            api: ApiUrl.gymImageDelete,
            body: {"gymId": gymId, "imageId": imageId}),
      );

      if (responseBody['success'] == true) {
        CustomToast.showToast(
          responseBody['message'] ?? "Success",
          isError: false,
        );

        print("fetched: ${gums.value}");


        _myGymController.getMyGyms();

      } else {
        throw 'Failed: ${responseBody['message']}';
      }
    } catch (e) {
      print("Error: $e");
    } finally {
      isLoading(false);
    }
  }
}
