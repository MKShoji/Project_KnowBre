import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

void showAlert(String massage) {
  Get.snackbar("Erro", massage);
}

String generateId() {
  return Uuid().v1();
}
