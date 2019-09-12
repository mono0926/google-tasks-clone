import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_tasks/model/entity/entity.dart';
import 'package:google_tasks/model/model.dart';
import 'package:meta/meta.dart';

import 'user.dart';
import 'user_doc.dart';

class UserRef extends DocumentRef<User, UserDoc> {
  const UserRef({
    @required DocumentReference ref,
    @required DocumentDecoder<UserDoc> decoder,
    @required EntityEncoder<User> encoder,
  }) : super(
          ref: ref,
          decoder: decoder,
          encoder: encoder,
        );

  TasksRef get tasksRef => TasksRef.ref(this);
}
