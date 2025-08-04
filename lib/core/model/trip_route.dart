class TripRoute {
  TripRoute({
    String? id,
    String? routeName,
    bool? isActive,
    String? createdAt,
  }) {
    _id = id;
    _routeName = routeName;
    _isActive = isActive;
    _createdAt = createdAt;
  }

  TripRoute.fromJson(Map<String, dynamic> json) {
    _id = json['_id'];
    _routeName = json['routeName'];
    _isActive = json['isActive'];
    _createdAt = json['createdAt'];
  }

  String? _id;
  String? _routeName;
  bool? _isActive;
  String? _createdAt;

  String? get id => _id;
  String? get routeName => _routeName;
  bool? get isActive => _isActive;
  String? get createdAt => _createdAt;

  Map<String, dynamic> toJson() {
    return {
      '_id': _id,
      'routeName': _routeName,
      'isActive': _isActive,
      'createdAt': _createdAt,
    };
  }
}
