import 'package:app/app/app.dart';
import 'package:app/bootstrap.dart';
import 'package:app/env.dart';
// import 'package:app/firebase_options_prod.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:scaled_app/scaled_app.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:timezone/data/latest.dart' as tz;

Future<void> main() async {
  tz.initializeTimeZones();

  // for scaling purposes, if required use the below code
  ScaledWidgetsFlutterBinding.ensureInitialized(
    scaleFactor: (deviceSize) {
      const widthOfDesign = 375;
      return deviceSize.width / widthOfDesign;
    },
  );

  // In case ScaledWidgetsFlutterBinding is not used
  // WidgetsFlutterBinding.ensureInitialized();

  // For analytics
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );

  // Used to remove trailing # in urls.
  // PathUrlStrategy is const on non-web and non-const on web, so the analyzer
  // suggests a const that does not compile for web. Keep it non-const.
  // ignore: prefer_const_constructors
  setUrlStrategy(PathUrlStrategy());

  // Envrionment
  const env = ProductionEnv();

  // Supabase config
  await Supabase.initialize(
    url: env.SERVER_URL,
    // The anon key is Supabase's publishable client key.
    publishableKey: env.ANON_KEY,
    debug: false,
  );

  await bootstrap(() => App(environment: env));
}
