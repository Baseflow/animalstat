import '../models/animal_history_record.dart';

extension AnimalHistoryRecordExtension on AnimalHistoryRecord {
  Map<String, dynamic> toJson() {
    return {
      'cage': cage,
      'diagnosis': diagnosis != null
          ? <String, String>{
              'id': diagnosis.id,
              'name': diagnosis.name,
            }
          : null,
      'health_status': healthStatus.index,
      'seen_by': <String, String>{
        'user_id': seenBy.userId,
        'user_name': seenBy.userName,
      },
      'seen_on': seenOn,
      'treatment': treatment != null
          ? <String, String>{
              'id': treatment.id,
              'diagnosis_id': treatment.diagnosisId,
              'name': treatment.name,
            }
          : null,
      'treatment_enddate': treatmentEndDate,
    };
  }
}
