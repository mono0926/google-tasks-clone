import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_tasks/model/firestore/firestore.dart';
import 'package:meta/meta.dart';

import 'task.dart';
import 'task_doc.dart';

class TaskRef extends DocumentRef<Task, TaskDoc> {
  TaskRef({
    @required DocumentReference ref,
    @required DocumentDecoder<TaskDoc> decoder,
    @required EntityEncoder<Task> encoder,
  }) : super(
          ref: ref,
          decoder: decoder,
          encoder: encoder,
        );
}