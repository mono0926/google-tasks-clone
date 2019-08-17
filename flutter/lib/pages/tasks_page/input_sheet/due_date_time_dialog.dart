import 'package:flutter/material.dart';
import 'package:google_tasks/model/model.dart';
import 'package:provider/provider.dart';

import 'model.dart';

class _DateModel extends ValueNotifier<DateTime> {
  _DateModel(DateTime value) : super(value);
}

class DueDateTimeDialog extends StatelessWidget {
  const DueDateTimeDialog._({Key key}) : super(key: key);

  static Widget withDependencies({@required Model model}) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Model>.value(value: model),
        ChangeNotifierProvider<_DateModel>(builder: (context) {
          final model = Provider.of<Model>(context, listen: false);
          return _DateModel(model.task.due?.dateTime ?? DateTime.now());
        }),
      ],
      child: const DueDateTimeDialog._(),
    );
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
                children: const [
                  SizedBox(height: 16),
                  _Picker(),
                  _StartTimeTile(),
                  _RepeatTile(),
                ],
              ),
            ),
          ),
          ButtonTheme.bar(
            child: const ButtonBar(
              children: [
                _CancelButton(),
                _DoneButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _RepeatTile extends StatelessWidget {
  const _RepeatTile({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.repeat),
      title: const Text('Does not repeat'),
      dense: true,
      trailing: Icon(Icons.chevron_right),
      onTap: () {},
    );
  }
}

class _CancelButton extends StatelessWidget {
  const _CancelButton({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Text(MaterialLocalizations.of(context).cancelButtonLabel),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
  }
}

class _StartTimeTile extends StatelessWidget {
  const _StartTimeTile({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
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
}

class _DoneButton extends StatelessWidget {
  const _DoneButton({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<Model>(context, listen: false);
    final task = model.task;
    final dateModel = Provider.of<_DateModel>(context, listen: false);
    final due = dateModel.value;
    return FlatButton(
      child: const Text('DONE'),
      onPressed: () {
        model.task = task.copyWith(
          due: (task.due ?? const Due(null, includeTime: false)).copyWith(due),
        );
        Navigator.of(context).pop();
      },
    );
  }
}

class _Picker extends StatelessWidget {
  const _Picker({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<_DateModel>(context);
    return MonthPicker(
      selectedDate: model.value,
      onChanged: (date) => model.value = date,
      firstDate: DateTime.now().subtract(Duration(days: 365)),
      lastDate: DateTime.now().add(Duration(days: 3650)),
    );
  }
}
