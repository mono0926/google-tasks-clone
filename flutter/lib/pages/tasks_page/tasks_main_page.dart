import 'package:flutter/material.dart';
import 'package:google_tasks/widgets/widgets.dart';
import 'package:provider/provider.dart';

import 'input_model.dart';
import 'tasks_model.dart';

class TasksMainPage extends StatelessWidget {
  const TasksMainPage._({Key key}) : super(key: key);

  static Widget withDependencies() {
    return ChangeNotifierProvider(
      builder: (context) => TasksModel(),
      child: const TasksMainPage._(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Provider.of<InputModel>(
            context,
            listen: false,
          ).toggleInputSheet(shown: true);
        },
        child: const GoogleAdd(),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            offset: Offset.zero,
            blurRadius: 8,
          )
        ]),
        child: BottomAppBar(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(Icons.menu),
                onPressed: () {},
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
    final tasks = model.tasks;

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
                final task = tasks[index];
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
//                      iconSize: 24,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: Column(
                            children: <Widget>[
                              Text(task.title),
                              if (task.details != null) ...[
                                const SizedBox(height: 2),
                                Text(
                                  task.details,
                                  style: Theme.of(context).textTheme.caption,
                                ),
                              ]
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              childCount: tasks.length,
            ),
          )
        ],
      ),
    );

    return ListView.separated(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        return ListTile();
      },
      separatorBuilder: (context, index) => Divider(),
    );
  }
}
