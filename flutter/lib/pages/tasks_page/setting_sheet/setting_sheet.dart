import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_tasks/model/notifier/notifier.dart';
import 'package:mono_kit/mono_kit.dart';
import 'package:provider/provider.dart';

import 'model.dart';

class SettingSheet extends StatelessWidget {
  const SettingSheet._({
    Key key,
  }) : super(key: key);

  static Widget withDependencies() {
    return ChangeNotifierProvider<Model>(
      builder: (context) => Model(
        authenticator: Provider.of(context, listen: false),
      ),
      child: const SettingSheet._(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<Model>(context);
    final account = Provider.of<AccountNotifier>(context);
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
                    backgroundImage: CachedNetworkImageProvider(
                      firUser.photoUrl,
                    ),
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
            const Divider(),
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
