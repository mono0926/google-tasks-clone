import 'package:flutter/material.dart';
import 'package:google_tasks/model/model.dart';
import 'package:provider/provider.dart';

import 'model.dart';

class DueDateTimeDialog extends StatefulWidget {
  const DueDateTimeDialog._({Key key}) : super(key: key);

  static Widget withDependencies({@required Model model}) {
    return ChangeNotifierProvider<Model>.value(
      value: model,
      child: const DueDateTimeDialog._(),
    );
  }

  @override
  _DueDateTimeDialogState createState() => _DueDateTimeDialogState();
}

class _DueDateTimeDialogState extends State<DueDateTimeDialog> {
  DateTime _date;
  Model get _model => Provider.of<Model>(context, listen: false);
  Task get _task => _model.task;

  @override
  void initState() {
    super.initState();
    _date = _task.due?.dateTime ?? DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // キーボード表示中の遷移で高さが足りずにエラーが出るのを回避
          Flexible(
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 16),
                  _buildPicker(),
                  _buildStartTimeTile(context),
                  _buildRepeatTile(),
                ],
              ),
            ),
          ),
          _buildButtons(context)
        ],
      ),
    );
  }

  Widget _buildPicker() {
    return MonthPicker(
      selectedDate: _date,
      onChanged: (date) => setState(() => _date = date),
      firstDate: DateTime.now().subtract(Duration(days: 365)),
      lastDate: DateTime.now().add(Duration(days: 3650)),
    );
  }

  Widget _buildStartTimeTile(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.access_time),
      title: const Text('Set start time'),
      dense: true,
      onTap: () {
        showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
        );
      },
    );
  }

  Widget _buildRepeatTile() {
    return ListTile(
      leading: Icon(Icons.repeat),
      title: const Text('Does not repeat'),
      dense: true,
      trailing: Icon(Icons.chevron_right),
      onTap: () {},
    );
  }

  Widget _buildButtons(BuildContext context) {
    return ButtonTheme.bar(
      child: ButtonBar(
        children: <Widget>[_buildCancelButton(context), _buildDoneButton()],
      ),
    );
  }

  Widget _buildCancelButton(BuildContext context) {
    return FlatButton(
      child: Text(MaterialLocalizations.of(context).cancelButtonLabel),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }

  Widget _buildDoneButton() {
    return FlatButton(
      child: const Text('DONE'),
      onPressed: () {
        _model.task = _task.copyWith(
          due: (_task.due ?? const Due(null, includeTime: false))
              .copyWith(_date),
        );
        Navigator.of(context).pop();
      },
    );
  }
}
