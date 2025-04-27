import 'package:flutter/material.dart';
import '../../core/constants.dart';
import '../widgets/responsive_layout.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  Widget _mainContent(BuildContext context, {double width = 500}) {
    return Center(
      child: SizedBox(
        width: width,
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            Text(
              'Professional Summary',
              style: Theme.of(context).textTheme.titleLarge,
            ).animate().fadeIn(duration: 600.ms, delay: 100.ms),
            const SizedBox(height: 8),
            const Text(
              '2+ years of Flutter development for Android/iOS.\n'
              'Hands-on experience in backend API integration (RESTful APIs, Firebase, Laravel, Node.js).\n'
              'Strong passion for DevOps, continuous integration, and agile practices.\n'
              'Developed 9+ live mobile applications, each focused on user-centric design and performance optimization.\n'
              'Proven track record of integrating Payment Gateways (Paymob), Push Notifications, Analytics, and Crash Reporting.\n'
              'Highly adaptable to cross-functional teams: agile, remote, and in-house collaboration.',
              style: TextStyle(fontSize: 16),
            ).animate().fadeIn(duration: 600.ms, delay: 200.ms),
            const SizedBox(height: 24),
            Text(
              'Skills',
              style: Theme.of(context).textTheme.titleLarge,
            ).animate().fadeIn(duration: 600.ms, delay: 300.ms),
            const SizedBox(height: 8),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                Chip(label: Text('Flutter'), avatar: Icon(Icons.phone_android)),
                Chip(label: Text('Dart'), avatar: Icon(Icons.code)),
                Chip(label: Text('Firebase'), avatar: Icon(Icons.cloud)),
                Chip(label: Text('REST APIs'), avatar: Icon(Icons.http)),
                Chip(label: Text('CI/CD'), avatar: Icon(Icons.build)),
                Chip(label: Text('Node.js'), avatar: Icon(Icons.storage)),
                Chip(label: Text('Laravel'), avatar: Icon(Icons.web)),
                Chip(
                  label: Text('GitHub Actions'),
                  avatar: Icon(Icons.merge_type),
                ),
                Chip(
                  label: Text('Fastlane'),
                  avatar: Icon(Icons.rocket_launch),
                ),
                Chip(label: Text('Docker'), avatar: Icon(Icons.dns)),
              ],
            ).animate().fadeIn(duration: 600.ms, delay: 400.ms),
            const SizedBox(height: 24),
            Text(
              'Tech Stack',
              style: Theme.of(context).textTheme.titleLarge,
            ).animate().fadeIn(duration: 600.ms, delay: 500.ms),
            const SizedBox(height: 8),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                Chip(label: Text('Flutter'), avatar: Icon(Icons.phone_android)),
                Chip(label: Text('Dart'), avatar: Icon(Icons.code)),
                Chip(
                  label: Text('Firebase Auth'),
                  avatar: Icon(Icons.verified_user),
                ),
                Chip(label: Text('Firestore'), avatar: Icon(Icons.storage)),
                Chip(label: Text('Cloud Messaging'), avatar: Icon(Icons.cloud)),
                Chip(
                  label: Text('Cloud Functions'),
                  avatar: Icon(Icons.functions),
                ),
                Chip(
                  label: Text('Node.js (Express)'),
                  avatar: Icon(Icons.storage),
                ),
                Chip(label: Text('PHP (Laravel)'), avatar: Icon(Icons.web)),
                Chip(
                  label: Text('Python (FastAPI)'),
                  avatar: Icon(Icons.memory),
                ),
                Chip(label: Text('REST APIs'), avatar: Icon(Icons.http)),
                Chip(
                  label: Text('Payment Gateway: Paymob'),
                  avatar: Icon(Icons.payment),
                ),
                Chip(
                  label: Text('Payment Gateway: Stripe'),
                  avatar: Icon(Icons.credit_card),
                ),
                Chip(
                  label: Text('GitHub Actions'),
                  avatar: Icon(Icons.merge_type),
                ),
                Chip(
                  label: Text('Codemagic'),
                  avatar: Icon(Icons.auto_fix_high),
                ),
                Chip(
                  label: Text('Fastlane'),
                  avatar: Icon(Icons.rocket_launch),
                ),
                Chip(label: Text('Docker'), avatar: Icon(Icons.dns)),
                Chip(
                  label: Text('Firebase App Distribution'),
                  avatar: Icon(Icons.cloud_upload),
                ),
                Chip(
                  label: Text('MS App Center'),
                  avatar: Icon(Icons.mobile_friendly),
                ),
                Chip(label: Text('Shorebird'), avatar: Icon(Icons.bolt)),
                Chip(label: Text('HTML'), avatar: Icon(Icons.language)),
                Chip(label: Text('CSS'), avatar: Icon(Icons.style)),
                Chip(label: Text('JavaScript'), avatar: Icon(Icons.javascript)),
                Chip(label: Text('jQuery'), avatar: Icon(Icons.extension)),
                Chip(label: Text('Figma'), avatar: Icon(Icons.design_services)),
              ],
            ).animate().fadeIn(duration: 600.ms, delay: 600.ms),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Me'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: ResponsiveLayout(
        desktop: _mainContent(context, width: 700),
        tablet: _mainContent(context, width: 500),
        mobile: _mainContent(context, width: double.infinity),
      ),
    );
  }
}
