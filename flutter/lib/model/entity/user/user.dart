import 'package:flutter/foundation.dart';
import 'package:google_tasks/model/model.dart';

export 'user_doc.dart';
export 'users_ref.dart';

class User extends Entity {
  const User({
    @required this.name,
    @required this.imageUrl,
  });

  User.fromJson(Map<String, dynamic> json)
      : this(
          name: json[UserField.name] as String,
          imageUrl: json[UserField.imageUrl] as String,
        );

  final String name;
  final String imageUrl;

  Map<String, dynamic> toJson() => <String, dynamic>{};
}

class UserField {
  static const name = 'name';
  static const imageUrl = 'imageUrl';
}
