import 'package:app/features/chat/chat.dart';
import 'package:app/l10n/l10n.dart';
import 'package:app/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:hancod_theme/hancod_theme.dart';

/// Pastel banner confirming the match and linking to the match details.
class MatchBanner extends StatelessWidget {
  const MatchBanner({
    required this.activity,
    required this.onViewDetails,
    super.key,
  });

  final ChatActivity activity;
  final VoidCallback onViewDetails;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Container(
      padding: const EdgeInsets.fromLTRB(8, 9, 7, 9),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFEDF3FF), Color(0xFFF5F1FF), Color(0xFFFFF0F6)],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: const BoxDecoration(
              color: Color(0xFFDCE9FF),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.shield_outlined,
              size: 16,
              color: WhereRuBrand.blue,
            ),
          ),
          const SizedBox(width: 7),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  l10n.chatMatchedFor(chatActivityLabel(l10n, activity)),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    height: 1.25,
                    color: WhereRuBrand.navy,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  l10n.chatMatchBannerSubtitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 9.8,
                    fontWeight: FontWeight.w400,
                    height: 1.3,
                    color: WhereRuBrand.body,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 5),
          _DetailsButton(onTap: onViewDetails),
        ],
      ),
    );
  }
}

class _DetailsButton extends StatelessWidget {
  const _DetailsButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Semantics(
      button: true,
      child: Material(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        shadowColor: WhereRuBrand.navy.withValues(alpha: .08),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          child: Container(
            padding: const EdgeInsets.fromLTRB(7, 6, 4, 6),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  offset: const Offset(0, 4),
                  blurRadius: 12,
                  color: WhereRuBrand.navy.withValues(alpha: .06),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.place_rounded,
                  size: 12,
                  color: WhereRuBrand.blue,
                ),
                const SizedBox(width: 3),
                Flexible(
                  child: Text(
                    l10n.chatViewMatchDetails,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 9.8,
                      fontWeight: FontWeight.w700,
                      height: 1.2,
                      color: WhereRuBrand.blue,
                    ),
                  ),
                ),
                const Icon(
                  Icons.chevron_right_rounded,
                  size: 12,
                  color: WhereRuBrand.blue,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
