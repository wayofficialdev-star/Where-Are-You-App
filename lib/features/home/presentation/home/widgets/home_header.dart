import 'package:app/l10n/l10n.dart';
import 'package:app/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:hancod_theme/hancod_theme.dart';

/// Where RU logo, chat entry point, avatar and the greeting copy.
class HomeHeader extends StatelessWidget {
  const HomeHeader({
    required this.displayName,
    required this.unreadChats,
    required this.onChatTap,
    required this.onProfileTap,
    this.isCompact = true,
    super.key,
  });

  final String displayName;
  final int unreadChats;
  final VoidCallback onChatTap;
  final VoidCallback onProfileTap;
  final bool isCompact;

  @override
  Widget build(BuildContext context) {
    final avatarRadius = isCompact ? 21.0 : 23.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            WhereRuLogo(width: isCompact ? 84 : 96),
            const Spacer(),
            _ChatButton(
              unreadChats: unreadChats,
              isCompact: isCompact,
              onTap: onChatTap,
            ),
            SizedBox(width: isCompact ? 8 : 12),
            Semantics(
              button: true,
              label: context.l10n.profile,
              child: InkWell(
                onTap: onProfileTap,
                customBorder: const CircleBorder(),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    CircleAvatar(
                      radius: avatarRadius,
                      backgroundColor: WhereRuBrand.pastelFor(displayName),
                      child: Text(
                        WhereRuBrand.initialsOf(displayName),
                        style: TextStyle(
                          fontSize: isCompact ? 15 : 16,
                          fontWeight: FontWeight.w700,
                          color: WhereRuBrand.purple,
                        ),
                      ),
                    ),
                    Positioned(
                      right: 1,
                      bottom: 1,
                      child: Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: const Color(0xFF22C55E),
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.white, width: 2),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: isCompact ? 14 : 18),
        Text(
          context.l10n.goodMorning(displayName),
          style: TextStyle(
            fontSize: isCompact ? 24 : 30,
            fontWeight: FontWeight.w800,
            height: 1.2,
            letterSpacing: isCompact ? -.5 : -.9,
            color: WhereRuBrand.navy,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          context.l10n.readyToMakeAPlan,
          style: TextStyle(
            fontSize: isCompact ? 13.5 : 15,
            fontWeight: FontWeight.w400,
            height: 1.4,
            color: WhereRuBrand.body,
          ),
        ),
      ],
    );
  }
}

class _ChatButton extends StatelessWidget {
  const _ChatButton({
    required this.unreadChats,
    required this.isCompact,
    required this.onTap,
  });

  final int unreadChats;
  final bool isCompact;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final icon = Icon(
      Icons.chat_bubble_outline_rounded,
      size: isCompact ? 23 : 25,
      color: WhereRuBrand.navy,
    );

    return Semantics(
      button: true,
      label: context.l10n.chat,
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: Padding(
          padding: const EdgeInsets.all(6),
          child: unreadChats > 0
              ? Badge.count(
                  count: unreadChats,
                  backgroundColor: WhereRuBrand.danger,
                  textColor: AppColors.white,
                  smallSize: 16,
                  child: icon,
                )
              : icon,
        ),
      ),
    );
  }
}
