import 'package:app/shared/shared.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hancod_theme/hancod_theme.dart';

/// Circular avatar for the chat participant.
///
/// The backend does not provide photos yet, so an empty [avatarUrl] falls back
/// to the initials avatar used across the rest of the app. When a URL exists it
/// is loaded through the project's [CachedNetworkImageProvider].
class ChatAvatar extends StatelessWidget {
  const ChatAvatar({
    required this.name,
    this.avatarUrl,
    this.size = 52,
    this.showOnlineDot = false,
    super.key,
  });

  final String name;
  final String? avatarUrl;
  final double size;
  final bool showOnlineDot;

  @override
  Widget build(BuildContext context) {
    final hasPhoto = avatarUrl != null && avatarUrl!.isNotEmpty;

    final avatar = CircleAvatar(
      radius: size / 2,
      backgroundColor: WhereRuBrand.pastelFor(name),
      backgroundImage: hasPhoto ? CachedNetworkImageProvider(avatarUrl!) : null,
      child: hasPhoto
          ? null
          : Text(
              WhereRuBrand.initialsOf(name),
              style: TextStyle(
                fontSize: size * .34,
                fontWeight: FontWeight.w700,
                color: WhereRuBrand.purple,
              ),
            ),
    );

    if (!showOnlineDot) return avatar;

    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          avatar,
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              width: size * .26,
              height: size * .26,
              decoration: BoxDecoration(
                color: const Color(0xFF22C55E),
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.white, width: 2),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
