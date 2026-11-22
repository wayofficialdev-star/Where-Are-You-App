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

  @override
  String get signUpTitleLead => 'Crea tu';

  @override
  String get signUpTitleAccent => 'Cuenta';

  @override
  String get signUpSubtitle =>
      'Únete a Where R U y empieza a hacer nuevos amigos cerca de ti.';

  @override
  String get fullNameLabel => 'Nombre completo';

  @override
  String get emailLabel => 'Correo electrónico';

  @override
  String get passwordLabel => 'Contraseña';

  @override
  String get locationLabel => 'Tu ubicación (opcional)';

  @override
  String get signUpAction => 'Registrarse';

  @override
  String get orContinueWith => 'O continúa con';

  @override
  String get alreadyHaveAccount => '¿Ya tienes una cuenta?';

  @override
  String get logInAction => 'Iniciar sesión';

  @override
  String get back => 'Atrás';

  @override
  String get continueWithGoogle => 'Continuar con Google';

  @override
  String get continueWithApple => 'Continuar con Apple';

  @override
  String get continueWithFacebook => 'Continuar con Facebook';

  @override
  String get showPassword => 'Mostrar contraseña';

  @override
  String get hidePassword => 'Ocultar contraseña';

  @override
  String get fullNameRequired => 'Escribe tu nombre completo';

  @override
  String get emailRequired => 'Escribe tu correo electrónico';

  @override
  String get emailInvalid => 'Escribe un correo electrónico válido';

  @override
  String get passwordRequired => 'Escribe una contraseña';

  @override
  String get passwordTooShort => 'Usa al menos 8 caracteres';

  @override
  String get logInComingSoon =>
      'Iniciar sesión estará disponible cuando la autenticación esté conectada.';

  @override
  String goodMorning(String name) {
    return '¡Buenos días, $name! 👋';
  }

  @override
  String get readyToMakeAPlan => '¿Listo para hacer un plan?';

  @override
  String get matches => 'Coincidencias';

  @override
  String get chat => 'Chat';

  @override
  String get findAMatch => 'Buscar coincidencia';

  @override
  String get findAMatchSubtitle =>
      'Encuentra a alguien cerca que quiera lo mismo, ahora mismo.';

  @override
  String get rightNow => 'Ahora mismo';

  @override
  String get withinOneHour => 'En 1 hora';

  @override
  String get laterToday => 'Más tarde hoy';

  @override
  String get scheduledTime => 'Hora programada';

  @override
  String get coins => 'Monedas';

  @override
  String get meetups => 'Quedadas';

  @override
  String get score => 'Puntuación';

  @override
  String get redeem => 'Canjear';

  @override
  String get whatAreYouUpFor => '¿Qué te apetece?';

  @override
  String get activityTeaCoffee => 'Té / Café';

  @override
  String get activityMovies => 'Cine';

  @override
  String get activityDinner => 'Cena';

  @override
  String get activityWalks => 'Caminatas';

  @override
  String get activityGamesSports => 'Juegos y deportes';

  @override
  String get activityExploreKochi => 'Explorar Kochi';

  @override
  String get activityEvents => 'Eventos';

  @override
  String get activityStudyTogether => 'Estudiar juntos';

  @override
  String get activityCafe => 'Cafetería';

  @override
  String get activityMore => 'Más';

  @override
  String get recentMeetups => 'Quedadas recientes';

  @override
  String get viewHistory => 'Ver historial';

  @override
  String distanceKm(double distance) {
    final intl.NumberFormat distanceNumberFormat =
        intl.NumberFormat.decimalPatternDigits(
          locale: localeName,
          decimalDigits: 1,
        );
    final String distanceString = distanceNumberFormat.format(distance);

    return '$distanceString km';
  }

  @override
  String ratingSummary(double rating, String label) {
    final intl.NumberFormat ratingNumberFormat =
        intl.NumberFormat.decimalPatternDigits(
          locale: localeName,
          decimalDigits: 1,
        );
    final String ratingString = ratingNumberFormat.format(rating);

    return '$ratingString ($label)';
  }

  @override
  String get ratingGreat => '¡Genial!';

  @override
  String get ratingGood => 'Bien';

  @override
  String get safetyNotice =>
      'Distancia aproximada · Quedad en lugares públicos';

  @override
  String aiGreetingTitle(String name) {
    return '¡Hola, $name! 👋';
  }

  @override
  String get aiGreetingBody =>
      '¿Qué te apetece hacer hoy? Buscaré a la persona adecuada para ti.';

  @override
  String get activityGaming => 'Videojuegos';

  @override
  String get activityShopping => 'Compras';

  @override
  String get aiInterestsPrompt =>
      '¡Genial! ¿Sobre qué te interesa hablar? Puedes elegir varias opciones.';

  @override
  String get interestTech => 'Tecnología';

  @override
  String get interestBusiness => 'Negocios';

  @override
  String get interestSports => 'Deportes';

  @override
  String get interestTravel => 'Viajes';

  @override
  String get interestMusic => 'Música';

  @override
  String get interestFood => 'Comida';

  @override
  String get interestMovies => 'Cine';

  @override
  String get interestGaming => 'Videojuegos';

  @override
  String get interestBooks => 'Libros';

  @override
  String get interestArt => 'Arte';

  @override
  String get interestOther => 'Otros';

  @override
  String get next => 'Siguiente';

  @override
  String get aiDistancePrompt =>
      '¿A qué distancia te gustaría quedar con alguien?';

  @override
  String upToDistance(int distance) {
    return 'Hasta $distance km';
  }

  @override
  String distanceTick(int distance) {
    return '$distance km';
  }

  @override
  String get aiTimePrompt => '¿Cuándo tienes pensado quedar?';

  @override
  String get timeNow => 'Ahora';

  @override
  String get timeToday => 'Hoy';

  @override
  String get timeThisWeek => 'Esta semana';

  @override
  String get timeAnytime => 'Cuando sea';

  @override
  String get aiNotePrompt => '¿Algo más que deba saber? (Opcional)';

  @override
  String get noteHint =>
      'Ejemplo: conversación informal,\nsoy nuevo en la ciudad, abierto a quedar en grupo, etc.';

  @override
  String noteCounter(int count) {
    return '$count/100';
  }

  @override
  String get findSomeoneCta => 'Buscar a alguien';

  @override
  String get matchingTitleLine1 => 'Buscando a la';

  @override
  String get matchingTitleLine2Lead => 'persona ';

  @override
  String get matchingTitleLine2Accent => 'adecuada para ti...';

  @override
  String matchingSubtitle(String activity) {
    return 'Nuestra IA está buscando a alguien que también quiera ir a $activity y que coincida con tus intereses.';
  }

  @override
  String get matchingStepInterests =>
      'Buscando personas con intereses similares';

  @override
  String matchingStepDistance(int distance) {
    return 'Comprobando la distancia (a menos de $distance km)';
  }

  @override
  String get matchingStepAvailability => 'Comparando disponibilidad';

  @override
  String get matchingStepAlmost => 'Casi listo...';

  @override
  String get matchFoundTitle => '¡Hemos encontrado a alguien para ti!';

  @override
  String matchFoundSubtitle(String activity) {
    return 'Ambos quieren ir a $activity, comparten intereses similares y están cerca.';
  }

  @override
  String approxDistance(double distance) {
    final intl.NumberFormat distanceNumberFormat =
        intl.NumberFormat.decimalPatternDigits(
          locale: localeName,
          decimalDigits: 1,
        );
    final String distanceString = distanceNumberFormat.format(distance);

    return '~$distanceString km';
  }

  @override
  String approxDistanceAway(double distance) {
    final intl.NumberFormat distanceNumberFormat =
        intl.NumberFormat.decimalPatternDigits(
          locale: localeName,
          decimalDigits: 1,
        );
    final String distanceString = distanceNumberFormat.format(distance);

    return 'a ~$distanceString km';
  }

  @override
  String ageCityLine(int age, String city) {
    return '$age • $city';
  }

  @override
  String get wantsToGoFor => 'Quiere ir a';

  @override
  String get commonInterests => 'Intereses en común';

  @override
  String get connectNow => 'Conectar ahora';

  @override
  String get tryAnotherMatch => 'Probar otra coincidencia';

  @override
  String get noMatchYet =>
      'Aún no hay coincidencias. Ajusta tus preferencias e inténtalo de nuevo.';

  @override
  String get chatOnlineNow => 'En línea ahora';

  @override
  String get chatTodayEvening => 'Hoy, por la tarde';

  @override
  String get chatToday => 'Hoy';

  @override
  String chatMatchedFor(String activity) {
    return 'Hiciste match para $activity';
  }

  @override
  String get chatMatchBannerSubtitle =>
      '¡Siéntete libre de chatear y planear juntos!';

  @override
  String get chatViewMatchDetails => 'Ver detalles del match';

  @override
  String get chatMessageHint => 'Escribe un mensaje...';

  @override
  String get chatSendUnavailable =>
      'La mensajería estará disponible cuando el backend esté conectado.';

  @override
  String get chatCallUnavailable =>
      'Las llamadas estarán disponibles cuando el backend esté conectado.';

  @override
  String get chatCall => 'Llamar';

  @override
  String get chatAddAttachment => 'Adjuntar archivo';

  @override
  String get chatEmoji => 'Emoji';

  @override
  String get chatImage => 'Imagen';

  @override
  String get chatSend => 'Enviar mensaje de voz';

  @override
  String get chatConversationOptions => 'Opciones de conversación';

  @override
  String get chatBlockReport => 'Bloquear y reportar';
}
