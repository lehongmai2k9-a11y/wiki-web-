# Fandom Wiki — VS Code + Supabase

## 1. Supabase
1. Open Supabase Dashboard -> SQL Editor.
2. Run `sql/schema.sql`.
3. Authentication -> Users -> create your admin account.
4. Project Settings -> API -> copy the Publishable/anon key into `js/supabase.js`.
5. Never put a service_role/secret key in frontend files.

The existing project URL found in the previous project files is already placed in `js/supabase.js`; replace it if you use another project.

## 2. VS Code
Open this folder in Visual Studio Code and install **Live Server**. Right click `index.html` -> Open with Live Server.

Admin: `/admin.html`
Public: `/index.html`

## 3. Current features
- Public fandom library
- Multiple fandoms
- Multiple pages per fandom
- Free-form blocks: text, image URL, YouTube embed, quote, divider
- Per-fandom theme colors
- Supabase Auth admin login
- Supabase Postgres data
- RLS for public read / authenticated write

## 4. Important
This is the clean foundation for the full builder. Image/audio file upload can be added with Supabase Storage next; image blocks currently accept URLs so the database layer stays simple and reliable.
