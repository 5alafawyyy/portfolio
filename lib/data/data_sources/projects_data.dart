import '../models/project_model.dart';

final List<Project> projects = [
  Project(
    name: 'EDUVA (Educational Quiz App)',
    description: 'Trivia, audio/image quizzes, contest modes, leaderboards.',
    tech: ['Flutter', 'Firebase', 'REST APIs', 'Social Login'],
    links: {
      'Google Play': '', // Add actual link if available
      'Huawei App Gallery': '',
    },
    screenshots: [
      'https://via.placeholder.com/300x600?text=EDUVA+1',
      'https://via.placeholder.com/300x600?text=EDUVA+2',
    ],
  ),
  Project(
    name: 'S Square Plus (Video Education Platform)',
    description:
        'Lecture streaming (YouTube/Vimeo/Google Drive), student dashboard.',
    tech: ['Flutter', 'Firebase', 'YouTube Explode'],
    links: {'App Store': '', 'Google Play': ''},
    screenshots: [
      'https://via.placeholder.com/300x600?text=S+Square+1',
      'https://via.placeholder.com/300x600?text=S+Square+2',
    ],
  ),
  Project(
    name: 'Fax Shipping Express (Logistics App)',
    description:
        'Shipment tracking, vendor-customer communication, real-time updates.',
    tech: ['Flutter', 'Firebase', 'Node.js'],
    links: {'Google Play': ''},
    screenshots: ['https://via.placeholder.com/300x600?text=Fax+Shipping+1'],
  ),
  Project(
    name: 'Grable App (Marble & Gravel Marketplace)',
    description: 'Product listing, order tracking, vendor management.',
    tech: ['Flutter', 'Laravel', 'Custom UI'],
    links: {'Google Play': ''},
    screenshots: ['https://via.placeholder.com/300x600?text=Grable+1'],
  ),
  Project(
    name: 'Service Booking Platform',
    description: 'Schedule appointments for services.',
    tech: ['Flutter'],
    links: {},
    screenshots: ['https://via.placeholder.com/300x600?text=Service+Booking'],
  ),
  Project(
    name: 'On-Demand Delivery App',
    description:
        'Tailored for local business delivery (similar to grocery logistics).',
    tech: ['Flutter'],
    links: {},
    screenshots: [
      'https://via.placeholder.com/300x600?text=On-Demand+Delivery',
    ],
  ),
];
