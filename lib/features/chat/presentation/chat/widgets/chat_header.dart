import 'package:app/l10n/l10n.dart';
import 'package:app/shared/shared.dart';
import 'package:flutter/material.dart';

/// Actions available from the header overflow menu.
enum ChatMenuAction { viewDetails, blockReport }

/// Back arrow, Where RU logo, call button and overflow menu.
class ChatHeader extends StatelessWidget {
  const ChatHeader({
    required this.onBack,
    required this.onCall,
    required this.onMenuAction,
    super.key,
  });

  final VoidCallback onBack;
  final VoidCallback onCall;
  final ValueChanged<ChatMenuAction> onMenuAction;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 6, 6, 4),
      child: Row(
        children: [
          IconButton(
            onPressed: onBack,
            tooltip: l10n.back,
            padding: EdgeInsets.zero,
            visualDensity: VisualDensity.compact,
            constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 17,
              color: WhereRuBrand.navy,
            ),
          ),
          const SizedBox(width: 4),
          const WhereRuLogo(width: 84),
          const Spacer(),
          _HeaderCircleButton(
            icon: Icons.phone_outlined,
            label: l10n.chatCall,
            onTap: onCall,
          ),
          const SizedBox(width: 2),
          PopupMenuButton<ChatMenuAction>(
            onSelected: onMenuAction,
            tooltip: l10n.chatConversationOptions,
            icon: const Icon(
              Icons.more_vert_rounded,
              size: 20,
              color: WhereRuBrand.navy,
            ),
            itemBuilder: (context) => [
              PopupMenuItem(
                value: ChatMenuAction.viewDetails,
                child: Text(l10n.chatViewMatchDetails),
              ),
              PopupMenuItem(
                value: ChatMenuAction.blockReport,
                child: Text(l10n.chatBlockReport),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _HeaderCircleButton extends StatelessWidget {
  const _HeaderCircleButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: label,
      child: Material(
        color: WhereRuBrand.pastelLavender,
        shape: const CircleBorder(),
        child: InkWell(
          onTap: onTap,
          customBorder: const CircleBorder(),
          child: SizedBox(
            width: 38,
            height: 38,
            child: Icon(icon, size: 18, color: WhereRuBrand.navy),
          ),
        ),
      ),
    );
  }
}
