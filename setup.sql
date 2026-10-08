-- Chạy trong Supabase → SQL Editor. Nhớ đổi EMAIL_CUA_BAN thành email admin.
create table if not exists public.wiki (
  id text primary key,
  data jsonb not null,
  updated_at timestamptz default now()
);

alter table public.wiki enable row level security;

-- Ai cũng được XEM
create policy "wiki_public_read" on public.wiki
  for select using (true);

-- Chỉ tài khoản admin được THÊM / SỬA
create policy "wiki_admin_insert" on public.wiki
  for insert to authenticated
  with check ((auth.jwt() ->> 'email') = 'EMAIL_CUA_BAN');

create policy "wiki_admin_update" on public.wiki
  for update to authenticated
  using      ((auth.jwt() ->> 'email') = 'EMAIL_CUA_BAN')
  with check ((auth.jwt() ->> 'email') = 'EMAIL_CUA_BAN');

-- ====== Nơi lưu ảnh / GIF / nhạc / video (Storage) ======
insert into storage.buckets (id, name, public, file_size_limit)
values ('wiki-media', 'wiki-media', true, 52428800)   -- công khai, tối đa 50MB/file
on conflict (id) do nothing;

create policy "media_admin_insert" on storage.objects
  for insert to authenticated
  with check (bucket_id = 'wiki-media' and (auth.jwt() ->> 'email') = 'EMAIL_CUA_BAN');

create policy "media_admin_update" on storage.objects
  for update to authenticated
  using (bucket_id = 'wiki-media' and (auth.jwt() ->> 'email') = 'EMAIL_CUA_BAN');

create policy "media_admin_delete" on storage.objects
  for delete to authenticated
  using (bucket_id = 'wiki-media' and (auth.jwt() ->> 'email') = 'EMAIL_CUA_BAN');
