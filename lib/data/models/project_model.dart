class Project {
  final String name;
  final String description;
  final List<String> tech;
  final Map<String, String> links; // e.g. {'Google Play': url, 'GitHub': url}
  final List<String> screenshots; // asset or network URLs

  Project({
    required this.name,
    required this.description,
    required this.tech,
    required this.links,
    required this.screenshots,
  });
}
