import 'package:flutter/material.dart';

class InputSheet extends StatelessWidget {
  const InputSheet({Key key}) : super(key: key);

  static const _elementPadding = EdgeInsets.all(16);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildTextField(),
            IconTheme(
              data: Theme.of(context).accentIconTheme,
              child: Row(
                children: [
                  _buildDetailButton(),
                  _buildDueDateButton(),
                  Spacer(),
                  _buildSaveButton()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTextField() {
    return Padding(
      padding: _elementPadding,
      child: TextField(
        decoration: InputDecoration.collapsed(
          hintText: 'New task',
        ),
        autofocus: true,
        minLines: 1,
        maxLines: 30,
      ),
    );
  }

  Widget _buildDetailButton() {
    return IconButton(
      icon: Icon(Icons.format_align_left),
      padding: _elementPadding,
      onPressed: () {},
    );
  }

  Widget _buildDueDateButton() {
    return IconButton(
      icon: Icon(Icons.calendar_today),
      padding: _elementPadding,
      onPressed: () {},
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
}
