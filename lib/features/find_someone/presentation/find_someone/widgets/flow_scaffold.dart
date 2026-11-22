import 'package:app/features/find_someone/find_someone.dart';
import 'package:app/l10n/l10n.dart';
import 'package:app/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hancod_theme/hancod_theme.dart';

/// Common page chrome for the four matchmaking steps: header, scroll area and
/// an optional pinned action bar.
class FlowScaffold extends StatelessWidget {
  const FlowScaffold({
    required this.child,
    this.bottomBar,
    this.onBack,
    super.key,
  });

  final Widget child;
  final Widget? bottomBar;
  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFFDFDFF), Color(0xFFF5F8FF)],
          ),
        ),
        child: SafeArea(
          bottom: false,
          child: LayoutBuilder(
            builder: (context, constraints) {
              final wide = constraints.maxWidth >= 800;
              final maxWidth = wide ? 620.0 : double.infinity;
              final horizontal = wide ? 20.0 : 14.0;

              return Column(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(horizontal, 4, horizontal, 0),
                    child: Center(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: maxWidth),
                        child: FlowHeader(onBack: onBack),
                      ),
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.fromLTRB(
                        horizontal,
                        10,
                        horizontal,
                        16,
                      ),
                      child: Center(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(maxWidth: maxWidth),
                          child: child,
                        ),
                      ),
                    ),
                  ),
                  if (bottomBar != null)
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                        horizontal,
                        4,
                        horizontal,
                        12,
                      ),
                      child: Center(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(maxWidth: maxWidth),
                          child: bottomBar,
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

/// Logo, notifications entry point and the signed-in avatar.
class FlowHeader extends ConsumerWidget {
  const FlowHeader({this.onBack, super.key});

  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userName = ref.watch(
      findSomeoneNotifierProvider.select((state) => state.userName),
    );

    return Row(
      children: [
        if (onBack != null) ...[
          IconButton(
            onPressed: onBack,
            tooltip: context.l10n.back,
            padding: EdgeInsets.zero,
            visualDensity: VisualDensity.compact,
            constraints: const BoxConstraints(minWidth: 34, minHeight: 34),
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 17,
              color: WhereRuBrand.navy,
            ),
          ),
          const SizedBox(width: 4),
        ],
        WhereRuLogo(width: onBack != null ? 74 : 82),
        const Spacer(),
        Semantics(
          button: true,
          label: context.l10n.notifications,
          child: IconButton(
            onPressed: () =>
                context.showSnackBar(context.l10n.notificationsEmpty),
            padding: EdgeInsets.zero,
            visualDensity: VisualDensity.compact,
            icon: const Icon(
              Icons.notifications_none_rounded,
              size: 23,
              color: WhereRuBrand.navy,
            ),
          ),
        ),
        const SizedBox(width: 6),
        Semantics(
          button: true,
          label: context.l10n.profile,
          child: InkWell(
            onTap: () => context.go(AppRouter.profilePath),
            customBorder: const CircleBorder(),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                CircleAvatar(
                  radius: 19,
                  backgroundColor: WhereRuBrand.pastelFor(userName),
                  child: Text(
                    WhereRuBrand.initialsOf(userName),
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: WhereRuBrand.purple,
                    ),
                  ),
                ),
                Positioned(
                  right: 1,
                  bottom: 1,
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: const Color(0xFF22C55E),
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.white, width: 1.8),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
