import 'package:flutter/material.dart';
import 'package:google_tasks/model/notifier/notifier.dart';
import 'package:google_tasks/model/service/service.dart';
import 'package:mono_kit/mono_kit.dart';
import 'package:provider/provider.dart';

import 'model.dart';

class SettingSheet extends StatelessWidget {
  const SettingSheet._({
    Key key,
  }) : super(key: key);

  static Widget withDependencies() {
    return ChangeNotifierProxyProvider<Authenticator, Model>(
      builder: (context, authenticator, previous) =>
          previous ??
          Model(
            authenticator: authenticator,
          ),
      child: const SettingSheet._(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<Model>(context);
    final account = Provider.of<Account>(context);
    final firUser = account.firUser;
    if (firUser == null) {
      return const SizedBox();
    }
    return Barrier(
      showProgress: ValueNotifier<bool>(model.status == Status.inProgress),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: Image.network(
                      firUser.photoUrl,
                      fit: BoxFit.fill,
                    ).image,
                    radius: 18,
                  ),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        firUser.displayName,
                        style: Theme.of(context).textTheme.body1.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        firUser.email,
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Divider(),
            ListTile(
              onTap: model.signOut,
              title: const Text('Sign out'),
              leading: Icon(Icons.exit_to_app),
            ),
          ],
        ),
      ),
    );
  }
}
