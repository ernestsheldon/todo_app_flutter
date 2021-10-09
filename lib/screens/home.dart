import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
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
  final TextEditingController _taskController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TodoController>(
      init: TodoController(),
      initState: (_) {},
      builder: (todoController) {
        todoController.getData();

        return Scaffold(
          body: Center(
            child: todoController.isLoading
                ? const SizedBox(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    itemCount: todoController.taskList.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Checkbox(
                            onChanged: (value) => todoController.addTodo(
                                todoController.taskList[index].task,
                                !todoController.taskList[index].isDone,
                                todoController.taskList[index].id),
                            value: todoController.taskList[index].isDone),
                        title: Text(todoController.taskList[index].task),
                        trailing: SizedBox(
                          width: 100,
                          child: Row(
                            children: [
                              IconButton(
                                onPressed: () => addTaskDialog(
                                    todoController,
                                    'Update Task',
                                    todoController.taskList[index].id,
                                    todoController.taskList[index].task),
                                icon: const Icon(Icons.edit),
                              ),
                              IconButton(
                                onPressed: () => todoController.deleteTask(
                                    todoController.taskList[index].id),
                                icon: const Icon(Icons.delete),
                                color: Colors.red,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () async =>
                await addTaskDialog(todoController, 'Add Todo', '', ''),
          ),
        );
      },
    );
  }

  addTaskDialog(TodoController todoController, String title, String id,
      String task) async {
    if (task.isNotEmpty) {
      _taskController.text = task;
    }

    Get.defaultDialog(
      title: title,
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
              onPressed: () async {
                await todoController.addTodo(
                    _taskController.text.trim(), false, id);

                _taskController.clear();
                Get.back();
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
