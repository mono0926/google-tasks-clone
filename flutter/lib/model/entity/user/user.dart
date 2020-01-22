import 'package:flutter/foundation.dart';
import 'package:google_tasks/model/model.dart';
import 'package:json_annotation/json_annotation.dart';

export 'user_doc.dart';
export 'users_ref.dart';

part 'user.g.dart';

@JsonSerializable()
class User with Entity {
  const User({
    @required this.name,
    @required this.imageUrl,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);

  final String name;
  final String imageUrl;
}

class UserField {
  static const name = 'name';
  static const imageUrl = 'imageUrl';
}
