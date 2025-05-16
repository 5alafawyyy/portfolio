-- Insert projects data
INSERT INTO projects (
  name,
  description,
  tech,
  links,
  screenshots,
  icon,
  icon_url,
  created_at
) VALUES 
(
  'EDUVA (Educational Quiz App)',
  'Trivia, audio/image quizzes, contest modes, leaderboards.',
  ARRAY['Flutter', 'Firebase', 'REST APIs', 'Social Login'],
  '{"Google Play": "https://play.google.com/store/apps/details?id=com.mutqana.eduva&hl=en", "Huawei App Gallery": "https://appgallery.huawei.com/app/C111561265?sharePrepath=ag&locale=ar_SA&source=appshare&subsource=C111561265&shareTo=com.android.bluetooth&shareFrom=appmarket&shareIds=939020438f6349699ff4a7684db4cd5a_com.android.bluetooth&callType=SHARE"}',
  ARRAY['https://your-supabase-project.supabase.co/storage/v1/object/public/project_screenshots/eduva.png'],
  'eduva.png',
  'https://your-supabase-project.supabase.co/storage/v1/object/public/project_icons/eduva.png',
  NOW()
),
(
  'S Square Plus (Video Education Platform)',
  'Lecture streaming (YouTube/Vimeo/Google Drive), student dashboard.',
  ARRAY['Flutter', 'Firebase', 'YouTube Explode'],
  '{"App Store": "https://apps.apple.com/eg/app/s-square-plus/id1636308161", "Google Play": "https://play.google.com/store/apps/details?id=com.SSquare.EgyEDUAcademy"}',
  ARRAY['https://your-supabase-project.supabase.co/storage/v1/object/public/project_screenshots/ssquare_plus.png'],
  'ssquare_plus.png',
  'https://your-supabase-project.supabase.co/storage/v1/object/public/project_icons/ssquare_plus.png',
  NOW()
),
(
  'Fax Shipping Express (Logistics App)',
  'Shipment tracking, vendor-customer communication, real-time updates.',
  ARRAY['Flutter', 'Firebase', 'Node.js'],
  '{"Google Play": "https://play.google.com/store/apps/details?id=com.msar.fax_shipping_express"}',
  ARRAY['https://your-supabase-project.supabase.co/storage/v1/object/public/project_screenshots/fax.png'],
  'fax.png',
  'https://your-supabase-project.supabase.co/storage/v1/object/public/project_icons/fax.png',
  NOW()
),
(
  'Grable App (Marble & Granite Marketplace)',
  'Product listing, order tracking, vendor management.',
  ARRAY['Flutter', 'Laravel', 'Custom UI'],
  '{"Google Play": "https://play.google.com/store/apps/details?id=com.msarweb.marble"}',
  ARRAY['https://your-supabase-project.supabase.co/storage/v1/object/public/project_screenshots/grable.png'],
  'grable.png',
  'https://your-supabase-project.supabase.co/storage/v1/object/public/project_icons/grable.png',
  NOW()
),
(
  'Pets Planet',
  'Pet adoption, care, and marketplace app.',
  ARRAY['Flutter'],
  '{"Google Play": "https://play.google.com/store/apps/details?id=com.khalafawy.petsplanet&hl=en&gl=US"}',
  ARRAY['https://your-supabase-project.supabase.co/storage/v1/object/public/project_screenshots/pets.png'],
  'pets.png',
  'https://your-supabase-project.supabase.co/storage/v1/object/public/project_icons/pets.png',
  NOW()
),
(
  'S Square',
  'Lecture streaming, student dashboard.',
  ARRAY['Flutter', 'Firebase'],
  '{"App Store": "https://apps.apple.com/eg/app/s-square/id1591739831", "Google Play": "https://play.google.com/store/apps/details?id=com.flasherCheetah.speedAndSuccess.speed_and_success&hl=en"}',
  ARRAY['https://your-supabase-project.supabase.co/storage/v1/object/public/project_screenshots/ssquare.png'],
  'ssquare.png',
  'https://your-supabase-project.supabase.co/storage/v1/object/public/project_icons/ssquare.png',
  NOW()
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  description = EXCLUDED.description,
  tech = EXCLUDED.tech,
  links = EXCLUDED.links,
  screenshots = EXCLUDED.screenshots,
  icon = EXCLUDED.icon,
  icon_url = EXCLUDED.icon_url; 