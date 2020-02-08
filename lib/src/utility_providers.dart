import 'package:livestock/src/providers/utility_provider.dart';
import 'package:livestock/src/utilities/utilities.dart';

class UtilityProviders {
  static List<UtilityProvider> get providers => [
        UtilityProvider<Validators>(
          create: (context) => Validators(),
        )
      ];
}