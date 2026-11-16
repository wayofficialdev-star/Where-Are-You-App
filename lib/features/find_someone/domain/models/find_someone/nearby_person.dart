import 'package:freezed_annotation/freezed_annotation.dart';

part 'nearby_person.freezed.dart';
part 'nearby_person.g.dart';

/// Someone the user can meet, returned by the Find Someone search.
@freezed
class NearbyPerson with _$NearbyPerson {
  const factory NearbyPerson({
    required String id,
    required String name,
    required String headline,
    required double distanceKm,
  }) = _NearbyPerson;

  factory NearbyPerson.fromJson(Map<String, dynamic> json) =>
      _$NearbyPersonFromJson(json);
}
