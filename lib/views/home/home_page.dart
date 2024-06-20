import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:sidebarx/sidebarx.dart';
import '../../bloc/app_bloc/app_bloc.dart';
import '../../bloc/auth_bloc/auth_bloc.dart';
import '../../core/utils/app_assets.dart';
import '../employee/employee_tab.dart';
import '../projects/projects_tab.dart';
import 'home_tab.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final AppBloc appBloc;
  late final AuthBloc authBloc;
  final SidebarXController _controller = SidebarXController(selectedIndex: 0, extended: false);

  @override
  void initState() {
    appBloc = BlocProvider.of<AppBloc>(context);
    authBloc = BlocProvider.of<AuthBloc>(context);
    WidgetsBinding.instance.addPostFrameCallback((Duration timeStamp) {
      authBloc.stream.listen((AuthState state) => (mounted
          ? onAuthBlocChange(context: context, state: state, appBloc: appBloc)
          : null));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return BlocBuilder<AuthBloc, AuthState>(
        builder: (BuildContext context, AuthState state) {
        return Scaffold(
          body: Row(
            children: <Widget>[
              SidebarX(
                controller: _controller,
                extendedTheme: SidebarXTheme(
                    textStyle: textTheme.bodySmall?.copyWith(color: colorScheme.scrim, fontSize: 6.sp),
                    selectedTextStyle: textTheme.bodySmall?.copyWith(color: colorScheme.secondary, fontSize: 6.sp),
                    hoverTextStyle: textTheme.bodySmall?.copyWith(color: colorScheme.secondary, fontSize: 6.sp, letterSpacing: 2.sp),
                    iconTheme: IconThemeData(color: colorScheme.scrim),
                    hoverIconTheme: IconThemeData(color: colorScheme.secondary),
                    selectedIconTheme: IconThemeData(color: colorScheme.secondary),
                    width: 200,
                    decoration: BoxDecoration(
                      color: colorScheme.surface,
                    ),
                    itemTextPadding: const EdgeInsets.symmetric(horizontal: 10),
                    selectedItemTextPadding: const EdgeInsets.symmetric(horizontal: 10)
                ),
                theme: SidebarXTheme(
                  iconTheme: IconThemeData(color: colorScheme.scrim),
                  hoverIconTheme: IconThemeData(color: colorScheme.secondary),
                  selectedIconTheme: IconThemeData(color: colorScheme.secondary),
                ),
                items: const <SidebarXItem>[
                  SidebarXItem(icon: Icons.home_outlined, label: 'Home'),
                  SidebarXItem(icon: Icons.emoji_objects_sharp, label: 'Projects'),
                  SidebarXItem(icon: Icons.person_search_rounded, label: 'Employee'),
                ],
                footerItems: <SidebarXItem>[
                  SidebarXItem(icon: Icons.logout, label: 'Log Out', onTap: (){
                    authBloc.add(LogOut());
                  }),
                ],
              ),
              Expanded(
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      bottom: 0,
                      right: 0,
                      // child: Image.asset(AppAssets.homeBG, width: 150.sp,),
                      child: Lottie.asset('assets/waves.json', width: 150.sp,),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: HomePageContent(
                        controller: _controller,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }
    );
  }
}

class HomePageContent extends StatelessWidget {
  const HomePageContent({
    super.key,
    required this.controller,
  });

  final SidebarXController controller;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (BuildContext context, Widget? child) {
        switch (controller.selectedIndex) {
          case 0:
            return const HomeTab();
          case 1:
            return const ProjectsTab();
          case 2:
            return const EmployeeTab();
          default:
            return const HomeTab();
        }
      },
    );
  }
}
