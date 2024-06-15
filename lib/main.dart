import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nested/nested.dart';
import 'app_config.dart';
import 'bloc/app_bloc/app_bloc.dart';
import 'bloc/auth_bloc/auth_bloc.dart';
import 'bloc/employee_bloc/employee_bloc.dart';
import 'bloc/home_bloc/home_bloc.dart';
import 'bloc/projects_bloc/projects_bloc.dart';
import 'core/base_bloc/base_bloc.dart';
import 'firebase_options.dart';
import 'theme.dart';
import 'views/auth/init_page.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  AppConfig.initiate();

  await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
  ]);

  await ScreenUtil.ensureScreenSize();

  Bloc.observer = AppBlocObserver();

  runApp(MultiBlocProvider(providers: <SingleChildWidget>[
    BlocProvider<AppBloc>(create: (BuildContext context) => AppBloc()),
    BlocProvider<AuthBloc>(create: (BuildContext context) => AuthBloc()),
    BlocProvider<ProjectsBloc>(create: (BuildContext context) => ProjectsBloc()),
    BlocProvider<EmployeeBloc>(create: (BuildContext context) => EmployeeBloc()),
    BlocProvider<HomeBloc>(create: (BuildContext context) => HomeBloc()),
  ], child: const App()));
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  AppState createState() => AppState();
}

class AppState extends State<App> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _init();
  }

  Future<void> _init() async {}

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(390, 835),
        builder: (_, Widget? child) {
          return MaterialApp(
            navigatorKey: navigatorKey,
            theme: themeData,
            home: const InitPage(),
            debugShowCheckedModeBanner:
                AppConfig.shared.flavor == Flavor.staging,
          );
        });
  }
}
