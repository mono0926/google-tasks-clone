import 'package:flutter/material.dart';
import 'package:mono_kit/mono_kit.dart';

class RootPage extends StatelessWidget {
  const RootPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: TimeoutSwitcher(
        timeout: Duration(milliseconds: 500),
        timedOutChild: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
