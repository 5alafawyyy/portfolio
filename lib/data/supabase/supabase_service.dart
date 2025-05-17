import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/profile_model.dart';
import '../models/project_model.dart';
import '../models/experience_model.dart';
import '../models/education_model.dart';
import '../models/certificate_model.dart';
import '../models/about_model.dart';

class SupabaseService {
  final SupabaseClient _client = Supabase.instance.client;

  // Profile
  Future<Profile> getProfile() async {
    try {
      final response =
          await _client
              .from('profile')
              .select()
              .order('created_at', ascending: false)
              .limit(1)
              .single();

      return Profile.fromJson(response);
    } catch (e) {
      print('Error fetching profile: $e');
      rethrow;
    }
  }

  // Projects
  Future<List<Project>> getProjects() async {
    try {
      final response = await _client
          .from('projects')
          .select()
          .order('created_at', ascending: false);

      return (response as List).map((json) => Project.fromJson(json)).toList();
    } catch (e) {
      print('Error fetching projects: $e');
      rethrow;
    }
  }

  Future<void> insertProject(Project project) async {
    await _client.from('projects').insert({
      'name': project.name,
      'description': project.description,
      'tech': project.tech,
      'links': project.links,
      'screenshots': project.screenshots,
      'icon_url': project.iconUrl,
    });
  }

  // Experience
  Future<List<Experience>> getExperience() async {
    try {
      final response = await _client
          .from('experience')
          .select()
          .order('created_at', ascending: false);

      return (response as List)
          .map((json) => Experience.fromJson(json))
          .toList();
    } catch (e) {
      print('Error fetching experience: $e');
      rethrow;
    }
  }

  Future<void> insertExperience(Experience experience) async {
    await _client.from('experience').insert({
      'role': experience.role,
      'company': experience.company,
      'duration': experience.duration,
      'achievements': experience.achievements,
    });
  }

  // Education
  Future<List<Education>> getEducation() async {
    try {
      final response = await _client
          .from('education')
          .select()
          .order('created_at', ascending: false);

      return (response as List)
          .map((json) => Education.fromJson(json))
          .toList();
    } catch (e) {
      print('Error fetching education: $e');
      rethrow;
    }
  }

  Future<void> insertEducation(Education education) async {
    await _client.from('education').insert({
      'degree': education.degree,
      'institution': education.institution,
      'duration': education.duration,
    });
  }

  // Certificates
  Future<List<Certificate>> getCertificates() async {
    try {
      final response = await _client
          .from('certificates')
          .select()
          .order('created_at', ascending: false);

      return (response as List)
          .map((json) => Certificate.fromJson(json))
          .toList();
    } catch (e) {
      print('Error fetching certificates: $e');
      rethrow;
    }
  }

  Future<void> insertCertificate(Certificate certificate) async {
    await _client.from('certificates').insert({
      'title': certificate.title,
      'issuer': certificate.issuer,
      'url': certificate.url,
    });
  }

  // Image URLs
  String getAvatarUrl(String path) {
    return _client.storage.from('avatars').getPublicUrl(path);
  }

  String getProjectIconUrl(String path) {
    return _client.storage.from('project_icons').getPublicUrl(path);
  }

  String getProjectScreenshotUrl(String path) {
    return _client.storage.from('project_screenshots').getPublicUrl(path);
  }

  // About
  Future<About> getAboutSection(String section) async {
    try {
      final response =
          await _client.from('about').select().eq('section', section).single();

      return About.fromJson(response);
    } catch (e) {
      print('Error fetching about section: $e');
      rethrow;
    }
  }

  Future<Map<String, About>> getAllAboutSections() async {
    try {
      final response = await _client
          .from('about')
          .select()
          .order('created_at', ascending: false);

      final sections =
          (response as List).map((json) => About.fromJson(json)).toList();

      return {for (var section in sections) section.section: section};
    } catch (e) {
      print('Error fetching all about sections: $e');
      rethrow;
    }
  }
}
