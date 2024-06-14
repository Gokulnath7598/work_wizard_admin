import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../bloc/app_bloc/app_bloc.dart';
import '../../models/projects.dart';
import '../global_widgets/widget_helper.dart';

final List<Project> projects = <Project>[
  Project(id: 1, name: 'VGro', completedTask: 10, activeTask: 20, lastUpdate: '23:04:2024 11:00 AM'),
  Project(id: 1, name: 'Rise', completedTask: 0, activeTask: 10, lastUpdate: '27:04:2024 11:00 AM'),
  Project(id: 1, name: 'FinoBuddy', completedTask: 8, activeTask: 50, lastUpdate: '23:08:2023 11:00 AM')];

class ProjectsTab extends StatefulWidget {
  const ProjectsTab({super.key});

  @override
  State<ProjectsTab> createState() => _ProjectsTabState();
}

class _ProjectsTabState extends State<ProjectsTab> {
  late final AppBloc appBloc;

  @override
  void initState() {
    appBloc = BlocProvider.of<AppBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return ListView(
      children: <Widget>[
        BlocBuilder<AppBloc, AppState>(
            builder: (BuildContext context, AppState state) {
              return Text(
                  'Hi, ${appBloc.stateData.user?.name ?? ''}',
                  style: textTheme.bodySmall?.copyWith(color: colorScheme.secondary, fontSize: 8.sp, fontStyle: FontStyle.italic));
            }),
        getSpace(20, 0),
        Text(
            'Projects',
            style: textTheme.bodySmall?.copyWith(color: colorScheme.secondary, fontSize: 6.sp)),
        getSpace(20, 0),
    Table(
      border: TableBorder(horizontalInside: BorderSide(color: colorScheme.shadow)),
      children: <TableRow>[
        TableRow(
            children: <Widget>[
          TableCell(child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Text('Project', style: textTheme.bodySmall?.copyWith(color: colorScheme.primary, fontSize: 5.sp)))),
          TableCell(child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Text('Active Tasks', style: textTheme.bodySmall?.copyWith(color: colorScheme.primary, fontSize: 5.sp)))),
          TableCell(child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Text('Completed Tasks', style: textTheme.bodySmall?.copyWith(color: colorScheme.primary, fontSize: 5.sp)))),
          TableCell(child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Text('Last Update', style: textTheme.bodySmall?.copyWith(color: colorScheme.primary, fontSize: 5.sp)))),
        ]),
        ...List.generate(projects.length, (int index) => TableRow(
          children: <Widget>[
            TableCell(child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Text(projects[index].name ?? '', style: textTheme.bodySmall?.copyWith(color: colorScheme.secondary, fontSize: 5.sp)))),
            TableCell(child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Text('${projects[index].activeTask ?? 0}', style: textTheme.bodySmall?.copyWith(color: colorScheme.secondary, fontSize: 5.sp)))),
            TableCell(child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Text('${projects[index].completedTask ?? 0}', style: textTheme.bodySmall?.copyWith(color: colorScheme.secondary, fontSize: 5.sp)))),
            TableCell(child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Text(projects[index].lastUpdate ?? '', style: textTheme.bodySmall?.copyWith(color: colorScheme.secondary, fontSize: 5.sp)))),
          ],
        )),
      ],
    )
      ],
    );
  }
}
