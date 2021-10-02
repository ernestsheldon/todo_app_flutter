import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:todo_app/controllers/todo_controller.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _taskController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final todoController = Get.find<TodoController>();

    return Scaffold(
      body: const Center(
        child: Text('Home'),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => Get.defaultDialog(
          title: 'Add Todo',
          content: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _taskController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Cannot be empty';
                    }
                    return null;
                  },
                ),
                ElevatedButton(
                  onPressed: () async => await todoController.addTodo(
                      _taskController.text.trim(), false),
                  child: const Text('Save'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
