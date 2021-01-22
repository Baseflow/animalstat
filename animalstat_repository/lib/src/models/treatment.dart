import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
class Treatment extends Equatable {
  const Treatment(
    this.id,
    this.diagnosisId,
    this.name,
  )   : assert(id != null),
        assert(diagnosisId != null),
        assert(name != null);

  final String id;
  final String diagnosisId;
  final String name;

  @override
  List<Object> get props => [id, diagnosisId, name];

  @override
  bool get stringify => true;
}
