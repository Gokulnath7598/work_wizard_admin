import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import '../../core/utils/app_assets.dart';
import 'widget_helper.dart';

class CommonButton extends StatelessWidget {
  const CommonButton(
      {super.key,
      this.customKey,
      this.onPressed,
      required this.text,
      this.isRedText = false,
      this.loadingText = 'Loading...',
      this.isLoading = false});

  final void Function()? onPressed;
  final String text;
  final String loadingText;
  final bool isRedText;
  final bool isLoading;
  final Key? customKey;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    final TextTheme textTheme = Theme.of(context).textTheme;
    return isLoading
        ? Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: Text(loadingText, style: textTheme.bodyMedium),
          )
        : Padding(
            padding: const EdgeInsets.all(20),
            child: ElevatedButton(
                key: customKey,
                onPressed: onPressed,
                style: ElevatedButton.styleFrom(
                    backgroundColor: colorScheme.secondary),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(text,
                        style: textTheme.bodyMedium?.copyWith(
                            color: isRedText ? colorScheme.error : null)),
                  ],
                )),
          );
  }
}

class MSLoginButton extends StatelessWidget {
  const MSLoginButton(
      {super.key,
      this.onPressed,
      required this.text,
      this.isLoading = false});

  final void Function()? onPressed;
  final String text;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return isLoading
        ? Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(100)),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: CupertinoActivityIndicator(color: colorScheme.secondary),
            ))
        : InkWell(
            onTap: onPressed,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(100)),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    // Image.asset(AppAssets.ms, height: 24),
                    Lottie.asset('assets/microsoft.json', height: 30),
                    getSpace(0, 8),
                    Text(text,
                        style: textTheme.bodySmall?.copyWith(
                            fontSize: 5.sp, fontStyle: FontStyle.italic)),
                  ],
                ),
              ),
            ));
  }
}
