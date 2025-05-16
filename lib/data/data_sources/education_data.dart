import '../models/education_model.dart';
import '../supabase/supabase_service.dart';

class EducationDataSource {
  final SupabaseService _supabaseService = SupabaseService();

  Future<List<Education>> getEducation() async {
    try {
      return await _supabaseService.getEducation();
    } catch (e) {
      print('Error fetching education: $e');
      return [];
    }
  }
}
