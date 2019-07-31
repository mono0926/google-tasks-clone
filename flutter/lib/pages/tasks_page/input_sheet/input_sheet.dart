import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'due_date_time_sheet.dart';

class InputSheet extends StatelessWidget {
  const InputSheet._({Key key}) : super(key: key);

  static Widget withDependencies() {
    return ChangeNotifierProvider(
      builder: (context) => _Model(),
      child: const InputSheet._(),
    );
  }

  static const _elementPadding = EdgeInsets.all(16);

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<_Model>(context);
    return Padding(
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
    );
  }

  Padding _buildDescriptionTextField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextField(
        autofocus: true,
        decoration: InputDecoration(
          hintText: 'Add details',
          border: InputBorder.none,
        ),
        style: Theme.of(context).textTheme.caption,
      ),
    );
  }

  Widget _buildTitleTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'New task',
          border: InputBorder.none,
        ),
        autofocus: true,
        minLines: 1,
        maxLines: 30,
      ),
    );
  }

  Widget _buildDetailButton(BuildContext context) {
    final model = Provider.of<_Model>(context);
    return IconButton(
      icon: Icon(Icons.format_align_left),
      padding: _elementPadding,
      onPressed: model.isDescriptionShown ? null : model.showDescription,
    );
  }

  Widget _buildDueDateButton(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.calendar_today),
      padding: _elementPadding,
      onPressed: () {
        showModalBottomSheet<void>(
          isScrollControlled: true,
          context: context,
          builder: (context) => const DueDateTimeSheet(),
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
}

class _Model extends ChangeNotifier {
  bool _isDescriptionShown = false;
  bool get isDescriptionShown => _isDescriptionShown;

  void showDescription() {
    _isDescriptionShown = true;
    notifyListeners();
  }
}
