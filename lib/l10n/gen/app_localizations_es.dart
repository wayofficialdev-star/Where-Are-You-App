// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get home => 'Inicio';

  @override
  String get findSomeone => 'ENCONTRAR A ALGUIEN';

  @override
  String get findSomeoneSubtitle =>
      'Busca personas cerca de ti y comienza tu próxima reunión.';

  @override
  String get findSomeoneTitle => 'Encontrar a alguien';

  @override
  String get meetingHistory => 'Historial de reuniones';

  @override
  String get seeAll => 'Ver todo';

  @override
  String levelLabel(int level) {
    return 'Nivel $level';
  }

  @override
  String xpValue(int xp) {
    return '$xp XP';
  }

  @override
  String coinsValue(int coins) {
    return '$coins Monedas';
  }

  @override
  String xpToNextLevel(int xp) {
    return '$xp XP para el siguiente nivel';
  }

  @override
  String homeGreeting(String name) {
    return '¡Hola, $name!';
  }

  @override
  String get notifications => 'Notificaciones';

  @override
  String get notificationsEmpty => 'Aún no hay notificaciones nuevas.';

  @override
  String get meetings => 'Reuniones';

  @override
  String get profile => 'Perfil';

  @override
  String get retry => 'Reintentar';

  @override
  String get somethingWentWrong => 'Algo salió mal. Inténtalo de nuevo.';

  @override
  String get searchPeopleHint => 'Busca por nombre o interés';

  @override
  String get noPeopleNearby => 'Aún no hay nadie cerca. Prueba otra búsqueda.';

  @override
  String kmAway(double distance) {
    return 'A $distance km';
  }

  @override
  String get noMeetingsYet => 'Tus reuniones aparecerán aquí.';

  @override
  String get backendNotConnected =>
      'Esta acción estará disponible cuando el backend esté conectado.';
}
