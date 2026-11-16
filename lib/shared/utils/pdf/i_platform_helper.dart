import 'package:app/shared/utils/pdf/platform_helper.dart'
    if (dart.library.html) './web_platform.dart'
    if (dart.library.io) './other_platform.dart';
import 'package:pdf/widgets.dart';

abstract class IPdfPlatform {
  factory IPdfPlatform() => getInstance();
  Future<void> savePdf(Document pdf, {bool print = false});
}
