import 'package:app/shared/models/models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('IPModel', () {
    test('defaults the country to QA', () {
      expect(const IPModel().country, 'QA');
    });

    test('parses the country from an IPInfo response', () {
      final model = IPModel.fromJson(<String, dynamic>{
        'ip': '103.203.72.206',
        'country': 'IN',
      });

      expect(model.country, 'IN');
      expect(model.toJson()['country'], 'IN');
    });
  });
}
