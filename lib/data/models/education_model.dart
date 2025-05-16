class Education {
  final String degree;
  final String institution;
  final String duration;

  Education({
    required this.degree,
    required this.institution,
    required this.duration,
  });

  factory Education.fromJson(Map<String, dynamic> json) {
    return Education(
      degree: json['degree'],
      institution: json['institution'],
      duration: json['duration'],
    );
  }
}
