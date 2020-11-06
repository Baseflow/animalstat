import 'package:animalstat/src/providers/utility_provider.dart';
import 'package:animalstat/src/utilities/utilities.dart';

class UtilityProviders {
  static List<UtilityProvider> get providers => [
        UtilityProvider<Validators>(
          create: (context) => Validators(),
        )
      ];
}
