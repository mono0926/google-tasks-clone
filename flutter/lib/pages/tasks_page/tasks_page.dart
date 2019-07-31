import 'package:flutter/material.dart';
import 'package:google_tasks/widgets/widgets.dart';

import 'input_sheet.dart';

class TasksPage extends StatelessWidget {
  const TasksPage({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // TODO(mono): 本物はAppBarではなくSliver使うと良さそう
      appBar: AppBar(
        title: const Text('My Tasks'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO(mono): barrier色をもっと明るくしたいが_ModalBottomSheetRouteで決めうちされているので妥協
          showModalBottomSheet<void>(
            // 縦に長く延びられるように。まだよく理解できてない。
            isScrollControlled: true,
            context: context,
            builder: (context) => const InputSheet(),
          );
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
    );
  }
}
