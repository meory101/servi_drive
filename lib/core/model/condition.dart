class PreferredCondition {
  PreferredCondition({
    String? id,
    String? name,
    bool? isActive,
    int? displayOrder,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _name = name;
    _isActive = isActive;
    _displayOrder = displayOrder;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  PreferredCondition.fromJson(Map<String, dynamic> json) {
    _id = json['_id'];
    _name = json['name'];
    _isActive = json['isActive'];
    _displayOrder = json['displayOrder'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
  }

  String? _id;
  String? _name;
  bool? _isActive;
  int? _displayOrder;
  String? _createdAt;
  String? _updatedAt;

  String? get id => _id;
  String? get name => _name;
  bool? get isActive => _isActive;
  int? get displayOrder => _displayOrder;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    return {
      '_id': _id,
      'name': _name,
      'isActive': _isActive,
      'displayOrder': _displayOrder,
      'createdAt': _createdAt,
      'updatedAt': _updatedAt,
    };
  }
}
