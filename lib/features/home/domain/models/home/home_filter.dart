/// Time windows offered by the home "when" filter.
///
/// Selection is presentation state; the matching query itself is a backend
/// concern that is not implemented yet.
enum HomeFilter { rightNow, withinOneHour, laterToday, scheduledTime }
