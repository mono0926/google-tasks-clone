import 'package:google_tasks/model/model.dart';

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
