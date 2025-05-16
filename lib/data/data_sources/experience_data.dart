import '../models/experience_model.dart';
import '../supabase/supabase_service.dart';

class ExperienceDataSource {
  final SupabaseService _supabaseService = SupabaseService();

  Future<List<Experience>> getExperience() async {
    try {
      return await _supabaseService.getExperience();
    } catch (e) {
      print('Error fetching experience: $e');
      return [];
    }
  }
}
