import '../models/animal_health_info.dart';

extension AnimalHealthInfoExtensions on AnimalHealthInfo {
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'diagnosis': diagnosis,
      'health_status': healthStatus.index,
      'updated_on': updatedOn,
    };
  }
}
