import 'package:app/shared/models/models.dart';

abstract class IHomeRepository {
  Future<UserProfile> fetchProfile();

  Future<List<Meeting>> fetchMeetings();
}
