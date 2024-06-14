part of 'employee_bloc.dart';

abstract class EmployeeState extends ErrorState {}

class EmployeeInitial extends EmployeeState {}

class EmployeeLoading extends EmployeeState {}

class EmployeeError extends EmployeeState {}

class GetEmployeeSuccess extends EmployeeState {
  GetEmployeeSuccess({this.employee});

  List<Employee>? employee;
}

class GetEmployeeTasksSuccess extends EmployeeState {
  GetEmployeeTasksSuccess({this.tasks, this.employee});

  List<Task>? tasks;
  Employee? employee;
}
