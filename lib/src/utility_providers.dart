import 'package:animal_stat/src/providers/utility_provider.dart';
import 'package:animal_stat/src/utilities/utilities.dart';

class UtilityProviders {
  static List<UtilityProvider> get providers => [
        UtilityProvider<Validators>(
          builder: (context) => Validators(),
        )
      ];
}