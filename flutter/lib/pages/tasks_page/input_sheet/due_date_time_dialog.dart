import 'package:flutter/material.dart';
import 'package:google_tasks/model/model.dart';
import 'package:provider/provider.dart';

import '../input_model.dart';

class DueDateTimeDialog extends StatefulWidget {
  const DueDateTimeDialog._({Key key}) : super(key: key);

  static Widget withDependencies({@required InputModel model}) {
    return ChangeNotifierProvider<InputModel>.value(
      value: model,
      child: const DueDateTimeDialog._(),
    );
  }

  @override
  _DueDateTimeDialogState createState() => _DueDateTimeDialogState();
}

class _DueDateTimeDialogState extends State<DueDateTimeDialog> {
  DateTime _date;
  InputModel get _model => Provider.of<InputModel>(context, listen: false);
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
        children: <Widget>[
          // キーボード表示中の遷移で高さが足りずにエラーが出るのを回避
          Flexible(
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 16),
                  MonthPicker(
                    selectedDate: _date,
                    onChanged: (date) => setState(() => _date = date),
                    firstDate: DateTime.now().subtract(Duration(days: 365)),
                    lastDate: DateTime.now().add(Duration(days: 3650)),
                  ),
                  ListTile(
                    leading: Icon(Icons.access_time),
                    title: const Text('Set start time'),
                    dense: true,
                    onTap: () {
                      showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.repeat),
                    title: const Text('Does not repeat'),
                    dense: true,
                    trailing: Icon(Icons.chevron_right),
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ),
          ButtonTheme.bar(
            child: ButtonBar(
              children: <Widget>[
                FlatButton(
                  child:
                      Text(MaterialLocalizations.of(context).cancelButtonLabel),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                _buildDoneButton()
              ],
            ),
          )
        ],
      ),
    );
  }

  FlatButton _buildDoneButton() {
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
