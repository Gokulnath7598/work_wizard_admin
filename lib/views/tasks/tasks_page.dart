import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../models/task.dart';
import '../global_widgets/widget_helper.dart';

class TasksPage extends StatelessWidget {
  const TasksPage({super.key, this.isProject = false, required this.title, required this.tasks});
  final bool isProject;
  final String title;
  final List<Task>? tasks;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: <Widget>[
            Text(
                title,
                style: textTheme.bodySmall?.copyWith(color: colorScheme.secondary, fontSize: 6.sp)),
            getSpace(20, 0),
            DataTable(
              border: TableBorder(
                  horizontalInside: BorderSide(color: colorScheme.shadow)),
              columns: <DataColumn>[
                DataColumn(
                    label: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        child: Text(isProject ? 'Employee':'Project',
                            style: textTheme.bodySmall?.copyWith(
                                color: colorScheme.primary, fontSize: 5.sp)))),
                DataColumn(
                    label: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        child: Text('Task',
                            style: textTheme.bodySmall?.copyWith(
                                color: colorScheme.primary, fontSize: 5.sp)))),
                DataColumn(
                    label: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        child: Text('Status',
                            style: textTheme.bodySmall?.copyWith(
                                color: colorScheme.primary, fontSize: 5.sp)))),
                DataColumn(
                    label: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        child: Text('Estimate',
                            style: textTheme.bodySmall?.copyWith(
                                color: colorScheme.primary, fontSize: 5.sp)))),
                DataColumn(
                    label: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        child: Text('Actual Time',
                            style: textTheme.bodySmall?.copyWith(
                                color: colorScheme.primary, fontSize: 5.sp)))),
              ],
              rows: <DataRow>[
                ...List<DataRow>.generate(
                    tasks?.length ?? 0,
                        (int index) => DataRow(
                      cells: <DataCell>[
                        DataCell(Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            child: Text(isProject ? (tasks?[index].employee?.name ?? ''):(tasks?[index].project?.projectName ?? ''),
                                style: textTheme.bodySmall?.copyWith(
                                    color: colorScheme.secondary,
                                    fontSize: 5.sp)))),
                        DataCell(Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            child: Text('${tasks?[index].task ?? 0}',
                                style: textTheme.bodySmall?.copyWith(
                                    color: colorScheme.secondary,
                                    fontSize: 5.sp)))),
                        DataCell(Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            child: Text('${tasks?[index].status ?? 0}',
                                style: textTheme.bodySmall?.copyWith(
                                    color: colorScheme.secondary,
                                    fontSize: 5.sp)))),
                        DataCell(Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            child: Text(tasks?[index].time ?? '',
                                style: textTheme.bodySmall?.copyWith(
                                    color: colorScheme.secondary,
                                    fontSize: 5.sp)))),
                        DataCell(Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            child: Text(tasks?[index].time ?? '',
                                style: textTheme.bodySmall?.copyWith(
                                    color: colorScheme.secondary,
                                    fontSize: 5.sp)))),
                      ],
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
