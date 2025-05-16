import 'package:flutter/material.dart';
import '../../data/supabase/migrate_data.dart';

class MigrationPage extends StatefulWidget {
  const MigrationPage({super.key});

  @override
  State<MigrationPage> createState() => _MigrationPageState();
}

class _MigrationPageState extends State<MigrationPage> {
  bool _isLoading = false;
  String _status = '';

  Future<void> _migrateData() async {
    setState(() {
      _isLoading = true;
      _status = 'Starting migration...';
    });

    try {
      final migration = DataMigration();
      await migration.migrateAllData();
      setState(() {
        _status = 'Migration completed successfully!';
      });
    } catch (e) {
      setState(() {
        _status = 'Error during migration: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Data Migration')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (_isLoading)
                const CircularProgressIndicator()
              else
                ElevatedButton(
                  onPressed: _migrateData,
                  child: const Text('Start Migration'),
                ),
              const SizedBox(height: 20),
              Text(
                _status,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
