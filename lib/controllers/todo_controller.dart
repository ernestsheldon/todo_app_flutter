import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class TodoController extends GetxController {
  Future<void> addTodo(String task, bool done) async {
    await FirebaseFirestore.instance.collection('todos').doc().set(
      {
        'task': task,
        'isDone': done,
      },
      SetOptions(merge: true),
    ).then(
      (value) => Get.back(),
    );
  }
}
