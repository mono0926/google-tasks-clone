import 'package:flutter/material.dart';
import 'package:google_tasks/model/model.dart';
import 'package:intl/intl.dart';

class DueButton extends StatelessWidget {
  const DueButton({
    Key key,
    @required this.due,
    @required this.onPressed,
    this.onClosePressed,
  }) : super(key: key);

  final Due due;
  final VoidCallback onPressed;
  final VoidCallback onClosePressed;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: Theme.of(context).inputDecorationTheme.fillColor,
      elevation: 0,
      highlightElevation: 0,
      shape: OutlineInputBorder(
        borderSide: BorderSide(color: Theme.of(context).dividerColor),
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      onPressed: onPressed,
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
          if (onClosePressed != null)
            SizedBox(
              width: 24,
              height: 24,
              child: IconButton(
                icon: Icon(Icons.close),
                padding: EdgeInsets.zero,
                onPressed: onClosePressed,
              ),
            )
        ],
      ),
    );
  }
}
