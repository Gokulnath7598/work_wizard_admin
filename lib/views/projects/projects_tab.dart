import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../bloc/app_bloc/app_bloc.dart';
import '../global_widgets/widget_helper.dart';

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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
            style: textTheme.bodySmall?.copyWith(color: colorScheme.secondary, fontSize: 6.sp))
      ],
    );
  }
}
