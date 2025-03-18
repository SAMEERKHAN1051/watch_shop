import 'package:get/get.dart';
import 'package:watch_hub/constant/color_constant.dart';

class AllSnackbar {
  static void errorSnackbar(String message) {
    Get.snackbar(
      "Error",
      message,
      backgroundColor: ColorConstant.errorColor,
      colorText: ColorConstant.mainTextColor,
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  static void successSnackbar(String message) {
    Get.snackbar(
      "Success",
      message,
      backgroundColor: ColorConstant.successColor,
      colorText: ColorConstant.mainTextColor,
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
