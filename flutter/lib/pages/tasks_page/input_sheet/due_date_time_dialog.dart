import 'package:flutter/material.dart';
import 'package:google_tasks/model/entity/entity.dart';
import 'package:google_tasks/model/model.dart';
import 'package:provider/provider.dart';

import 'model.dart';

class _DateModel extends ValueNotifier<Due> {
  _DateModel(Due value) : super(value);
}

class DueDateTimeDialog extends StatelessWidget {
  const DueDateTimeDialog._({Key key}) : super(key: key);

  static Widget withDependencies({@required Model model}) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Model>.value(value: model),
        ChangeNotifierProvider<_DateModel>(builder: (context) {
          final model = Provider.of<Model>(context, listen: false);
          return _DateModel(model.task.due ?? Due(DateTime.now()));
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
          const ButtonBar(
            children: [
              _CancelButton(),
              _DoneButton(),
            ],
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
    final dateModel = Provider.of<_DateModel>(context);
    return ListTile(
      leading: Icon(Icons.access_time),
      title: Text(dateModel.value.includeTime
          ? dateModel.value.dateTime.toString()
          : 'Set start time'),
      dense: true,
      onTap: () async {
        final time = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
        );
        if (time == null) {
          return;
        }
        final dueTime = dateModel.value.dateTime;
        dateModel.value = Due(
          DateTime(
            dueTime.year,
            dueTime.month,
            dueTime.day,
            time.hour,
            time.minute,
          ),
          includeTime: true,
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
    return FlatButton(
      child: const Text('DONE'),
      onPressed: () {
        final due = dateModel.value;
        model.task = task.copyWith(
          due: due ?? task.due ?? const Due(null, includeTime: false),
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
      selectedDate: model.value.dateTime,
      onChanged: (date) => model.value = model.value.copyWith(date),
      firstDate: DateTime.now().subtract(Duration(days: 365)),
      lastDate: DateTime.now().add(Duration(days: 3650)),
    );
  }
}
