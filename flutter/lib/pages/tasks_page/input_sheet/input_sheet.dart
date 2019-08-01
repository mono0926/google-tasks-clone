import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mono_kit/mono_kit.dart';
import 'package:provider/provider.dart';

import '../model.dart';
import 'due_date_time_dialog.dart';

const _elementPadding = EdgeInsets.all(16);

class InputSheet extends StatefulWidget {
  const InputSheet({Key key}) : super(key: key);

  @override
  _InputSheetState createState() => _InputSheetState();
}

class _InputSheetState extends State<InputSheet>
    with RouteAware, RouteObserverMixin {
  final _titleFocusNode = FocusNode();
  final _detailsFocusNode = FocusNode();
  FocusNode _lastFocusNode;

  Model get _model => Provider.of<Model>(context, listen: false);

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<Model>(context);
    return Material(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTitleTextField(),
              if (model.isDetailsShown) _buildDetailsTextField(context),
              if (model.task.due != null) _buildDueLabel(context),
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
      ),
    );
  }

  Widget _buildTitleTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextField(
        focusNode: _titleFocusNode,
        decoration: InputDecoration(
          hintText: 'New task',
          border: InputBorder.none,
        ),
        minLines: 1,
        maxLines: 30,
      ),
    );
  }

  Widget _buildDueLabel(BuildContext context) {
    final model = Provider.of<Model>(context);
    final due = model.task.due;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: RaisedButton(
        color: Theme.of(context).inputDecorationTheme.fillColor,
        elevation: 0,
        highlightElevation: 0,
        shape: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).dividerColor),
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        onPressed: () {},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.calendar_today,
              size: 16,
              color: Theme.of(context).accentColor,
            ),
            const SizedBox(width: 8),
            Text(DateFormat.MMMEd().format(due.dateTime)),
            const SizedBox(width: 8),
            SizedBox(
              width: 24,
              height: 24,
              child: IconButton(
                icon: Icon(Icons.close),
                padding: EdgeInsets.zero,
                onPressed: () {
                  model.task = model.task.copyWith(clearDue: true);
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildDetailsTextField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextField(
        focusNode: _detailsFocusNode,
        decoration: InputDecoration(
          hintText: 'Add details',
          border: InputBorder.none,
        ),
        style: Theme.of(context).textTheme.caption,
      ),
    );
  }

  Widget _buildDetailButton(BuildContext context) {
    final model = Provider.of<Model>(context);
    return IconButton(
      icon: Icon(Icons.format_align_left),
      padding: _elementPadding,
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
      padding: _elementPadding,
      onPressed: () {
        showDialog<void>(
          context: context,
          builder: (context) => DueDateTimeDialog.withDependencies(
            model: _model,
          ),
        );
      },
    );
  }

  Widget _buildSaveButton() {
    return FlatButton(
      textTheme: ButtonTextTheme.accent,
      // TODO(mono): localize
      child: const Text('Save'),
      onPressed: () {},
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
