import 'package:flutter/material.dart';
import 'package:google_tasks/widgets/widgets.dart';
import 'package:provider/provider.dart';

import 'due_date_time_dialog.dart';
import 'model.dart';

class InputSheet extends StatelessWidget {
  const InputSheet._({Key key}) : super(key: key);

  static Widget withDependencies() {
    return ChangeNotifierProvider<Model>(
      builder: (context) => Model(
        service: Provider.of(context, listen: false),
      ),
      child: const InputSheet._(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return ConstrainedBox(
            constraints: BoxConstraints(maxHeight: constraints.maxHeight - 44),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _TitleTextField(),
                  const Flexible(child: _DetailsTextField()),
                  const _DueButton(),
                  IconTheme(
                    data: Theme.of(context).accentIconTheme,
                    child: Row(
                      children: const [
                        _DetailButton(),
                        _DueDateButton(),
                        Spacer(),
                        _SaveButton(),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _DueDateButton extends StatelessWidget {
  const _DueDateButton({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.calendar_today),
      padding: const EdgeInsets.all(16),
      onPressed: () => _showDueDateTimeDialog(context),
    );
  }
}

class _TitleTextField extends StatelessWidget {
  const _TitleTextField({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<Model>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextField(
        autofocus: true,
        controller: model.titleController,
        focusNode: model.titleFocusNode,
        decoration: InputDecoration(
          hintText: 'New task',
          border: InputBorder.none,
        ),
      ),
    );
  }
}

class _DetailsTextField extends StatelessWidget {
  const _DetailsTextField({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<Model>(context);
    if (!model.isDetailsShown) {
      return const SizedBox();
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextField(
        controller: model.detailsController,
        focusNode: model.detailsFocusNode,
        decoration: InputDecoration(
          hintText: 'Add details',
          border: InputBorder.none,
        ),
        style: Theme.of(context).textTheme.caption,
        minLines: 1,
        maxLines: null,
      ),
    );
  }
}

class _DueButton extends StatelessWidget {
  const _DueButton({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<Model>(context);
    final due = model.task.due;

    if (model.task.due == null) {
      return const SizedBox();
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: DueButton(
        due: due,
        onPressed: () => _showDueDateTimeDialog(context),
        onClosePressed: () => model.task = model.task.copyWith(clearDue: true),
      ),
    );
  }
}

class _DetailButton extends StatelessWidget {
  const _DetailButton({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<Model>(context);
    return IconButton(
      icon: Icon(Icons.format_align_left),
      padding: const EdgeInsets.all(16),
      onPressed: model.isDetailsShown
          ? null
          : () {
              model.showDetails();
              WidgetsBinding.instance.addPostFrameCallback((_) {
                model.focusToDetails(context);
              });
            },
    );
  }
}

class _SaveButton extends StatelessWidget {
  const _SaveButton({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<Model>(context, listen: false);
    return FlatButton(
      textTheme: ButtonTextTheme.accent,
      // TODO(mono): localize
      child: const Text('Save'),
      onPressed: () {
        model
          ..task = model.task.copyWith(
            title: model.titleController.text,
            details: model.detailsController.text,
          )
          ..save();
        Navigator.of(context).pop();
      },
    );
  }
}

void _showDueDateTimeDialog(BuildContext context) async {
  final model = Provider.of<Model>(context, listen: false)..saveFocus();
  await showDialog<void>(
    context: context,
    builder: (context) => DueDateTimeDialog.withDependencies(
      model: model,
    ),
  );
  model.focusToLastIfPossible(context);
}
