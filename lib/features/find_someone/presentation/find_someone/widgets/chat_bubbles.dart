import 'package:app/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:hancod_theme/hancod_theme.dart';

/// Small robot mark that introduces an assistant message.
class AiAvatar extends StatelessWidget {
  const AiAvatar({this.size = 30, super.key});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: WhereRuBrand.pastelBlue,
        borderRadius: BorderRadius.circular(size * .34),
        border: Border.all(color: WhereRuBrand.fieldBorder),
      ),
      child: Icon(
        Icons.smart_toy_rounded,
        size: size * .58,
        color: WhereRuBrand.blue,
      ),
    );
  }
}

/// Bubble used by the matchmaking assistant.
class AssistantMessage extends StatelessWidget {
  const AssistantMessage(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AiAvatar(),
        const SizedBox(width: 8),
        Flexible(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
            decoration: const BoxDecoration(
              color: Color(0xFFF3F1FE),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(4),
                topRight: Radius.circular(16),
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 12.5,
                fontWeight: FontWeight.w400,
                height: 1.45,
                color: WhereRuBrand.navy,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// Right-aligned bubble summarising the user's choice.
class UserMessage extends StatelessWidget {
  const UserMessage({required this.text, required this.displayName, super.key});

  final String text;
  final String displayName;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Flexible(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: const BoxDecoration(
              gradient: WhereRuBrand.selectedPillGradient,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(4),
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 12.5,
                fontWeight: FontWeight.w600,
                height: 1.4,
                color: AppColors.white,
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        CircleAvatar(
          radius: 15,
          backgroundColor: WhereRuBrand.pastelFor(displayName),
          child: Text(
            WhereRuBrand.initialsOf(displayName),
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: WhereRuBrand.purple,
            ),
          ),
        ),
      ],
    );
  }
}
