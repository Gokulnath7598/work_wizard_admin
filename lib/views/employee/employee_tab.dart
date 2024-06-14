import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../bloc/app_bloc/app_bloc.dart';
import '../../models/employee.dart';
import '../global_widgets/widget_helper.dart';
import '../tasks/tasks_page.dart';

final List<Employee> employee = <Employee>[
  Employee(id: 1, name: 'Gokul', completedTask: 10, activeTask: 20, lastUpdate: '23:04:2024 11:00 AM'),
  Employee(id: 1, name: 'Syed', completedTask: 0, activeTask: 10, lastUpdate: '27:04:2024 11:00 AM'),
  Employee(id: 1, name: 'Josuhua', completedTask: 0, activeTask: 10, lastUpdate: '27:04:2024 11:00 AM'),
  Employee(id: 1, name: 'Yazhini', completedTask: 8, activeTask: 50, lastUpdate: '23:08:2023 11:00 AM')];

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
                employee.length,
                    (int index) => DataRow(
                  onLongPress: (){
                    Navigator.push(context, MaterialPageRoute<dynamic>(builder:  (_) => TasksPage(title: employee[index].name ?? '')));
                  },
                  cells: <DataCell>[
                    DataCell(Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        child: Text(employee[index].name ?? '',
                            style: textTheme.bodySmall?.copyWith(
                                color: colorScheme.secondary,
                                fontSize: 5.sp)))),
                    DataCell(Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        child: Text('${employee[index].activeTask ?? 0}',
                            style: textTheme.bodySmall?.copyWith(
                                color: colorScheme.secondary,
                                fontSize: 5.sp)))),
                    DataCell(Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        child: Text('${employee[index].completedTask ?? 0}',
                            style: textTheme.bodySmall?.copyWith(
                                color: colorScheme.secondary,
                                fontSize: 5.sp)))),
                    DataCell(Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        child: Text(employee[index].lastUpdate ?? '',
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
}
