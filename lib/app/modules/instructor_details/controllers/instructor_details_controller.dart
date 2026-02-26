import 'package:george/app/utils/app_log.dart';
import 'package:george/models/instructor_data.dart';
import 'package:george/repository/instructor_repository.dart';
import 'package:get/get.dart';

class InstructorDetailsController extends GetxController {
  final InstructorRepository _instructorRepository =
      InstructorRepository.instance;

  final RxBool isLoading = false.obs;

  final Rxn<InstructorModel> instructorDeatils = Rxn<InstructorModel>();

  var arg = Get.arguments;

  @override
  void onInit() {
    super.onInit();
    fetchInstructor(arg);
  }

  Future<void> fetchInstructor(String id) async {
    try {
      isLoading.value = true;

      final result = await _instructorRepository.fetchInstructorModel(id: id);

      instructorDeatils.value = result;
    } catch (e) {
      errorLog("Fetch Instructor", e);
    } finally {
      isLoading.value = false;
    }
  }
}
