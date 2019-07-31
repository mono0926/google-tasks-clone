import 'package:flutter/material.dart';

class DueDateTimeSheet extends StatelessWidget {
  const DueDateTimeSheet({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 44,
            child: NavigationToolbar(
              middle: Text(
                'Date & Time',
                style: Theme.of(context).textTheme.subtitle,
              ),
              trailing: FlatButton(
                child: const Text('Done'),
                textTheme: ButtonTextTheme.accent,
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ),
          const Divider(height: 0),
          const SizedBox(height: 8),
          MonthPicker(
            selectedDate: DateTime.now(),
            onChanged: (x) {},
            firstDate: DateTime.now().subtract(Duration(days: 365)),
            lastDate: DateTime.now().add(Duration(days: 365)),
          ),
          const Divider(height: 0),
          ListTile(
            title: const Text('Set start time'),
            dense: true,
            onTap: () {},
          ),
          const Divider(height: 0),
          ListTile(
            title: const Text('Does not repeat'),
            dense: true,
            trailing: Icon(Icons.chevron_right),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
