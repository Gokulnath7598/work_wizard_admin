import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/app_bloc/app_bloc.dart';
import '../../bloc/auth_bloc/auth_bloc.dart';
import '../../core/utils/app_assets.dart';
import '../global_widgets/common_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final AuthBloc authBloc;
  late final AppBloc appBloc;

  @override
  void initState() {
    authBloc = BlocProvider.of<AuthBloc>(context);
    appBloc = BlocProvider.of<AppBloc>(context);
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

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppAssets.loginBG),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: <Widget>[
            const Spacer(),
            Text('WORK WIZARD', style: textTheme.titleLarge?.copyWith(color: colorScheme.secondary, letterSpacing: 50, fontWeight: FontWeight.w900)),
            const Spacer(),
            Row(
              children: <Widget>[
                Image.asset(AppAssets.arrowLeft, height: 20),
                Expanded(child: Text('user friendly ET Sheet reminder and tracker', style: textTheme.bodySmall?.copyWith(color: colorScheme.secondary), textAlign: TextAlign.center)),
                Image.asset(AppAssets.arrowRight, height: 20),
              ],
            ),
            const Spacer(),
            const Spacer(),
            BlocBuilder<AuthBloc, AuthState>(
                builder: (BuildContext context, AuthState state) {
                  return MSLoginButton(
                    onPressed: () {
                      authBloc.add(LoginWithMicrosoft());
                    },
                    text: 'Sign in with Microsoft',
                    isLoading: state is AuthLoading
                  );
                }),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
