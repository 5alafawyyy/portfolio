import 'dart:convert';
import 'package:flutter/services.dart';
import 'supabase_service.dart';
import '../models/project_model.dart';
import '../models/experience_model.dart';
import '../models/education_model.dart';
import '../models/certificate_model.dart';

class DataMigration {
  final SupabaseService _supabaseService = SupabaseService();

  Future<void> migrateAllData() async {
    await migrateProjects();
    await migrateExperience();
    await migrateEducation();
    await migrateCertificates();
  }

  Future<void> migrateProjects() async {
    try {
      // Load your existing projects data
      final String jsonString = await rootBundle.loadString(
        'assets/data/projects.json',
      );
      final List<dynamic> jsonList = json.decode(jsonString);

      for (var json in jsonList) {
        final project = Project(
          name: json['name'],
          description: json['description'],
          tech: List<String>.from(json['tech']),
          links: Map<String, String>.from(json['links']),
          screenshots: List<String>.from(json['screenshots']),
          iconUrl: json['icon_url'],
        );
        await _supabaseService.insertProject(project);
      }
      print('Projects migration completed successfully');
    } catch (e) {
      print('Error migrating projects: $e');
    }
  }

  Future<void> migrateExperience() async {
    try {
      final String jsonString = await rootBundle.loadString(
        'assets/data/experience.json',
      );
      final List<dynamic> jsonList = json.decode(jsonString);

      for (var json in jsonList) {
        final experience = Experience(
          role: json['role'],
          company: json['company'],
          duration: json['duration'],
          achievements: List<String>.from(json['achievements']),
        );
        await _supabaseService.insertExperience(experience);
      }
      print('Experience migration completed successfully');
    } catch (e) {
      print('Error migrating experience: $e');
    }
  }

  Future<void> migrateEducation() async {
    try {
      final String jsonString = await rootBundle.loadString(
        'assets/data/education.json',
      );
      final List<dynamic> jsonList = json.decode(jsonString);

      for (var json in jsonList) {
        final education = Education(
          degree: json['degree'],
          institution: json['institution'],
          duration: json['duration'],
        );
        await _supabaseService.insertEducation(education);
      }
      print('Education migration completed successfully');
    } catch (e) {
      print('Error migrating education: $e');
    }
  }

  Future<void> migrateCertificates() async {
    try {
      final String jsonString = await rootBundle.loadString(
        'assets/data/certificates.json',
      );
      final List<dynamic> jsonList = json.decode(jsonString);

      for (var json in jsonList) {
        final certificate = Certificate(
          title: json['title'],
          issuer: json['issuer'],
          url: json['url'],
        );
        await _supabaseService.insertCertificate(certificate);
      }
      print('Certificates migration completed successfully');
    } catch (e) {
      print('Error migrating certificates: $e');
    }
  }
}
