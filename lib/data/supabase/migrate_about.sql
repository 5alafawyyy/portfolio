-- Insert professional summary
INSERT INTO about (section, content)
VALUES (
  'professional_summary',
  '2+ years of Flutter development for Android/iOS.\n'
  'Hands-on experience in backend API integration (RESTful APIs, Firebase, Laravel, Node.js).\n'
  'Strong passion for DevOps, continuous integration, and agile practices.\n'
  'Developed 9+ live mobile applications, each focused on user-centric design and performance optimization.\n'
  'Proven track record of integrating Payment Gateways (Paymob), Push Notifications, Analytics, and Crash Reporting.\n'
  'Highly adaptable to cross-functional teams: agile, remote, and in-house collaboration.'
)
ON CONFLICT (section) DO UPDATE
SET content = EXCLUDED.content;

-- Insert skills
INSERT INTO about (section, content, skills)
VALUES (
  'skills',
  'Core skills and technologies I work with',
  ARRAY[
    'Flutter',
    'Dart',
    'Firebase',
    'REST APIs',
    'CI/CD',
    'Node.js',
    'Laravel',
    'GitHub Actions',
    'Fastlane',
    'Docker'
  ]
)
ON CONFLICT (section) DO UPDATE
SET content = EXCLUDED.content,
    skills = EXCLUDED.skills;

-- Insert tech stack
INSERT INTO about (section, content, skills)
VALUES (
  'tech_stack',
  'Comprehensive list of technologies and tools I use',
  ARRAY[
    'Flutter',
    'Dart',
    'Firebase Auth',
    'Firestore',
    'Cloud Messaging',
    'Cloud Functions',
    'Node.js (Express)',
    'PHP (Laravel)',
    'Python (FastAPI)',
    'REST APIs',
    'Payment Gateway: Paymob',
    'Payment Gateway: Stripe',
    'GitHub Actions',
    'Codemagic',
    'Fastlane',
    'Docker',
    'Firebase App Distribution',
    'MS App Center',
    'Shorebird',
    'HTML',
    'CSS',
    'JavaScript',
    'jQuery',
    'Figma'
  ]
)
ON CONFLICT (section) DO UPDATE
SET content = EXCLUDED.content,
    skills = EXCLUDED.skills; 