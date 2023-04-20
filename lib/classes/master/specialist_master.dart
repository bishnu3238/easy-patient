class Specialist {
  final int id;
  final String special_name;
  final String status;

  const Specialist({
    required this.id,
    required this.special_name,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'special_name': special_name,
      'status': status,
    };
  }

  factory Specialist.fromMap(Map<String, dynamic> map) {
    return Specialist(
      id: map['id'] as int,
      special_name: map['special_name'] as String,
      status: map['status'] as String,
    );
  }
}
