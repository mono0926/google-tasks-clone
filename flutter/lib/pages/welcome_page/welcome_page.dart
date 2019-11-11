import 'package:flutter/material.dart';
import 'package:google_tasks/l10n/l10n.dart';
import 'package:mono_kit/mono_kit.dart';
import 'package:provider/provider.dart';
import 'package:undraw/undraw.dart';

import 'model.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage._({Key key}) : super(key: key);

  static Widget withDependencies() {
    return ChangeNotifierProvider<Model>(
      builder: (context) => Model(
        authenticator: Provider.of(context, listen: false),
      ),
      child: const WelcomePage._(),
    );
  }

  static const routeName = '/Welcome';

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<Model>(context);
    final width = MediaQuery.of(context).size.width;
    return Barrier.value(
      showProgress: model.status == Status.inProgress,
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FittedBox(
              child: UnDraw(
                color: Theme.of(context).accentColor,
                illustration: UnDrawIllustration.complete_task,
                placeholder: SizedBox(
                  height: width * 0.7,
                  width: width,
                ),
              ),
            ),
            const SizedBox(height: 32),
            Text(
              L10n.of(context).welcomeTitle,
              style: Theme.of(context).textTheme.headline,
            ),
            const SizedBox(height: 16),
            const Text(
              'Keep track of important things you need to get done\n'
              'in one place.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            RaisedButton(
              child: const Text('Get started'),
              onPressed: () =>
                  Provider.of<Model>(context, listen: false).signIn(),
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 32),
              textTheme: ButtonTextTheme.primary,
            )
          ],
        ),
      ),
    );
  }
}
