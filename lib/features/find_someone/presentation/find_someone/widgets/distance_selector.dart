import 'package:app/l10n/l10n.dart';
import 'package:app/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:hancod_theme/hancod_theme.dart';

/// Discrete distance selector: 1, 5, 10, 20 and 50 km.
class DistanceSelector extends StatelessWidget {
  const DistanceSelector({
    required this.distanceKm,
    required this.onChanged,
    super.key,
  });

  static const List<double> options = [1, 5, 10, 20, 50];

  final double distanceKm;
  final ValueChanged<double> onChanged;

  int get _index {
    final index = options.indexWhere(
      (option) => (option - distanceKm).abs() < .01,
    );
    return index == -1 ? 2 : index;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final radius = BorderRadius.circular(18);

    return Container(
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 10),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: radius,
        border: Border.all(color: WhereRuBrand.fieldBorder),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  l10n.upToDistance(distanceKm.round()),
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: WhereRuBrand.navy,
                  ),
                ),
              ),
              Text(
                l10n.distanceTick(distanceKm.round()),
                style: const TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w600,
                  color: WhereRuBrand.blue,
                ),
              ),
            ],
          ),
          const SizedBox(height: 2),
          Row(
            children: [
              const Icon(
                Icons.place_rounded,
                size: 18,
                color: WhereRuBrand.blue,
              ),
              const SizedBox(width: 4),
              Expanded(
                child: SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    trackHeight: 4,
                    activeTrackColor: WhereRuBrand.purple,
                    inactiveTrackColor: const Color(0xFFE4E8F5),
                    thumbColor: WhereRuBrand.blue,
                    overlayColor: WhereRuBrand.blue.withValues(alpha: .12),
                    thumbShape: const RoundSliderThumbShape(
                      enabledThumbRadius: 9,
                    ),
                    overlayShape: const RoundSliderOverlayShape(
                      overlayRadius: 18,
                    ),
                  ),
                  child: Slider(
                    value: _index.toDouble(),
                    max: (options.length - 1).toDouble(),
                    divisions: options.length - 1,
                    onChanged: (value) => onChanged(options[value.round()]),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 22, right: 22),
            child: Row(
              children: [
                // Equal shares keep the labels under their slider ticks and
                // let them shrink instead of overflowing on narrow phones.
                for (var i = 0; i < options.length; i++)
                  Expanded(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: i == 0
                          ? Alignment.centerLeft
                          : i == options.length - 1
                          ? Alignment.centerRight
                          : Alignment.center,
                      child: Text(
                        l10n.distanceTick(options[i].round()),
                        style: const TextStyle(
                          fontSize: 9.5,
                          fontWeight: FontWeight.w400,
                          color: WhereRuBrand.hint,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
