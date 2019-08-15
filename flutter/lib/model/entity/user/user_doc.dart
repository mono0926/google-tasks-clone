import 'package:google_tasks/model/firestore/firestore.dart';

import 'user.dart';

class UserDoc extends Document<User> {
  const UserDoc(
    String id,
    User entity,
  ) : super(
          id,
          entity,
        );
}
