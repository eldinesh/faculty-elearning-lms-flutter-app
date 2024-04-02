import 'package:get/get.dart';
import 'package:lms_user_app/data/model/resource/resource_model.dart';
import 'package:lms_user_app/repository/resource_repository.dart';

class ResourceController extends GetxController implements GetxService {
  bool isResourceListLoading = false;

  List<Resources> _resourceList = [];
  List<Resources> get assignmentList => _resourceList;
  

  Future<void> getResourceList(String courseID) async {
    _resourceList = [];
    isResourceListLoading = true;
    update();
    final response = await ResourceRepository(Get.find()).getResourceList(courseID);
    if (response != null && response.statusCode == 200) {
      if (response.body['success'] == true) {
        List<Resources> list = ResourcesModel.fromJson(response.body).data!.resources!;
        _resourceList.addAll(list);
        isResourceListLoading = false;
      }else{
        isResourceListLoading = false;
      }
    }
    update();
  }
  
}
