import 'package:flutter/material.dart';
import 'package:google_tasks/model/entity/entity.dart';
import 'package:google_tasks/model/model.dart';
import 'package:google_tasks/pages/tasks_page/task_detail_page/task_detail_page.dart';
import 'package:google_tasks/widgets/widgets.dart';
import 'package:provider/provider.dart';

import 'task_model.dart';

class TaskTile extends StatelessWidget {
  const TaskTile._({Key key}) : super(key: key);

  static Widget withDependencies(TaskDoc doc) {
    return ChangeNotifierProvider<TaskModel>(
      key: ValueKey(doc.id),
      create: (context) => TaskModel(
        doc: doc,
        service: Provider.of(context, listen: false),
      ),
      child: const TaskTile._(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<TaskModel>(context);
    final doc = model.doc;
    final task = doc.entity;
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).dividerColor,
            width: 1 / MediaQuery.of(context).devicePixelRatio,
          ),
        ),
      ),
      child: InkWell(
        onTap: () {
          Navigator.of(context)
              .pushNamed(TaskDetailPage.routeName, arguments: model);
        },
        child: Row(
          children: [
            IconButton(
              icon: Icon(Icons.radio_button_unchecked),
              onPressed: () {},
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(task.title),
                  if ((task.details ?? '').isNotEmpty) ...[
                    const SizedBox(height: 2),
                    Text(
                      task.details,
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ],
                  if (task.due != null)
                    DueButton(
                      due: task.due,
                      onPressed: () {},
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
