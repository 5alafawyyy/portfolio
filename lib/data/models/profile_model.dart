class Profile {
  final String name;
  final String title;
  final String location;
  final String email;
  final String github;
  final String linkedin;
  final String whatsapp;
  final String cvUrl;
  final String avatarUrl;

  Profile({
    required this.name,
    required this.title,
    required this.location,
    required this.email,
    required this.github,
    required this.linkedin,
    required this.whatsapp,
    required this.cvUrl,
    required this.avatarUrl,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      name: json['name'],
      title: json['title'],
      location: json['location'],
      email: json['email'],
      github: json['github'],
      linkedin: json['linkedin'],
      whatsapp: json['whatsapp'],
      cvUrl: json['cv_url'],
      avatarUrl: json['avatar_url'],
    );
  }
}
