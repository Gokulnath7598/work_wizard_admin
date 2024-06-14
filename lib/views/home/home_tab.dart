import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../bloc/app_bloc/app_bloc.dart';
import '../../models/projects.dart';
import '../global_widgets/widget_helper.dart';

final List<Project> projects = <Project>[Project(id: 1, name: 'VGro'),Project(id: 1, name: 'Rise'),Project(id: 1, name: 'FinoBuddy')];
List<Project> _selectedProjects = <Project>[];

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  late final AppBloc appBloc;
  final TextEditingController _controller = TextEditingController();

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
          children: [
            ...List.generate(_selectedProjects.length, (int index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: InkWell(
                onTap: (){
                  setState(() {
                    _selectedProjects.remove(_selectedProjects[index]);
                  });
                },
                child: Container(
                    decoration: BoxDecoration(
                        color: colorScheme.secondary,
                      borderRadius: BorderRadius.circular(8)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                      child: Row(
                        children: <Widget>[
                          Text(_selectedProjects[index].name ?? '', style: textTheme.bodySmall?.copyWith(color: colorScheme.scrim, fontSize: 5.sp)),
                          getSpace(0, 5),
                          Icon(Icons.close, color: colorScheme.scrim)
                        ],
                      ),
                    )),
              ),
            )),
          ],
        ),
      ],
    );
  }
  void _showMultiSelectDropdown(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final ColorScheme colorScheme = Theme.of(context).colorScheme;
        final TextTheme textTheme = Theme.of(context).textTheme;
        return StatefulBuilder(
          builder: (BuildContext context, setState) {
            return AlertDialog(
              title: const Text('Select Working Projects'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: projects.map((Project project) {
                    return CheckboxListTile(
                      value: _selectedProjects.contains(project),
                      title: Text(project.name ?? '', style: textTheme.bodySmall?.copyWith(color: colorScheme.shadow, fontSize: 5.sp)),
                      onChanged: (bool? value) {
                        if (value != null) {

                          this.setState(() {
                            setState(() {
                              if (value) {
                                _selectedProjects.add(project);
                              } else {
                                _selectedProjects.remove(project);
                              }
                            });
                          });
                        }
                      },
                    );
                  }).toList(),
                ),
              ),
              actions: [
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }
}
