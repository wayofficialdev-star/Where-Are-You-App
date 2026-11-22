import 'package:app/features/find_someone/domain/models/find_someone_models.dart';

// Repository interfaces are the project convention, even with a single method.
// ignore: one_member_abstracts
abstract class IFindSomeoneRepository {
  /// Runs the matchmaking query for [preferences].
  Future<MatchedPerson> findMatch(MatchPreferences preferences);
}
