import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../bloc/app_bloc/app_bloc.dart';
import '../global_widgets/widget_helper.dart';

class EmployeeTab extends StatefulWidget {
  const EmployeeTab({super.key});

  @override
  State<EmployeeTab> createState() => _EmployeeTabState();
}

class _EmployeeTabState extends State<EmployeeTab> {
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
            'Employee',
            style: textTheme.bodySmall?.copyWith(color: colorScheme.secondary, fontSize: 6.sp))
      ],
    );
  }
}
