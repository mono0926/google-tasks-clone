import 'package:flutter/material.dart';
import 'package:google_tasks/model/model.dart';
import 'package:google_tasks/model/service/service.dart';
import 'package:google_tasks/widgets/widgets.dart';
import 'package:provider/provider.dart';

import 'input_sheet/input_sheet.dart';
import 'setting_sheet/setting_sheet.dart';
import 'tasks_model.dart';

class TasksPage extends StatelessWidget {
  const TasksPage._({Key key}) : super(key: key);

  static const routeName = '/Tasks';

  static Widget withDependencies() {
    return ChangeNotifierProxyProvider<TasksService, TasksModel>(
      builder: (context, service, model) =>
          model ?? TasksModel(service: service),
      child: const TasksPage._(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet<void>(
            isScrollControlled: true,
            context: context,
            builder: (context) =>
                SafeArea(child: InputSheet.withDependencies()),
          );
        },
        child: const GoogleAdd(),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              offset: Offset.zero,
              blurRadius: 8,
            )
          ],
        ),
        child: BottomAppBar(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(Icons.menu),
                onPressed: () {
                  showModalBottomSheet<void>(
                    context: context,
                    builder: (context) => SettingSheet.withDependencies(),
                  );
                },
              ),
              IconButton(
                icon: Icon(Icons.more_horiz),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
      body: const _Body(),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<TasksModel>(context);
    final docs = model.tasks;

    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 48,
                vertical: 16,
              ),
              child: Text(
                'My Tasks',
                style: Theme.of(context).textTheme.headline,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final doc = docs[index];
                final task = doc.entity;
                return Container(
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                    color: Theme.of(context).dividerColor,
                    width: 1 / MediaQuery.of(context).devicePixelRatio,
                  ))),
                  child: InkWell(
                    onTap: () {},
                    child: Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.radio_button_unchecked),
                          onPressed: () {},
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(task.title),
                              if ((task.details ?? '').isNotEmpty) ...[
                                const SizedBox(height: 2),
                                Text(
                                  task.details,
                                  style: Theme.of(context).textTheme.caption,
                                ),
                              ],
                              if (task.due != null)
                                DueButton(
                                  due: task.due,
                                  onPressed: () {},
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              childCount: docs.length,
            ),
          )
        ],
      ),
    );
  }
}
