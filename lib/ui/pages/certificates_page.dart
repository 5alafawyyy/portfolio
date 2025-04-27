import 'package:flutter/material.dart';
import '../../data/data_sources/certificates_data.dart';
import '../widgets/responsive_layout.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';

class CertificatesPage extends StatelessWidget {
  const CertificatesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveLayout(
        desktop: _buildList(context, width: 700),
        tablet: _buildList(context, width: 500),
        mobile: _buildList(context, width: double.infinity),
      ),
    );
  }

  Widget _buildList(BuildContext context, {required double width}) {
    return Center(
      child: SizedBox(
        width: width,
        child: ListView.separated(
          padding: const EdgeInsets.all(24),
          itemCount: certificates.length,
          separatorBuilder: (context, i) => const SizedBox(height: 24),
          itemBuilder: (context, i) {
            final cert = certificates[i];
            return Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.workspace_premium,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                cert.title,
                                style: Theme.of(context).textTheme.titleLarge
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          cert.issuer,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        if (cert.url != null && cert.url!.isNotEmpty) ...[
                          const SizedBox(height: 8),
                          GestureDetector(
                            onTap: () async {
                              final uri = Uri.parse(cert.url!);
                              if (await canLaunchUrl(uri)) {
                                await launchUrl(uri);
                              }
                            },
                            child: Text(
                              'View Certificate',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                )
                .animate()
                .fadeIn(duration: 600.ms, delay: (i * 120).ms)
                .slideY(
                  begin: 0.1,
                  end: 0,
                  duration: 600.ms,
                  delay: (i * 120).ms,
                );
          },
        ),
      ),
    );
  }
}
