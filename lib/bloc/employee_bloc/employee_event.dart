part of 'employee_bloc.dart';


@immutable
abstract class EmployeeEvent {}

class GetEmployee extends EmployeeEvent {}

class GetEmployeeTasks extends EmployeeEvent {
  GetEmployeeTasks({this.employee});
  final Employee? employee;
}
