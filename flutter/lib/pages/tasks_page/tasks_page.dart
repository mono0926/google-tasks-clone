import 'package:flutter/material.dart';
import 'package:google_tasks/model/model.dart';
import 'package:google_tasks/pages/tasks_page/input_sheet/input_sheet.dart';
import 'package:mono_kit/mono_kit.dart';
import 'package:provider/provider.dart';

import 'input_model.dart';
import 'tasks_main_page.dart';

class TasksPage extends StatefulWidget {
  const TasksPage._({Key key}) : super(key: key);

  static Widget withDependencies() {
    return ChangeNotifierProxyProvider<TasksHolder, InputModel>(
      builder: (context, holder, model) => model ?? InputModel(holder: holder),
      child: const TasksPage._(),
    );
  }

  @override
  _TasksPageState createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _fadeAnimation;
  Animation<double> _modalOffsetAnimation;

  InputModel get _model => Provider.of<InputModel>(context, listen: false);

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    _fadeAnimation =
        _animationController.drive(CurveTween(curve: Curves.easeInOut));
    _modalOffsetAnimation = _fadeAnimation.drive(Tween<double>(
      begin: -200,
      end: 0,
    ));

    _model.addListener(() {
      if (_model.isInputSheetShown) {
        _animationController.forward();
      } else {
        _animationController.reverse();
        FocusScope.of(context).unfocus();
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        TasksMainPage.withDependencies(context),
        _buildOverlay(),
        AnimatedBuilder(
          animation: _modalOffsetAnimation,
          builder: (context, child) {
            if (_modalOffsetAnimation.isDismissed) {
              return const SizedBox();
            }
            return Positioned.fill(
              top: null,
              bottom: _modalOffsetAnimation.value,
              child: child,
            );
          },
          child: const InputSheet(),
        ),
      ],
    );
  }

  Widget _buildOverlay() {
    return BetterFadeTransition(
      opacity: _fadeAnimation,
      child: GestureDetector(
        onTap: () {
          _model.toggleInputSheet(shown: false);
        },
        child: Container(
          color: Colors.black.withOpacity(0.3),
        ),
      ),
    );
  }
}
