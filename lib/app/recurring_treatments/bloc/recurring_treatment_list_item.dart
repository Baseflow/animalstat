import 'recurring_treatments_bloc.dart';

enum RecurringTreatmentListItemTypes {
  header,
  card,
}

class RecurringTreatmentListItem {
  final RecurringTreatmentListItemTypes type;
  final int cageId;
  final RecurringTreatmentCardState recurringTreatment;

  RecurringTreatmentListItem(this.type, this.cageId, this.recurringTreatment);
}
