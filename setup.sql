-- WIKI VERSE - Supabase setup
-- Chạy toàn bộ file này trong Supabase > SQL Editor.
-- Mô hình quyền:
--   * Người chưa đăng nhập: chỉ được đọc wiki.
--   * Bất kỳ tài khoản Supabase Auth nào đăng nhập thành công: được sửa wiki và media.

create table if not exists public.wiki (
  id text primary key,
  data jsonb not null,
  updated_at timestamptz not null default now()
);

alter table public.wiki enable row level security;

drop policy if exists "wiki_public_read" on public.wiki;
drop policy if exists "wiki_admin_insert" on public.wiki;
drop policy if exists "wiki_admin_update" on public.wiki;
drop policy if exists "wiki_admin_delete" on public.wiki;

-- Ai cũng được xem dữ liệu chung.
create policy "wiki_public_read"
on public.wiki
for select
to anon, authenticated
using (true);

-- Chỉ người đã đăng nhập mới được thêm/sửa/xóa.
create policy "wiki_admin_insert"
on public.wiki
for insert
to authenticated
with check (true);

create policy "wiki_admin_update"
on public.wiki
for update
to authenticated
using (true)
with check (true);

create policy "wiki_admin_delete"
on public.wiki
for delete
to authenticated
using (true);

-- ===== Storage cho ảnh / GIF / nhạc / video =====
insert into storage.buckets (id, name, public, file_size_limit)
values ('wiki-media', 'wiki-media', true, 52428800)
on conflict (id) do update
set public = excluded.public,
    file_size_limit = excluded.file_size_limit;

drop policy if exists "media_admin_insert" on storage.objects;
drop policy if exists "media_admin_update" on storage.objects;
drop policy if exists "media_admin_delete" on storage.objects;

create policy "media_admin_insert"
on storage.objects
for insert
to authenticated
with check (bucket_id = 'wiki-media');

create policy "media_admin_update"
on storage.objects
for update
to authenticated
using (bucket_id = 'wiki-media')
with check (bucket_id = 'wiki-media');

create policy "media_admin_delete"
on storage.objects
for delete
to authenticated
using (bucket_id = 'wiki-media');

-- Không bắt buộc insert sẵn row 'main'.
-- Khi admin đăng nhập lần đầu, app.js sẽ tạo row này từ dữ liệu hiện có.
