import 'package:firestore_ref/firestore_ref.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_tasks/model/entity/entity.dart';
import 'package:json_annotation/json_annotation.dart';

import 'user_doc.dart';

export 'user_doc.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
abstract class User with _$User {
  const factory User({
    @required String name,
    @required String imageUrl,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}

class UserField {
  static const name = 'name';
  static const imageUrl = 'imageUrl';
}

class UserRef extends DocumentRef<User, UserDoc> {
  UserRef({
    @required String id,
    @required UsersRef usersRef,
  }) : super(
          id: id,
          collectionRef: usersRef,
        );

  TasksRef get tasksRef => TasksRef.ref(this);
}

class UsersRef extends CollectionRef<User, UserDoc> {
  UsersRef._({
    @required CollectionReference ref,
  }) : super(
          ref,
          decoder: (snapshot) => UserDoc(
            snapshot.documentID,
            User.fromJson(snapshot.data),
          ),
          encoder: (user) => user.toJson(),
        );

  factory UsersRef.ref() {
    return UsersRef._(
      ref: Firestore.instance.collection(collection),
    );
  }

  static const collection = 'users';

  @override
  UserRef docRef([String id]) {
    return UserRef(
      id: id,
      usersRef: this,
    );
  }
}
