import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../bloc/app_bloc/app_bloc.dart';
import '../../bloc/employee_bloc/employee_bloc.dart';
import '../global_widgets/widget_helper.dart';

class EmployeeTab extends StatefulWidget {
  const EmployeeTab({super.key});

  @override
  State<EmployeeTab> createState() => _EmployeeTabState();
}

class _EmployeeTabState extends State<EmployeeTab> {
  late final AppBloc appBloc;
  late final EmployeeBloc employeeBloc;


  @override
  void initState() {
    appBloc = BlocProvider.of<AppBloc>(context);
    employeeBloc = BlocProvider.of<EmployeeBloc>(context);
    employeeBloc.add(GetEmployee());
    WidgetsBinding.instance.addPostFrameCallback((Duration timeStamp) {
      employeeBloc.stream.listen((EmployeeState state) => (mounted
          ? onEmployeeBlocChange(context: context, state: state)
          : null));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return BlocBuilder<EmployeeBloc, EmployeeState>(
        builder: (BuildContext context, EmployeeState state) {
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
                'Employee',
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
                        child: Text('Employe',
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
                    employeeBloc.getEmployeeSuccess.employee?.length ?? 0,
                        (int index) => DataRow(
                      onLongPress: (){
                        employeeBloc.add(GetEmployeeTasks(employee: employeeBloc.getEmployeeSuccess.employee?[index]));
                      },
                      cells: <DataCell>[
                        DataCell(Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            child: Text(employeeBloc.getEmployeeSuccess.employee?[index].name ?? '',
                                style: textTheme.bodySmall?.copyWith(
                                    color: colorScheme.secondary,
                                    fontSize: 5.sp)))),
                        DataCell(Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            child: Text('${employeeBloc.getEmployeeSuccess.employee?[index].activeTask ?? 0}',
                                style: textTheme.bodySmall?.copyWith(
                                    color: colorScheme.secondary,
                                    fontSize: 5.sp)))),
                        DataCell(Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            child: Text('${employeeBloc.getEmployeeSuccess.employee?[index].completedTask ?? 0}',
                                style: textTheme.bodySmall?.copyWith(
                                    color: colorScheme.secondary,
                                    fontSize: 5.sp)))),
                        DataCell(Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            child: Text(employeeBloc.getEmployeeSuccess.employee?[index].lastUpdate ?? '',
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
