# Project Doc - PlacePals

## 1) Tong quan
- Muc tieu: tai dung va hoan thien app PlacePals tren Flutter.
- Pham vi: mobile iOS/Android.
- Doi tuong: nguoi dung ca nhan muon tim dia diem, ket noi ban be, nhan goi y theo vibe/so thich.

## 2) Yeu cau chuc nang (tom tat)
- Onboarding + xin quyen vi tri.
- Trang chu goi y dia diem.
- Tim kiem theo tu khoa/vibe.
- Chi tiet dia diem + chi duong.
- Ban be/Community + tuong tac gan day.
- SOS Help Requests.
- Vibe Match Search.
- Thong bao.
- Cai dat tai khoan va quyen.

## 3) Yeu cau phi chuc nang
- Hieu nang: load man hinh chinh < 2s tren thiet bi tam trung.
- On dinh: crash-free sessions > 99.5%.
- Bao mat: du lieu vi tri chi thu thap khi nguoi dung dong y.
- Kha nang mo rong: cau truc module ro rang theo feature.

## 4) Kien truc & Mau thiet ke
Du an duoc to chuc theo Feature-first + Clean Architecture:

- presentation: UI + State management (BLoC)
- domain: entities, repository contracts, use cases
- data: datasource, models, repository implementations

Luon phu thuoc chinh:
UI -> Bloc -> UseCase -> Repository (interface) -> RepositoryImpl -> DataSource (Firebase/API/local)

Dependency Injection dung GetIt voi mo hinh dang ky theo tung feature qua cac file *_injection.dart, gom tai lib/core/di/injector.dart.

## 5) Cau truc thu muc (muc tieu)
Theo style reference:

- lib/
  - core/
    - constants/
    - di/
    - error/
    - services/
    - theme/
    - utils/
  - features/
    - <feature_name>/
      - data/
      - domain/
      - presentation/
  - main.dart

## 6) Cau truc hien tai (trong repo)
- lib/
  - app/
  - core/
    - errors/
    - utils/
  - feature/
    - auth/ (dang trong)
    - explore/
      - data/
      - domain/
      - presentation/
  - main.dart

## 7) Cong nghe su dung (hien tai)
- Flutter (Dart SDK ^3.10.7)
- Packages: cupertino_icons, google_fonts
- Assets: assets/images/, assets/icons/

## 8) Cac file tai lieu can co
- PROJECT_DOC.md (file nay: tong hop kien truc, cong nghe, yeu cau)
- USER_STORIES.md
- API_SPEC.md (neu co backend)
- DATA_MODEL.md
- TEST_PLAN.md
- RELEASE_CHECKLIST.md

## 9) Cau hoi can lam ro
- Backend da co chua? Neu chua, dung mock data hay Firebase?
- Co can real-time location cho ban be o giai doan 1 khong?
- Pham vi AI recommendations (rule-based hay ML)?
