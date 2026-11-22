import 'package:app/features/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Phone layout: one scrollable column inside the white dashboard surface.
class HomeScreenMobile extends ConsumerWidget {
  const HomeScreenMobile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: HomeBackdrop(
        child: SafeArea(
          bottom: false,
          child: RefreshIndicator(
            onRefresh: () => ref.read(homeNotifierProvider.notifier).refresh(),
            child: const SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.fromLTRB(12, 8, 12, 16),
              child: HomeSurface(child: HomeBody(isCompact: true)),
            ),
          ),
        ),
      ),
    );
  }
}
