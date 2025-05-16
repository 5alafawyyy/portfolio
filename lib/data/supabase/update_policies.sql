-- Drop existing policies if they exist
drop policy if exists "Allow public read access on projects" on projects;
drop policy if exists "Allow public read access on experience" on experience;
drop policy if exists "Allow public read access on education" on education;
drop policy if exists "Allow public read access on certificates" on certificates;
drop policy if exists "Allow public access on projects" on projects;
drop policy if exists "Allow public access on experience" on experience;
drop policy if exists "Allow public access on education" on education;
drop policy if exists "Allow public access on certificates" on certificates;

-- Create policies to allow public read and write access
create policy "Allow public access on projects"
  on projects for all
  to anon
  using (true)
  with check (true);

create policy "Allow public access on experience"
  on experience for all
  to anon
  using (true)
  with check (true);

create policy "Allow public access on education"
  on education for all
  to anon
  using (true)
  with check (true);

create policy "Allow public access on certificates"
  on certificates for all
  to anon
  using (true)
  with check (true); 