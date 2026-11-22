import 'package:app/l10n/l10n.dart';
import 'package:app/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:hancod_theme/hancod_theme.dart';

/// Bottom message composer.
///
/// Sending, attachments, emoji and voice are placeholders until the backend
/// exists; every action reports that instead of pretending a message was sent.
class ChatComposer extends StatefulWidget {
  const ChatComposer({required this.onSend, required this.onMic, super.key});

  final ValueChanged<String> onSend;
  final VoidCallback onMic;

  @override
  State<ChatComposer> createState() => _ChatComposerState();
}

class _ChatComposerState extends State<ChatComposer> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submit() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    widget.onSend(text);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    void unavailable() =>
        context.showSnackBar(context.l10n.chatSendUnavailable);

    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 4, 10, 10),
      child: Row(
        children: [
          _ComposerCircle(
            icon: Icons.add_rounded,
            label: l10n.chatAddAttachment,
            onTap: unavailable,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Container(
              height: 46,
              padding: const EdgeInsets.only(left: 12, right: 2),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(23),
                border: Border.all(color: WhereRuBrand.fieldBorder),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      textInputAction: TextInputAction.send,
                      onSubmitted: (_) => _submit(),
                      style: const TextStyle(
                        fontSize: 12.5,
                        color: WhereRuBrand.navy,
                      ),
                      decoration: InputDecoration(
                        isCollapsed: true,
                        border: InputBorder.none,
                        hintText: l10n.chatMessageHint,
                        hintStyle: const TextStyle(
                          fontSize: 12.5,
                          color: WhereRuBrand.hint,
                        ),
                      ),
                    ),
                  ),
                  _ComposerIcon(
                    icon: Icons.emoji_emotions_outlined,
                    label: l10n.chatEmoji,
                    onTap: unavailable,
                  ),
                  _ComposerIcon(
                    icon: Icons.image_outlined,
                    label: l10n.chatImage,
                    onTap: unavailable,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 8),
          Semantics(
            button: true,
            label: l10n.chatSend,
            child: Container(
              width: 46,
              height: 46,
              decoration: const BoxDecoration(
                gradient: WhereRuBrand.gradient,
                shape: BoxShape.circle,
              ),
              child: Material(
                color: Colors.transparent,
                shape: const CircleBorder(),
                child: InkWell(
                  onTap: widget.onMic,
                  customBorder: const CircleBorder(),
                  child: const Icon(
                    Icons.mic_rounded,
                    size: 22,
                    color: AppColors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ComposerCircle extends StatelessWidget {
  const _ComposerCircle({
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
            width: 44,
            height: 44,
            child: Icon(icon, size: 22, color: WhereRuBrand.blue),
          ),
        ),
      ),
    );
  }
}

class _ComposerIcon extends StatelessWidget {
  const _ComposerIcon({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTap,
      tooltip: label,
      padding: EdgeInsets.zero,
      visualDensity: VisualDensity.compact,
      constraints: const BoxConstraints(minWidth: 26, minHeight: 26),
      iconSize: 18,
      color: WhereRuBrand.hint,
      icon: Icon(icon),
    );
  }
}
