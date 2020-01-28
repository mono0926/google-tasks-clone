import 'package:flutter/material.dart';

class RootPage extends StatelessWidget {
  const RootPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      // 一瞬で済むなら以下は空でも良い(あるいはスプラッシュ系の表示)
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
