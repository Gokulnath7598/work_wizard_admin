import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import '../../bloc/projects_bloc/projects_bloc.dart';
import '../global_widgets/widget_helper.dart';


class ProjectsTab extends StatefulWidget {
  const ProjectsTab({super.key});

  @override
  State<ProjectsTab> createState() => _ProjectsTabState();
}

class _ProjectsTabState extends State<ProjectsTab> {
  late final ProjectsBloc projectsBloc;

  @override
  void initState() {
    projectsBloc = BlocProvider.of<ProjectsBloc>(context);
    projectsBloc.add(GetProjects());
    WidgetsBinding.instance.addPostFrameCallback((Duration timeStamp) {
      projectsBloc.stream.listen((ProjectsState state) => (mounted
          ? onProjectsBlocChange(context: context, state: state)
          : null));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return BlocBuilder<ProjectsBloc, ProjectsState>(
        builder: (BuildContext context, ProjectsState state) {
        return state is ProjectsLoading ?
        Lottie.asset('assets/time_loader_blue_500.json')
          : ListView(
          children: <Widget>[
            Text('Projects',
                style: textTheme.bodySmall
                    ?.copyWith(color: colorScheme.secondary, fontSize: 6.sp)),
            getSpace(20, 0),
            DataTable(
              border: TableBorder(
                  horizontalInside: BorderSide(color: colorScheme.shadow)),
              columns: <DataColumn>[
                DataColumn(
                    label: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        child: Text('Project',
                            style: textTheme.bodySmall?.copyWith(
                                color: colorScheme.primary, fontSize: 5.sp)))),
                DataColumn(
                    label: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        child: Text('Active Tasks',
                            style: textTheme.bodySmall?.copyWith(
                                color: colorScheme.primary, fontSize: 5.sp)))),
                DataColumn(
                    label: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        child: Text('Completed Tasks',
                            style: textTheme.bodySmall?.copyWith(
                                color: colorScheme.primary, fontSize: 5.sp)))),
                DataColumn(
                    label: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        child: Text('Last Update',
                            style: textTheme.bodySmall?.copyWith(
                                color: colorScheme.primary, fontSize: 5.sp)))),
              ],
              rows: <DataRow>[
                ...List<DataRow>.generate(
                    projectsBloc.getProjectsSuccess.projects?.length ?? 0,
                    (int index) => DataRow(
                      onLongPress: (){
                        projectsBloc.add(GetProjectTasks(project: projectsBloc.getProjectsSuccess.projects?[index]));
                      },
                          cells: <DataCell>[
                            DataCell(Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 20),
                                child: Text(projectsBloc.getProjectsSuccess.projects?[index].projectName ?? '',
                                    style: textTheme.bodySmall?.copyWith(
                                        color: colorScheme.secondary,
                                        fontSize: 5.sp)))),
                            DataCell(Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 20),
                                child: Text('${projectsBloc.getProjectsSuccess.projects?[index].activeTask ?? 0}',
                                    style: textTheme.bodySmall?.copyWith(
                                        color: colorScheme.secondary,
                                        fontSize: 5.sp)))),
                            DataCell(Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 20),
                                child: Text('${projectsBloc.getProjectsSuccess.projects?[index].completedTask ?? 0}',
                                    style: textTheme.bodySmall?.copyWith(
                                        color: colorScheme.secondary,
                                        fontSize: 5.sp)))),
                            DataCell(Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 20),
                                child: Text(projectsBloc.getProjectsSuccess.projects?[index].lastUpdate ?? '',
                                    style: textTheme.bodySmall?.copyWith(
                                        color: colorScheme.secondary,
                                        fontSize: 5.sp)))),
                          ],
                        ))
              ],
            )
          ],
        );
      }
    );
  }
}
