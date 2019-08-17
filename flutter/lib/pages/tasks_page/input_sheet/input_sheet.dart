import 'package:flutter/material.dart';
import 'package:google_tasks/widgets/widgets.dart';
import 'package:provider/provider.dart';
import 'package:route_observer_mixin/route_observer_mixin.dart';

import 'due_date_time_dialog.dart';
import 'model.dart';

class InputSheet extends StatefulWidget {
  const InputSheet._({Key key}) : super(key: key);

  static Widget withDependencies() {
    return ChangeNotifierProvider<Model>(
      builder: (context) => Model(service: Provider.of(context, listen: false)),
      child: const InputSheet._(),
    );
  }

  @override
  _InputSheetState createState() => _InputSheetState();
}

class _InputSheetState extends State<InputSheet>
    with RouteAware, RouteObserverMixin {
  final _titleFocusNode = FocusNode();
  final _detailsFocusNode = FocusNode();
  final _titleController = TextEditingController();
  final _detailsController = TextEditingController();
  FocusNode _lastFocusNode;

  Model get _model => Provider.of<Model>(context, listen: false);

  @override
  void dispose() {
    _titleController.dispose();
    _detailsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<Model>(context);
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return ConstrainedBox(
            constraints: BoxConstraints(maxHeight: constraints.maxHeight - 44),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTitleTextField(),
                  if (model.isDetailsShown)
                    Flexible(child: _buildDetailsTextField(context)),
                  if (model.task.due != null) _buildDueButton(context),
                  IconTheme(
                    data: Theme.of(context).accentIconTheme,
                    child: Row(
                      children: [
                        _buildDetailButton(context),
                        _buildDueDateButton(context),
                        Spacer(),
                        _buildSaveButton()
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTitleTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextField(
        controller: _titleController,
        focusNode: _titleFocusNode,
        decoration: InputDecoration(
          hintText: 'New task',
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _buildDueButton(BuildContext context) {
    final model = Provider.of<Model>(context);
    final due = model.task.due;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: DueButton(
        due: due,
        onPressed: _showDueDateTimeDialog,
        onClosePressed: () => model.task = model.task.copyWith(clearDue: true),
      ),
    );
  }

  Widget _buildDetailsTextField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextField(
        controller: _detailsController,
        focusNode: _detailsFocusNode,
        decoration: InputDecoration(
          hintText: 'Add details',
          border: InputBorder.none,
        ),
        style: Theme.of(context).textTheme.caption,
        minLines: 1,
        maxLines: null,
      ),
    );
  }

  Widget _buildDetailButton(BuildContext context) {
    final model = Provider.of<Model>(context);
    return IconButton(
      icon: Icon(Icons.format_align_left),
      padding: const EdgeInsets.all(16),
      onPressed: model.isDetailsShown
          ? null
          : () {
              model.showDetails();
              WidgetsBinding.instance.addPostFrameCallback((_) {
                FocusScope.of(context).requestFocus(_detailsFocusNode);
              });
            },
    );
  }

  Widget _buildDueDateButton(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.calendar_today),
      padding: const EdgeInsets.all(16),
      onPressed: _showDueDateTimeDialog,
    );
  }

  void _showDueDateTimeDialog() {
    showDialog<void>(
      context: context,
      builder: (context) => DueDateTimeDialog.withDependencies(
        model: _model,
      ),
    );
  }

  Widget _buildSaveButton() {
    return FlatButton(
      textTheme: ButtonTextTheme.accent,
      // TODO(mono): localize
      child: const Text('Save'),
      onPressed: () {
        _model
          ..task = _model.task.copyWith(
            title: _titleController.text,
            details: _detailsController.text,
          )
          ..save();
        Navigator.of(context).pop();
      },
    );
  }

  @override
  void didPush() {
    FocusScope.of(context).requestFocus(_titleFocusNode);
  }

  @override
  void didPopNext() {
    if (_lastFocusNode != null) {
      FocusScope.of(context).requestFocus(_lastFocusNode);
    }
  }

  @override
  void didPushNext() {
    for (final node in [_titleFocusNode, _detailsFocusNode]) {
      if (node.hasFocus) {
        _lastFocusNode = node;
        break;
      }
    }
  }
}
