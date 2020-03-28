import '../../livestock_repository.dart';

extension AnimalHistoryRecordExtension on AnimalHistoryRecord {
  Map<String, dynamic> toJson() {
    return {
      'cage': this.cage,
      'diagnosis': this.diagnosis.index,
      'health_status': this.healthStatus.index,
      // TODO: Implement support for 'seenBy' parameter...
      'seen_by': 'Maurits',
      'seen_on': this.seenOn,
      'treatment': this.treatment.index,
      'treatment_enddate': this.treatmentEndDate,
    };
  }
}
