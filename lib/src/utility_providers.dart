import 'providers/utility_provider.dart';
import 'utilities/utilities.dart';

List<UtilityProvider> get utilityProviders => [
      UtilityProvider<Validators>(
        create: (context) => Validators(),
      )
    ];
