import 'package:app/features/home/domain/models/home_models.dart';
import 'package:app/shared/models/models.dart';

abstract class IHomeRepository {
  Future<UserProfile> fetchProfile();

  Future<List<Meeting>> fetchMeetings();

  /// Counters for the home stats card (meetups, score).
  Future<HomeSummary> fetchSummary();
}
