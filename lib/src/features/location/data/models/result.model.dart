// ignore_for_file: invalid_annotation_target

import 'package:fl_location/src/features/location/domain/entities/result.entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'result.model.freezed.dart';
part 'result.model.g.dart';

@freezed
// ignore: must_be_immutable
class ResultModel with _$ResultModel {
  ResultModel._();
  factory ResultModel({
    @Default(false) bool ok,
  }) = _ResultModel;

  factory ResultModel.fromJson(Map<String, dynamic> json) =>
      _$ResultModelFromJson(json);
  ResultEntity get toEntity => ResultEntity(ok: ok);
}
