# PlacePals Requirements (Draft)

## 1) Muc tieu
- Tai dung va hoan thien app PlacePals tren Flutter.
- Xay dung luong onboarding, xin quyen, home, tim dia diem, ket noi ban be, va cac tinh nang noi bat (AI recommendations, SOS, Vibe Match).

## 2) Pham vi
- Mobile app: iOS va Android.
- Khong bao gom backoffice web admin trong giai doan 1.

## 3) Doi tuong nguoi dung
- Nguoi dung ca nhan yeu thich di chuyen, tim dia diem, gap go ban be.
- Nguoi dung muon nhan goi y theo so thich, vi tri, thoi gian.

## 4) Yeu cau chuc nang (Functional)
- Onboarding:
  - Splash/intro.
  - Xin quyen vi tri (Allow location access / Not now).
- Dang nhap/Dang ky (neu can):
  - Email/Phone/Google/Apple (xac nhan tuy theo scope).
- Trang chu:
  - Danh sach goi y dia diem.
  - Bo loc (khoang cach, gia, the loai, vibe).
- Tim kiem:
  - Tim theo ten dia diem, tu khoa, vibe.
  - Go y tu dong khi nhap.
- Chi tiet dia diem:
  - Hinh anh, mo ta, dia chi, gio mo cua, danh gia.
  - Nut chi duong.
- Ban be/Community:
  - Danh sach ban be gan day.
  - Xem ban be dang o dau (neu duoc phep).
- SOS Help Requests:
  - Tao yeu cau giup do nhanh.
  - Gui cho nguoi gan day/ban be.
- Vibe Match Search:
  - Chon tam trang, goi y dia diem phu hop.
- Thong bao:
  - Push notification cho SOS, goi y, tuong tac ban be.
- Cai dat:
  - Quan ly quyen, thong bao, tai khoan.

## 5) Yeu cau phi chuc nang (Non-functional)
- Hieu nang:
  - Thoi gian load man hinh chinh < 2s tren thiet bi tam trung.
- On dinh:
  - Crash-free sessions > 99.5%.
- Bao mat:
  - Du lieu vi tri chi thu thap khi co su dong y.
  - Ma hoa khi truyen du lieu.
- Kha nang mo rong:
  - Cau truc module de mo rong tinh nang.

## 6) Du lieu va Luu tru
- User profile, vi tri (optional), lich su tim kiem.
- Dia diem, danh muc, danh gia.
- Su kien SOS, noi dung thong bao.

## 7) Tich hop ben ngoai (neu co)
- Ban do: Google Maps / Mapbox.
- Dinh vi: Geolocator.
- Auth: Firebase Auth / OAuth.
- Push: Firebase Cloud Messaging.
- Analytics: Firebase Analytics / Mixpanel.

## 8) Yeu cau UI/UX
- Theo thiet ke Figma hien co.
- Ho tro iPhone 13/14/15 ratio va Android tuong duong.
- Kha nang responsive cho nhieu kich thuoc man hinh.

## 9) Tieu chi nghiem thu (Acceptance)
- Luong onboarding + xin quyen hoat dong.
- Trang chu hien thi goi y (mock data/real data).
- Tim kiem va chi tiet dia diem hoat dong.
- SOS gui thanh cong va nhan thong bao.

## 10) Milestones de xuat
- M1: Onboarding + xin quyen + khung UI.
- M2: Trang chu + tim kiem + chi tiet dia diem.
- M3: Ban be + SOS + thong bao.
- M4: Hoan thien, QA, release.

## 11) Mo ta cac file can co truoc khi code
- REQUIREMENTS.md (tai lieu yeu cau).
- USER_STORIES.md (story cho tung tinh nang).
- WIREFRAMES.md (hoac link Figma).
- API_SPEC.md (neu co backend).
- DATA_MODEL.md (mo hinh du lieu).
- TEST_PLAN.md (ke hoach test).
- RELEASE_CHECKLIST.md (checklist release).

## 12) Cac cau hoi can lam ro
- Backend da co chua? Neu chua, dung mock data hay Firebase?
- Chinh sach quyen rieng tu ve vi tri?
- Muc do do chinh xac cua goi y AI?
- Giai doan 1 co can real-time location cua ban be khong?
