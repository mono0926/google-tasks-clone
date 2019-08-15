import 'package:google_tasks/model/firestore/firestore.dart';

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
