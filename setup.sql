create table public.books (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null default auth.uid() references auth.users(id) on delete cascade,
  isbn text, title text not null, authors text, publisher text, edition text,
  genre text, year text, pages int, language text, description text, cover text,
  status text not null default 'da_leggere' check (status in ('da_leggere','leggendo','letto')),
  rating int check (rating between 1 and 5), rating_note text,
  purchase_date date, start_date date, end_date date,
  format text, place text, notes text,
  copies int not null default 1,
  created_at timestamptz not null default now()
);
alter table public.books enable row level security;
create policy "solo i miei libri" on public.books
  for all to authenticated
  using (auth.uid() = user_id) with check (auth.uid() = user_id);
