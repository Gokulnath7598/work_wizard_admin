import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/utils/helper_functions.dart';
import '../../api_services/employee_service.dart';
import '../../core/base_bloc/base_bloc.dart';
import '../../core/preference_client/preference_client.dart';
import '../../core/utils/utils.dart';
import '../../models/employee.dart';
import '../../models/project.dart';
import '../../models/task.dart';
import '../../models/token.dart';
import '../../views/global_widgets/toast_helper.dart';
import '../../views/tasks/tasks_page.dart';

part 'employee_event.dart';

part 'employee_state.dart';

class EmployeeBloc extends BaseBloc<EmployeeEvent, EmployeeState> {
  EmployeeBloc() : super(EmployeeInitial());

  final EmployeeService projectsService = EmployeeService();

  GetEmployeeSuccess getEmployeeSuccess = GetEmployeeSuccess();
  GetEmployeeTasksSuccess getEmployeeTasksSuccess = GetEmployeeTasksSuccess();

  FutureOr<void> _getEmployee(
      GetEmployee event, Emitter<EmployeeState> emit) async {
    emit(EmployeeLoading());
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final Token? token =
        await PreferencesClient(prefs: prefs).getUserAccessToken();
    final Map<String, String> headersToApi =
        await Utils.getHeader(token?.accessToken);

    // Remove this
    final List<Employee> employee = <Employee>[
      Employee(
          id: 1,
          name: 'Gokul',
          completedTask: 10,
          activeTask: 20,
          lastUpdate: '23:04:2024 11:00 AM')
    ];

    // UnComment this
    // final List<Employee> employee =
    // await projectsService.getEmployee(headersToApi: headersToApi);
    emit(getEmployeeSuccess..employee = employee);
  }

  FutureOr<void> _getEmployeeTasks(
      GetEmployeeTasks event, Emitter<EmployeeState> emit) async {
    emit(EmployeeLoading());
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final Token? token =
        await PreferencesClient(prefs: prefs).getUserAccessToken();
    final Map<String, String> headersToApi =
        await Utils.getHeader(token?.accessToken);
    final Map<String, dynamic> queryParams = <String, dynamic>{
      'employee_id': event.employee?.id
    };
    // remove this
    final List<Task> tasks = <Task>[
      Task(
          id: 1,
          task: 'QR Page',
          status: 'in_progress',
          time: '10',
          project: Project(id: 1, name: 'VGro'),
          employee: Employee(id: 1, name: 'Gokulnath'),
          createdTime: '23:04:2024 11:00 AM')
    ];
    // UnComment this
    //   final List<Task> tasks =
    //   await projectsService.getEmployeeTasks(headersToApi: headersToApi, queryParams: queryParams);
    emit(getEmployeeTasksSuccess
      ..tasks = tasks
      ..employee = event.employee);
  }

  @override
  Future<void> eventHandlerMethod(
      EmployeeEvent event, Emitter<EmployeeState> emit) async {
    switch (event.runtimeType) {
      case const (GetEmployee):
        return _getEmployee(event as GetEmployee, emit);
      case const (GetEmployeeTasks):
        return _getEmployeeTasks(event as GetEmployeeTasks, emit);
    }
  }

  @override
  EmployeeState getErrorState() {
    return EmployeeError();
  }
}

Future<void> onEmployeeBlocChange(
    {required BuildContext context, required EmployeeState state}) async {
  switch (state.runtimeType) {
    case const (GetEmployeeTasksSuccess):
      final GetEmployeeTasksSuccess currentState =
          state as GetEmployeeTasksSuccess;
      Navigator.push(
          context,
          MaterialPageRoute<dynamic>(
            builder: (_) => TasksPage(
                title: currentState.employee?.name ?? '',
                tasks: currentState.tasks),
          ));
    case const (EmployeeError):
      final EmployeeError currentState = state as EmployeeError;
      if (currentState.forceLogOut) {
        await forceLogOut(context);
      }
      if (context.mounted) {
        ToastHelper.failureToast(
            context: context,
            message: '${currentState.errorCode} : ${currentState.errorMsg}');
      }
  }
}
