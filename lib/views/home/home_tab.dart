import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../bloc/app_bloc/app_bloc.dart';
import '../../bloc/home_bloc/home_bloc.dart';
import '../../models/project.dart';
import '../global_widgets/widget_helper.dart';


class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  late final AppBloc appBloc;
  late final HomeBloc homeBloc;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    appBloc = BlocProvider.of<AppBloc>(context);
    homeBloc = BlocProvider.of<HomeBloc>(context);
    homeBloc.add(GetAllProjects());
    homeBloc.add(GetProfile());
    WidgetsBinding.instance.addPostFrameCallback((Duration timeStamp) {
      homeBloc.stream.listen((HomeState state) => (mounted
          ? onHomeBlocChange(context: context, state: state, appBloc: appBloc)
          : null));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return BlocBuilder<AppBloc, AppState>(
        builder: (BuildContext context, AppState state) {
          return BlocBuilder<HomeBloc, HomeState>(
              builder: (BuildContext context, HomeState state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                    'Hi, ${appBloc.stateData.user?.name ?? ''}',
                    style: textTheme.bodySmall?.copyWith(color: colorScheme.secondary, fontSize: 8.sp, fontStyle: FontStyle.italic)),
                getSpace(20, 0),
                Text(
                    'Configure Me!',
                    style: textTheme.bodySmall?.copyWith(color: colorScheme.secondary, fontSize: 7.sp)),
                getSpace(15, 0),
                Text(
                    'Working Projects',
                    style: textTheme.bodySmall?.copyWith(color: colorScheme.secondary, fontSize: 5.sp)),
                getSpace(15, 0),
                GestureDetector(
                  onTap: () {
                    _showMultiSelectDropdown(context);
                  },
                  child: AbsorbPointer(
                    child: SizedBox(
                      height: 40,
                      width: 400,
                      child: TextField(
                        controller: _controller,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: const BorderRadius.all(Radius.circular(8)),
                              borderSide:
                              BorderSide(width: 0.9, color: colorScheme.secondary)),
                          labelText: 'Working Projects',
                          suffixIcon: const Icon(Icons.arrow_drop_down),
                          labelStyle: textTheme.bodySmall?.copyWith(color: colorScheme.shadow, fontSize: 5.sp)
                        ),
                        readOnly: true,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: <Widget>[
                    ...List<Widget>.generate(appBloc.stateData.user?.workingProjects?.length ?? 0, (int index) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Container(
                          decoration: BoxDecoration(
                              color: colorScheme.secondary,
                            borderRadius: BorderRadius.circular(8)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                            child: Row(
                              children: <Widget>[
                                Text(appBloc.stateData.user?.workingProjects?[index].projectName ?? '', style: textTheme.bodySmall?.copyWith(color: colorScheme.scrim, fontSize: 5.sp)),
                              ],
                            ),
                          )),
                    )),
                  ],
                ),
              ],
            );
          }
        );
      }
    );
  }
  void _showMultiSelectDropdown(BuildContext context) {
    showDialog<Widget>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const AllProjectsDropDown();
      },
    );
  }
}

class AllProjectsDropDown extends StatefulWidget {
  const AllProjectsDropDown({super.key});

  @override
  State<AllProjectsDropDown> createState() => _AllProjectsDropDownState();
}

class _AllProjectsDropDownState extends State<AllProjectsDropDown> {
  late final AppBloc appBloc;
  late final HomeBloc homeBloc;
  List<int> selectedProjectIDs = <int>[];


  @override
  void initState() {
    appBloc = BlocProvider.of<AppBloc>(context);
    homeBloc = BlocProvider.of<HomeBloc>(context);

    for(final Project workingProjects in appBloc.stateData.user?.workingProjects ?? <Project>[]){
      selectedProjectIDs.add(workingProjects.id!);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final TextTheme textTheme = Theme.of(context).textTheme;
    return BlocBuilder<AppBloc, AppState>(
        builder: (BuildContext context, AppState state) {
          return BlocBuilder<HomeBloc, HomeState>(
              builder: (BuildContext context, HomeState state) {
                return AlertDialog(
                  title: const Text('Select Working Projects'),
                  content: SingleChildScrollView(
                    child: ListBody(
                      children: homeBloc.getAllProjectsSuccess.allProject!.map((Project project) {
                        return CheckboxListTile(
                          value: selectedProjectIDs.contains(project.id),
                          title: Text(project.projectName ?? '', style: textTheme.bodySmall?.copyWith(color: colorScheme.shadow, fontSize: 5.sp)),
                          onChanged: (bool? value) {
                            if (value != null) {
                              setState(() {
                                if (value) {
                                  selectedProjectIDs.add(project.id!);
                                } else {
                                  selectedProjectIDs.remove(project.id);
                                }
                              });
                            }
                          },
                        );
                      }).toList(),
                    ),
                  ),
                  actions: <Widget>[
                    TextButton(
                      child: const Text('OK'),
                      onPressed: () {
                        homeBloc.add(UpdateProfile(projectIDs: selectedProjectIDs));
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              }
          );
        }
    );
  }
}
