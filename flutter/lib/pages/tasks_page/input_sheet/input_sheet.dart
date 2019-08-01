import 'package:flutter/material.dart';
import 'package:mono_kit/mono_kit.dart';
import 'package:provider/provider.dart';

import '../model.dart';
import 'due_date_time_dialog.dart';

class InputSheet extends StatefulWidget {
  const InputSheet({Key key}) : super(key: key);

  static const _elementPadding = EdgeInsets.all(16);

  @override
  _InputSheetState createState() => _InputSheetState();
}

class _InputSheetState extends State<InputSheet>
    with RouteAware, RouteObserverMixin {
  final _titleFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  FocusNode _lastFocusNode;

  Model get _model => Provider.of<Model>(context, listen: false);

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<Model>(context);
    return Material(
      child: Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildTitleTextField(),
              if (model.isDescriptionShown) _buildDescriptionTextField(context),
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

  Padding _buildDescriptionTextField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextField(
        focusNode: _descriptionFocusNode,
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
      padding: InputSheet._elementPadding,
      onPressed: model.isDescriptionShown
          ? null
          : () {
              model.showDescription();
              WidgetsBinding.instance.addPostFrameCallback((_) {
                FocusScope.of(context).requestFocus(_descriptionFocusNode);
              });
            },
    );
  }

  Widget _buildDueDateButton(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.calendar_today),
      padding: InputSheet._elementPadding,
      onPressed: () {
        showDialog<void>(
          context: context,
          builder: (context) => const DueDateTimeDialog(),
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
    for (final node in [_titleFocusNode, _descriptionFocusNode]) {
      if (node.hasFocus) {
        _lastFocusNode = node;
        break;
      }
    }
  }
}
