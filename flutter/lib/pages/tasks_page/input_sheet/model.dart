import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:google_tasks/model/model.dart';

class Model extends ChangeNotifier {
  Model({
    @required this.service,
  });

  final TasksService service;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController detailsController = TextEditingController();
  final FocusNode titleFocusNode = FocusNode();
  final FocusNode detailsFocusNode = FocusNode();
  FocusNode lastFocusNode;

  var _task = const Task();
  var _isDetailsShown = false;

  Task get task => _task;
  bool get isDetailsShown => _isDetailsShown;

  void showDetails() {
    _isDetailsShown = true;
    notifyListeners();
  }

  set task(Task task) {
    _task = task;
    notifyListeners();
  }

  void save() {
    service.add(task);
  }

  void focusToTitle(BuildContext context) {
    _focus(context, node: titleFocusNode);
  }

  void focusToDetails(BuildContext context) {
    _focus(context, node: detailsFocusNode);
  }

  void focusToLastIfPossible(BuildContext context) {
    if (lastFocusNode != null) {
      _focus(context, node: lastFocusNode);
    }
  }

  void saveFocus() {
    for (final node in [titleFocusNode, detailsFocusNode]) {
      if (node.hasFocus) {
        lastFocusNode = node;
        break;
      }
    }
  }

  void _focus(
    BuildContext context, {
    @required FocusNode node,
  }) {
    FocusScope.of(context).requestFocus(node);
  }

  @override
  void dispose() {
    titleController.dispose();
    detailsController.dispose();

    super.dispose();
  }
}
