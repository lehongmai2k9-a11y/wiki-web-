# WIKI VERSE

## ☁ Lưu trên web bằng Supabase (mới)
Dữ liệu wiki lưu trên Supabase để mọi người cùng xem; chỉ admin đăng nhập mới sửa được.
1. Tạo project ở supabase.com.
2. *SQL Editor* → dán `setup.sql` (đổi `EMAIL_CUA_BAN` thành email admin ở **mọi** chỗ) → Run. File này tạo bảng `wiki` và bucket ảnh `wiki-media`.
3. *Authentication → Users → Add user*: tạo email + mật khẩu admin (tick Auto confirm). Tắt *Allow new users to sign up*.
4. *Project Settings → API*: copy **Project URL** và **anon/publishable key** vào `config.js`. Không dùng `service_role`.
5. Mở web → Đăng nhập admin bằng email + mật khẩu đó. Mỗi lần sửa sẽ tự lưu lên web (hiện thông báo “✓ Đã lưu lên web”).
6. Ảnh/GIF/nhạc/video tải lên giờ tự vào **Supabase Storage** (JSON chỉ giữ link). Dữ liệu cũ: Admin → Dashboard → **Chuyển ảnh/nhạc cũ lên Storage**.
7. Đăng `index.html`, `app.js`, `style.css`, `config.js` lên GitHub Pages một lần; sau đó không cần xuất `data.json` nữa.
Lưu ý: gói miễn phí tạm dừng project nếu ~1 tuần không hoạt động; file tối đa 50 MB.

Chạy không cần Node.js: mở thư mục bằng VS Code, cài **Live Server**, chuột phải `index.html` → **Open with Live Server**.

## Cập nhật bản này
- Giao diện pastel/pink của web 2, kèm đủ Verse, mục, bài viết, tìm kiếm, video, nhạc, About Me và admin.
- Sửa lỗi thiếu hàm `del`: các nút Xóa (verse, mục, bài, khối) trong Admin hoạt động lại, bấm lần 1 để xác nhận, lần 2 để xóa.
- **Dashboard** (Admin → Dashboard → Ảnh dashboard) và **Verse** (Admin → Verse): thêm, đổi, **Xóa ảnh**, và chỉnh **chiều cao, phóng to, vị trí ngang/dọc** có xem trước trực tiếp; nút **Đặt lại** về mặc định.
- Ảnh Verse áp dụng cho banner Verse, thẻ ở trang chủ và avatar ở Explore.
- **About Me**: tiêu đề nằm sát ảnh và căn trái; đã bỏ phần decor.
- **Nhạc**: gom thành **Playlist mini** kiểu Spotify ở cuối bài viết (danh sách bài + thanh ⏮ ▶ ⏭ + thanh tua, không hiện video). Dán link file nhạc (.mp3...) hoặc link **YouTube** (chạy ngầm, không hiện hình). Mỗi bài có ô *Tên bài hát* và nút **▶ Tự động phát**; bài đứng trên phát trước, hết bài tự chuyển sang bài kế có bật tự phát. Nếu trình duyệt chặn tự phát, chạm vào trang hoặc bấm ▶ một lần.
- **Đổi thứ tự**: nhấn giữ biểu tượng **⋮⋮** rồi kéo lên/xuống (verse, mục, bài viết, khối nội dung bài, khối About Me). Nút ↑ ↓ vẫn dùng được.
- **GIF**: tải file `.gif` lên (giữ nguyên hiệu ứng động) hoặc dán link ảnh/GIF vào ô "Hoặc dán link ảnh / GIF" trong khối ảnh. GIF nặng nên dùng link để khỏi đầy bộ nhớ trình duyệt.

## Lưu ý
Dữ liệu lưu trong **IndexedDB** (database `verse_wiki_db`, khóa `verse_wiki_v1`) — dung lượng lớn hơn hẳn localStorage (~5 MB) nên tải ảnh/GIF/nhạc lên không còn bị lỗi "Bộ nhớ trình duyệt đã đầy". Dữ liệu cũ trong localStorage được tự động chuyển sang IndexedDB ở lần mở đầu tiên. Mật khẩu admin mặc định `admin`. Đổi cổng Live Server thì dữ liệu cũ không hiện.

## Cập nhật thêm
- **Màu & ảnh nền riêng**: mỗi **mục**, **bài viết**, **khối nội dung** (kể cả khối About Me) có ô *Màu & ảnh nền riêng* trong Admin: chọn màu nền, màu chữ, tải ảnh/GIF hoặc dán link làm nền, và chỉnh **độ phủ sáng** để chữ dễ đọc. Nút *Bỏ màu & ảnh* để trả về mặc định.
- **Nhạc lặp lại**: hết bài cuối (có bật tự phát) thì quay về bài tự phát đầu tiên và phát lại; nếu không bài nào bật tự phát thì lặp lại bài đang nghe. Nút ⏭ ở bài cuối cũng quay về bài đầu.

## Khung nền vuông có chỉnh sửa
- **Màu nền** giờ là một **khung nền** (mục, bài viết, khối nội dung, khối About Me): chỉnh **Bo góc** (0 = vuông, tối đa 60px) và **Trong suốt** (0% đặc → 100% ẩn hẳn). Chữ không bị mờ theo; có ô **Xem trước** trên nền caro để thấy độ trong suốt.
- Khung chỉ bị **thay thế khi thêm ảnh**: có ảnh thì ảnh thế chỗ màu (vẫn dùng đúng bo góc/trong suốt), lúc này mới hiện thanh **Độ phủ sáng**. Bấm **Xóa ảnh** thì quay lại màu nền.
- Ô xem trước luôn hiện sẵn một **khung nền trắng** ngay từ đầu. Chỉ cần kéo Bo góc / Trong suốt hoặc đổi Màu nền là khung được áp dụng lên trang, không cần chọn màu trước.
- **Tỉ lệ & size ảnh**: khối **Ảnh**, **Ảnh + chữ** (ở chỉnh sửa chi tiết verse và About Me) và ảnh bìa bài viết có thêm **Tỉ lệ ảnh** (Tự do, 1:1, 4:3, 3:4, 16:9, 9:16, 3:2, 2:3; ảnh được cắt vừa khung) cùng **Kích thước** %. Khung nền của khối có **Tỉ lệ khung** và **Rộng khung** riêng.

## Sửa lỗi ảnh không hiển thị (About Me và toàn bộ web)
- Khi ảnh không tải được — **link hỏng / link hết hạn**, hoặc **file lỗi** — thay vì khoảng trống vô hình, giờ hiện rõ khung **“Ảnh không tải được (link hỏng, hết hạn hoặc file lỗi)…”** ngay tại chỗ đó, ở cả trang About Me và trong trang Quản trị, để biết cần thêm lại ảnh nào.
- Dán **link Google Drive** (dạng `file/d/…`, `open?id=…`, `docs.google.com/…`) vào ô ảnh thì tự đổi sang link xem trực tiếp `drive.google.com/thumbnail?id=…&sz=w1600` — vì link chia sẻ Google Drive thường **không xem được trực tiếp**. Link **Dropbox** cũng tự đổi `dl=0` → `raw=1`.
- Tải lên **file ảnh mà trình duyệt không đọc được** (HEIC/RAW của iPhone, file lỗi): báo rõ và **không lưu** ảnh hỏng nữa (trước đây vẫn lưu vào nhưng không bao giờ hiện). Cách xử lý: mở ảnh, lưu thành **JPG/PNG** rồi thêm lại.
- Mẹo: ảnh quan trọng nên **bấm “Tải ảnh lên”** thay vì dán link — ảnh lưu thẳng trong máy, không sợ link hết hạn.

## Đăng lên GitHub Pages để người khác thấy
Dữ liệu chỉnh sửa nằm trong trình duyệt của bạn nên cần xuất ra file `data.json`:
1. Admin → **Dashboard** → **Xuất dữ liệu (data.json)**. Trình duyệt tải về file `data.json`.
2. Tải `index.html`, `app.js`, `style.css` và `data.json` vào **cùng một thư mục** trên repo GitHub.
3. Repo → Settings → Pages → chọn nhánh `main`, thư mục `/ (root)` → Save.
4. Mỗi lần chỉnh sửa xong, xuất lại `data.json` và tải đè lên GitHub (đợi 1–2 phút).
Người xem chưa có dữ liệu trên máy sẽ tự đọc `data.json`. **Nhập dữ liệu** dùng để khôi phục từ file đã xuất; **Bỏ bản trên máy** để quay về bản đã đăng.
