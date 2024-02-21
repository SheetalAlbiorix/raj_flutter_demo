import 'package:demo/Model/UserModel.dart';
import 'package:demo/service/ApiService.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  var isloading = true.obs;
  var userList = <Data>[].obs;

  fetchUser() async {
    try {
      isloading(true);
      var userdata = await ApiService().getUser();
      userList.value = userdata?.data ?? List.empty();
      print(userList);
    } catch (e) {
      print(e);
    } finally {
      isloading(false); // Set loading to false after fetching data
    }
  }
}
