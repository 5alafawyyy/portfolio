class Certificate {
  final String title;
  final String issuer;
  final String? url;

  Certificate({required this.title, required this.issuer, this.url});

  factory Certificate.fromJson(Map<String, dynamic> json) {
    return Certificate(
      title: json['title'],
      issuer: json['issuer'],
      url: json['url'],
    );
  }
}
