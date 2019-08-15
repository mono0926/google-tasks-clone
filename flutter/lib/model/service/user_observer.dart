import 'package:google_tasks/model/entity/entity.dart';

class UserObserver {
  Stream<UserDoc> doc(String id) => UsersRef.ref().docRef(id).document();
}
