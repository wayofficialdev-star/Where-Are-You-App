import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_summary.freezed.dart';

/// Aggregate numbers shown in the home stats card.
///
/// The Supabase contract for these counters is not published yet, so no JSON
/// mapping is defined; the data team can add one when it lands.
@freezed
class HomeSummary with _$HomeSummary {
  const factory HomeSummary({
    @Default(0) int meetupCount,
    @Default(0) double score,
  }) = _HomeSummary;
}
