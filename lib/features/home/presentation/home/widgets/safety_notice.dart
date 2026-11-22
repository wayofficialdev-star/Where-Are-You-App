import 'package:app/l10n/l10n.dart';
import 'package:app/shared/shared.dart';
import 'package:flutter/material.dart';

/// Reassurance about distances and meeting in public places.
class SafetyNotice extends StatelessWidget {
  const SafetyNotice({this.isCompact = true, super.key});

  final bool isCompact;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: 12,
        vertical: isCompact ? 9 : 11,
      ),
      decoration: BoxDecoration(
        color: WhereRuBrand.pastelLavender,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.verified_user_rounded,
            size: isCompact ? 14 : 16,
            color: const Color(0xFF4A5BF0),
          ),
          const SizedBox(width: 6),
          Flexible(
            child: Text(
              context.l10n.safetyNotice,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: isCompact ? 11 : 12,
                fontWeight: FontWeight.w500,
                height: 1.3,
                color: const Color(0xFF3F3D6D),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
