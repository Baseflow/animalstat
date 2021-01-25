import 'treatment_card.dart';

enum TreatmentListItemTypes {
  header,
  card,
}

class TreatmentListItem {
  final TreatmentListItemTypes type;
  final int cageId;
  final TreatmentCard treatmentCard;

  TreatmentListItem(this.type, this.cageId, this.treatmentCard);
}
