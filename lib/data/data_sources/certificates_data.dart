import '../models/certificate_model.dart';
import '../supabase/supabase_service.dart';

class CertificatesDataSource {
  final SupabaseService _supabaseService = SupabaseService();

  Future<List<Certificate>> getCertificates() async {
    try {
      return await _supabaseService.getCertificates();
    } catch (e) {
      print('Error fetching certificates: $e');
      return [];
    }
  }
}
