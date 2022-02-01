import 'package:get/get.dart';
import 'package:salary_app/src/salaries/models/worker.dart';
import 'package:salary_app/src/services/firestore_service.dart';

class EmployeeEditorController extends GetxController {
  final _employees = <Employee>[].obs;
  List<Employee> get employees => _employees.value;

  final _name = "".obs;
  String get name => _name.value;
  set name(String val) => _name.value = val;

  @override
  Future<void> onInit() async {
    _employees.value = await FirestoreService().getEmployees();
    super.onInit();
  }

  Future<void> addEmployee() async {
    await FirestoreService().addEmployee(_name.value);
    _employees.value = await FirestoreService().getEmployees();
    Get.back();
  }

  Future<void> removeEmployee(Employee e) async {
    await FirestoreService().removeEmployee(e);
    _employees.removeWhere((element) => element.id == e.id);
  }
}
