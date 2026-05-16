import 'package:collection/collection.dart';

enum PatientMode {
  create,
  edit,
}

enum ObservationMode {
  create,
  edit,
}

enum BorderSideToCurve {
  TopLeft,
  TopRight,
  BottomLeft,
  BottomRight,
  None,
}

extension FFEnumExtensions<T extends Enum> on T {
  String serialize() => name;
}

extension FFEnumListExtensions<T extends Enum> on Iterable<T> {
  T? deserialize(String? value) =>
      firstWhereOrNull((e) => e.serialize() == value);
}

T? deserializeEnum<T>(String? value) {
  switch (T) {
    case (PatientMode):
      return PatientMode.values.deserialize(value) as T?;
    case (ObservationMode):
      return ObservationMode.values.deserialize(value) as T?;
    case (BorderSideToCurve):
      return BorderSideToCurve.values.deserialize(value) as T?;
    default:
      return null;
  }
}
