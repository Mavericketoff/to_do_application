import 'package:flutter/material.dart';

import 'enums/enviroment.dart';

class EnviromentWindow extends StatelessWidget {
  const EnviromentWindow(
      {required this.child, required this.environment, super.key});

  final Widget child;
  final Environment environment;
  @override
  Widget build(BuildContext context) {
    Widget bannerChild;
    switch (environment) {
      case Environment.production:
        bannerChild = child;
        break;
      case Environment.development:
        bannerChild = Directionality(
          textDirection: TextDirection.ltr,
          child: Banner(
            message: 'DEV',
            location: BannerLocation.topEnd,
            child: child,
          ),
        );
        break;
    }
    return bannerChild;
  }
}
