class Experience {
  final String role;
  final String company;
  final String duration;
  final List<String> achievements;

  Experience({
    required this.role,
    required this.company,
    required this.duration,
    required this.achievements,
  });

  factory Experience.fromJson(Map<String, dynamic> json) {
    return Experience(
      role: json['role'],
      company: json['company'],
      duration: json['duration'],
      achievements: List<String>.from(json['achievements']),
    );
  }
}
