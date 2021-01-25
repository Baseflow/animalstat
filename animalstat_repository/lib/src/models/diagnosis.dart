import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
class Diagnosis extends Equatable {
  const Diagnosis(this.id, this.name)
      : assert(id != null),
        assert(name != null);

  final String id;
  final String name;

  @override
  List<Object> get props => [
        id,
        name,
      ];

  @override
  bool get stringify => true;
}
