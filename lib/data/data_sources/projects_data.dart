import '../models/project_model.dart';
import '../supabase/supabase_service.dart';

class ProjectsDataSource {
  final SupabaseService _supabaseService = SupabaseService();

  Future<List<Project>> getProjects() async {
    try {
      return await _supabaseService.getProjects();
    } catch (e) {
      print('Error fetching projects: $e');
      return [];
    }
  }
}
