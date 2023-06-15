import 'package:json_annotation/json_annotation.dart';

enum Significance {
  @JsonValue('none')
  none,
  @JsonValue('low')
  lowPriority,
  @JsonValue('high')
  highPriority
}
