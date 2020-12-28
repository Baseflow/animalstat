import '../models/animal_history_record.dart';

extension AnimalHistoryRecordExtension on AnimalHistoryRecord {
  Map<String, dynamic> toJson() {
    return {
      'cage': cage,
      'diagnosis': diagnosis.index,
      'health_status': healthStatus.index,
      // TODO: Implement support for 'seenBy' parameter...
      'seen_by': 'Maurits',
      'seen_on': seenOn,
      'treatment': treatment.index,
      'treatment_enddate': treatmentEndDate,
    };
  }
}
