import 'package:app/features/home/presentation/home/home_mobile.dart';
import 'package:app/features/home/presentation/home/home_web.dart';
import 'package:app/shared/shared.dart';
import 'package:flutter/material.dart';

export 'home_mobile.dart';
export 'home_web.dart';
export 'widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ResponsiveWidget(
      smallScreen: HomeScreenMobile(),
      largeScreen: HomeScreenWeb(),
    );
  }
}
