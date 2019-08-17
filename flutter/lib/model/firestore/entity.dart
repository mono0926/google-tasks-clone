import 'package:meta/meta.dart';

@immutable
abstract class Entity {
  const Entity();
}

@immutable
// ignore: one_member_abstracts
abstract class EntityEncoder<E extends Entity> {
  Map<String, dynamic> encode(E entity);
}

class EntityField {
  static const createdAt = 'createdAt';
  static const updatedAt = 'updatedAt';
}
