import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_tasks/model/entity/entity.dart';
import 'package:google_tasks/model/firestore/firestore.dart';
import 'package:meta/meta.dart';

import 'user.dart';
import 'user_doc.dart';

class UserRef extends DocumentRef<User, UserDoc> {
  UserRef({
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
