import 'package:flutter/material.dart';
import 'package:google_tasks/pages/tasks_page/task_tile/task_model.dart';
import 'package:provider/provider.dart';

class TaskDetailPage extends StatelessWidget {
  const TaskDetailPage._({Key key}) : super(key: key);

  static Widget withDependencies(Object arguments) {
    final model = convertToModelFromArguments(arguments);
    return ChangeNotifierProvider.value(
      value: model,
      child: const TaskDetailPage._(),
    );
  }

  static TaskModel convertToModelFromArguments(Object arguments) {
    return arguments as TaskModel;
  }

  static const routeName = 'Tasks/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.delete_outline),
            onPressed: () async {
              final model = Provider.of<TaskModel>(context, listen: false);
              Navigator.of(context).pop();
              await Future<void>.delayed(const Duration(milliseconds: 500));
              model.delete();
            },
          )
        ],
      ),
      body: ListView(
        children: [
          TextField(
            controller: TextEditingController(
                text: Provider.of<TaskModel>(context).doc.entity.title),
          ),
        ],
      ),
    );
  }
}
