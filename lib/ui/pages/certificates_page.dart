import 'package:flutter/material.dart';
import '../../data/data_sources/certificates_data.dart';
import '../../data/models/certificate_model.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';

class CertificatesPage extends StatefulWidget {
  const CertificatesPage({super.key});

  @override
  State<CertificatesPage> createState() => _CertificatesPageState();
}

class _CertificatesPageState extends State<CertificatesPage> {
  final CertificatesDataSource _dataSource = CertificatesDataSource();
  late Future<List<Certificate>> _certificatesFuture;

  @override
  void initState() {
    super.initState();
    _certificatesFuture = _dataSource.getCertificates();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Certificate>>(
      future: _certificatesFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(
            child: Text(
              'Error loading certificates: ${snapshot.error}',
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
          );
        }

        final certificates = snapshot.data ?? [];
        if (certificates.isEmpty) {
          return const Center(child: Text('No certificates found'));
        }

        return ListView.builder(
          padding: const EdgeInsets.all(24),
          itemCount: certificates.length,
          itemBuilder: (context, index) {
            final certificate = certificates[index];
            return InkWell(
              onTap: () async {
                final uri = Uri.parse(certificate.url!);
                if (await canLaunchUrl(uri)) {
                  await launchUrl(uri);
                }
              },
              child: Card(
                    margin: const EdgeInsets.only(bottom: 24),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(24),
                      leading: Icon(
                        Icons.workspace_premium,
                        color: Theme.of(context).colorScheme.primary,
                        size: 32,
                      ),
                      title: Text(
                        certificate.title,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        certificate.issuer,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      trailing:
                          certificate.url != null
                              ? IconButton(
                                icon: const Icon(Icons.link),
                                onPressed: () async {
                                  final uri = Uri.parse(certificate.url!);
                                  if (await canLaunchUrl(uri)) {
                                    await launchUrl(uri);
                                  }
                                },
                              )
                              : null,
                    ),
                  )
                  .animate()
                  .fadeIn(duration: 600.ms, delay: (100 * index).ms)
                  .slideX(
                    begin: 0.2,
                    end: 0,
                    duration: 600.ms,
                    delay: (100 * index).ms,
                  ),
            );
          },
        );
      },
    );
  }
}
