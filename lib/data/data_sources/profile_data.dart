import '../models/profile_model.dart';
import '../supabase/supabase_service.dart';

class ProfileDataSource {
  final SupabaseService _supabaseService = SupabaseService();

  Future<Profile> getProfile() async {
    try {
      return await _supabaseService.getProfile();
    } catch (e) {
      print('Error fetching profile: $e');
      rethrow;
    }
  }
}
