class Project {
  final String name;
  final String description;
  final List<String> tech;
  final Map<String, String> links; // e.g. {'Google Play': url, 'GitHub': url}
  final List<String> screenshots; // asset or network URLs
  final String iconUrl;

  Project({
    required this.name,
    required this.description,
    required this.tech,
    required this.links,
    required this.screenshots,
    required this.iconUrl,
  });

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      name: json['name'],
      description: json['description'],
      tech: List<String>.from(json['tech']),
      links: Map<String, String>.from(json['links']),
      screenshots: List<String>.from(json['screenshots']),
      iconUrl: json['icon_url'],
    );
  }
}
