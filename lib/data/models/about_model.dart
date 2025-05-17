class About {
  final String section;
  final String content;
  final List<String>? skills;

  About({required this.section, required this.content, this.skills});

  factory About.fromJson(Map<String, dynamic> json) {
    return About(
      section: json['section'] as String,
      content: json['content'] as String,
      skills:
          json['skills'] != null
              ? List<String>.from(json['skills'] as List)
              : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'section': section,
      'content': content,
      if (skills != null) 'skills': skills,
    };
  }
}
