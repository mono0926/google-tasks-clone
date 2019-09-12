import 'package:google_tasks/model/model.dart';

import 'task.dart';

class TaskDoc extends Document<Task> {
  const TaskDoc(
    String id,
    Task entity,
  ) : super(
          id,
          entity,
        );
}
