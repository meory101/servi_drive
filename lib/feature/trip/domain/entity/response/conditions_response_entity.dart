import 'dart:convert';

import '../../../../../../core/model/condition.dart';

PreferredConditionsResponseEntity preferredConditionsResponseEntityFromJson(String str) =>
    PreferredConditionsResponseEntity.fromJson(json.decode(str));

String preferredConditionsResponseEntityToJson(PreferredConditionsResponseEntity data) =>
    json.encode(data.toJson());

class PreferredConditionsResponseEntity {
  PreferredConditionsResponseEntity({
    List<PreferredCondition>? conditions,
  }) {
    _conditions = conditions;
  }

  PreferredConditionsResponseEntity.fromJson(dynamic json) {
    if (json is List) {
      _conditions = json.map((e) => PreferredCondition.fromJson(e)).toList();
    }
  }

  List<PreferredCondition>? _conditions;

  List<PreferredCondition>? get conditions => _conditions;

  Map<String, dynamic> toJson() {
    return {
      'conditions': _conditions?.map((e) => e.toJson()).toList(),
    };
  }
}

