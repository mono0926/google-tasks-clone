import 'package:flutter/material.dart';

class DueDateTimeDialog extends StatelessWidget {
  const DueDateTimeDialog({Key key}) : super(key: key);
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
                    selectedDate: DateTime.now(),
                    onChanged: (x) {},
                    firstDate: DateTime.now().subtract(Duration(days: 365)),
                    lastDate: DateTime.now().add(Duration(days: 365)),
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
                FlatButton(
                  child: const Text('DONE'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
