-- Insert profile data
INSERT INTO profile (
  name,
  title,
  location,
  email,
  github,
  linkedin,
  whatsapp,
  cv_url,
  avatar_url,
  created_at
) VALUES (
  'Ahmed Khallaf',
  'Flutter Developer',
  'Cairo, Egypt',
  'ahmedkhallaf@gmail.com',
  'https://github.com/ahmedkhallaf',
  'https://www.linkedin.com/in/ahmedkhallaf',
  'https://wa.me/201234567890',
  'https://drive.google.com/file/d/1UPxmHswdr0ciFxn1DkmU9edumw0EIi0Y/view?usp=drive_link',
  'https://your-supabase-project.supabase.co/storage/v1/object/public/avatars/ahmedkhallaf.jpg',
  NOW()
) ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  title = EXCLUDED.title,
  location = EXCLUDED.location,
  email = EXCLUDED.email,
  github = EXCLUDED.github,
  linkedin = EXCLUDED.linkedin,
  whatsapp = EXCLUDED.whatsapp,
  cv_url = EXCLUDED.cv_url,
  avatar_url = EXCLUDED.avatar_url; 