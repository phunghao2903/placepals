# Push Notification Chào Mừng Đăng Nhập Với Flutter + Firebase

Tài liệu này tổng hợp toàn bộ cách làm, giải thích kiến trúc, quy trình triển khai, các lỗi đã gặp và cách xử lý cho tính năng `welcome push notification` khi user đăng nhập vào app `PlacePals`.

Mục tiêu của tài liệu là để lần sau có thể làm lại từ đầu hoặc handoff cho người khác mà không cần đọc lại toàn bộ lịch sử chat hay tự suy luận luồng kỹ thuật.

## 1. Mục tiêu và phạm vi

### Mục tiêu
- Khi user `đăng nhập thủ công` thành công, app gửi một `push notification chào mừng` tới đúng thiết bị vừa đăng nhập.
- Mỗi lần user `logout -> login lại`, app sẽ gửi một welcome push mới.
- Nếu app đang mở foreground, notification vẫn phải hiện ra rõ ràng cho user.

### Phạm vi hiện tại
- Chỉ hỗ trợ `Android`.
- Chỉ áp dụng cho `explicit sign-in` từ màn hình đăng nhập.
- Không áp dụng cho trường hợp app tự khôi phục session cũ khi mở lại.
- Chưa làm `iOS/APNs`.
- Chưa tối ưu nhiều token cho cùng một user.

## 2. Vì sao chọn kiến trúc này

### Không gửi push trực tiếp từ Flutter client
- Flutter client không phải môi trường tin cậy để cầm quyền gửi FCM.
- Nếu gửi trực tiếp từ app, bạn sẽ phải lộ thông tin nhạy cảm hoặc phụ thuộc vào cơ chế không an toàn.

### Dùng Cloud Functions callable
- App gọi một callable function sau khi sign-in thành công.
- Function chạy ở backend tin cậy, có thể kiểm tra auth, kiểm tra token, chống gửi trùng và ghi log vào Firestore.

### Dùng `single device token` thay vì `topic`
- Welcome push là nội dung cá nhân hóa cho đúng user và đúng thiết bị.
- `topic` hợp hơn cho broadcast, không phù hợp cho một thông báo chào mừng sau đăng nhập.

### Dùng `notification + data`
- `notification` giúp Android hiển thị notification system khi app ở background.
- `data` giúp app biết loại notification và xử lý thêm nếu cần.

### Dùng local notification khi foreground
- Khi app đang mở, FCM không luôn tự hiển thị notification system visible theo cách user mong đợi.
- Vì vậy app dùng `flutter_local_notifications` để tự hiện thông báo khi nhận message ở foreground.

## 3. Kiến trúc tổng thể

### Thành phần chính
- Flutter app
- Firebase Authentication
- Cloud Firestore
- Firebase Cloud Messaging
- Firebase Cloud Functions callable
- `flutter_local_notifications`

### Sơ đồ luồng end-to-end

```text
User sign-in thành công
-> SignupSigninBloc trigger WelcomePushCoordinator
-> xin quyền notification (Android 13+)
-> lấy FCM token
-> lưu token + lastLoginAt vào users/{uid}
-> gọi callable function sendWelcomePushOnLogin
-> Cloud Function xác thực + tạo loginPushEvents/{loginEventId}
-> Cloud Function gửi FCM notification + data
-> app nhận message
   -> foreground: hiện local notification
   -> background: Android hiển thị notification system
```

## 4. File nào đang tham gia vào flow này

### Flutter client
- [lib/main.dart](/home/phung/new3/flutter_project/placepals/lib/main.dart)
  - khởi tạo Firebase
  - khởi tạo `PushNotificationService`

- [lib/core/firebase/push_notification_service.dart](/home/phung/new3/flutter_project/placepals/lib/core/firebase/push_notification_service.dart)
  - đăng ký background handler cho FCM
  - tạo Android notification channel
  - xử lý `onMessage`, `onMessageOpenedApp`, `getInitialMessage`
  - lấy FCM token
  - lưu token vào Firestore
  - detach token khi sign-out
  - hiện local notification khi app foreground

- [lib/core/firebase/welcome_push_coordinator.dart](/home/phung/new3/flutter_project/placepals/lib/core/firebase/welcome_push_coordinator.dart)
  - orchestration sau login
  - xin quyền notification
  - sync token
  - gọi callable function `sendWelcomePushOnLogin`

- [lib/core/firebase/firebase_auth_service.dart](/home/phung/new3/flutter_project/placepals/lib/core/firebase/firebase_auth_service.dart)
  - thêm `markCurrentUserLogin()`
  - cập nhật `lastLoginAt`

- [lib/feature/signup_signin/presentation/bloc/signup_signin_bloc.dart](/home/phung/new3/flutter_project/placepals/lib/feature/signup_signin/presentation/bloc/signup_signin_bloc.dart)
  - sau khi sign-in thành công, gọi `welcomePushCoordinator.triggerAfterLogin()`

- [lib/feature/profile/presentation/pages/profile_page.dart](/home/phung/new3/flutter_project/placepals/lib/feature/profile/presentation/pages/profile_page.dart)
  - detach token trước khi sign-out

- [lib/feature/signup_signin/presentation/pages/email_verification_pending_page.dart](/home/phung/new3/flutter_project/placepals/lib/feature/signup_signin/presentation/pages/email_verification_pending_page.dart)
  - detach token ở luồng “use another account”

- [lib/core/di/injector.dart](/home/phung/new3/flutter_project/placepals/lib/core/di/injector.dart)
  - đăng ký `FirebaseAuthService`
  - đăng ký `PushNotificationService`
  - đăng ký `WelcomePushCoordinator`

### Android
- [android/app/src/main/AndroidManifest.xml](/home/phung/new3/flutter_project/placepals/android/app/src/main/AndroidManifest.xml)
  - `POST_NOTIFICATIONS`
  - default FCM channel id
  - default notification icon
  - default notification color

- [android/app/build.gradle.kts](/home/phung/new3/flutter_project/placepals/android/app/build.gradle.kts)
  - bật `coreLibraryDesugaring`
  - thêm `desugar_jdk_libs:2.1.4`

- [android/app/src/main/res/drawable/ic_stat_welcome.xml](/home/phung/new3/flutter_project/placepals/android/app/src/main/res/drawable/ic_stat_welcome.xml)
  - icon notification Android đơn sắc

### Cloud Functions
- [functions/src/index.ts](/home/phung/new3/flutter_project/placepals/functions/src/index.ts)
  - callable function `sendWelcomePushOnLogin`
  - xác thực auth
  - validate token
  - chống gửi trùng bằng `loginEventId`
  - gửi FCM

- [firebase.json](/home/phung/new3/flutter_project/placepals/firebase.json)
  - khai báo source cho Functions
  - predeploy build TypeScript

## 5. Dữ liệu Firestore hiện dùng

### Document user
Path:

```text
users/{uid}
```

Field chính:
- `androidFcmToken`
- `androidFcmTokenUpdatedAt`
- `lastLoginAt`
- `updatedAt`

### Subcollection ghi log push theo lần login
Path:

```text
users/{uid}/loginPushEvents/{loginEventId}
```

Field chính:
- `token`
- `status`
- `createdAt`
- `sentAt`
- `messageId`
- `errorMessage`

## 6. Cách triển khai chi tiết từ đầu

### Bước 1: Chuẩn bị package Flutter
Trong `pubspec.yaml`, cần có:
- `firebase_core`
- `firebase_auth`
- `firebase_messaging`
- `cloud_firestore`
- `cloud_functions`
- `flutter_local_notifications`

Sau đó chạy:

```bash
flutter pub get
```

### Bước 2: Khởi tạo push ở app startup
Trong `main.dart`:
- khởi tạo Firebase
- khởi tạo DI
- gọi `getIt<PushNotificationService>().initialize()`

Điều này giúp app:
- tạo notification channel
- đăng ký handler foreground/background
- lắng nghe token refresh

### Bước 3: Cấu hình Android bắt buộc

#### Manifest
Trong `AndroidManifest.xml`:
- thêm quyền `POST_NOTIFICATIONS`
- khai báo:
  - `default_notification_channel_id`
  - `default_notification_icon`
  - `default_notification_color`

#### Notification icon
- Android notification icon nên là icon trắng, đơn sắc
- không dùng launcher icon màu đầy đủ

#### Desugaring
`flutter_local_notifications` bản hiện tại yêu cầu `core library desugaring`.

Trong `android/app/build.gradle.kts`:
- bật:

```kotlin
isCoreLibraryDesugaringEnabled = true
```

- thêm dependency:

```kotlin
coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.4")
```

Nếu thiếu bước này, build Android sẽ fail ngay ở bước Gradle.

### Bước 4: Xử lý quyền notification
Trong `WelcomePushCoordinator`:
- chỉ xin quyền sau khi sign-in thành công
- tránh hỏi quyền quá sớm khi user chưa vào app

Trên Android 13+:
- nếu user từ chối quyền, login vẫn phải thành công
- chỉ bỏ qua welcome push flow

### Bước 5: Lấy token và sync vào Firestore
Sau khi có quyền:
- gọi `FirebaseMessaging.instance.getToken()`
- lưu token vào `users/{uid}`
- cập nhật `androidFcmTokenUpdatedAt`

Token cũng cần được đồng bộ lại khi refresh qua `onTokenRefresh`.

### Bước 6: Gọi Function sau login
Sau khi token được sync:
- tạo `loginEventId`
- gọi callable function:

```text
sendWelcomePushOnLogin({ loginEventId, token })
```

Lưu ý:
- call này không được làm hỏng luồng login chính
- nếu Function lỗi, app chỉ log lỗi

### Bước 7: Cloud Function gửi FCM
Function hiện tại làm các việc sau:
- kiểm tra `request.auth?.uid`
- đọc `users/{uid}`
- xác minh token truyền lên đúng bằng token đang lưu
- tạo `loginPushEvents/{loginEventId}` bằng create-only
- gửi FCM với payload:
  - `notification.title`
  - `notification.body`
  - `data.type = welcome_login`
  - `data.route = home`
- cập nhật trạng thái event

### Bước 8: Nhận message ở app

#### Foreground
- `FirebaseMessaging.onMessage`
- app dùng `flutter_local_notifications.show(...)`

#### Background / terminated
- FCM và Android system hiển thị notification
- tap vào notification được bắt bởi:
  - `onMessageOpenedApp`
  - `getInitialMessage`

### Bước 9: Xử lý sign-out
Trước khi sign-out:
- app gọi `detachCurrentTokenFromCurrentUser()`
- set `androidFcmToken = null`
- rồi mới `FirebaseAuth.signOut()`

Mục đích:
- tránh token còn treo ở user cũ
- nếu user khác login vào cùng thiết bị, token sẽ được gắn lại đúng người

### Bước 10: Deploy Cloud Functions

Ở thư mục repo:

```bash
cd /home/phung/new3/flutter_project/placepals/functions
npm install
```

Deploy:

```bash
cd /home/phung/new3/flutter_project/placepals
npx firebase-tools@latest deploy --only functions --project placepals-a5221
```

Lưu ý:
- hiện tại nên dùng `npx firebase-tools@latest`
- không nên tin tưởng lệnh `firebase deploy` nếu CLI global trên máy bị cũ/hỏng

## 7. Trên Firebase Console và Google Cloud Console cần làm gì

### Firebase Console
- Bật `Authentication`
  - provider `Email/Password`
- Bật `Cloud Firestore`
- Nâng billing lên `Blaze`

### Google Cloud Console
- Tạo `App Engine` cho đúng project `placepals-a5221`
- region nên chọn `asia-southeast1 (Singapore)` nếu user ở Việt Nam

Lưu ý cực quan trọng:
- Firebase Console và Google Cloud Console có thể đang dùng khác account hoặc khác project
- Phải kiểm tra kỹ top bar project
- Tránh nhầm `My First Project` với `placepals-a5221`

## 8. Checklist thao tác nhanh

### Trước khi code
- Đã có project Firebase đúng
- Đã bật Firestore
- Đã bật Auth Email/Password
- Đã ở Blaze plan
- Đã có `google-services.json`

### Trước khi deploy
- `npm install` trong `functions/` đã xong
- `firebase projects:list` thấy `placepals-a5221`
- App Engine đã được tạo cho đúng project
- Dùng `npx firebase-tools@latest`

### Trước khi test
- Chạy app Android trên thiết bị/emulator có Google Play Services
- User có thể đăng nhập bằng email verified
- Chấp nhận quyền notification nếu Android 13+
- Kiểm tra Firestore document `users/{uid}`

## 9. Lỗi thường gặp và cách xử lý

### Lỗi: `No currently active project`
#### Triệu chứng
- `firebase deploy --only functions` báo không có active project

#### Nguyên nhân
- Firebase CLI chưa gắn repo với project

#### Cách kiểm tra

```bash
firebase projects:list
```

#### Cách sửa

```bash
firebase use --add
```

hoặc deploy thẳng:

```bash
firebase deploy --only functions --project placepals-a5221
```

### Lỗi: `Unexpected key extensions`
#### Triệu chứng
- deploy functions fail ở bước parse build specification

#### Nguyên nhân
- đang dùng `firebase-tools` global cũ/hỏng
- shell vẫn trỏ tới binary cũ trong `/usr/local/bin/firebase`

#### Cách kiểm tra

```bash
which firebase
firebase --version
```

#### Cách sửa
- cách an toàn nhất:

```bash
npx firebase-tools@latest deploy --only functions --project placepals-a5221
```

- nếu muốn sửa dứt điểm CLI global:
  - gỡ bản cũ
  - cài lại global
  - kiểm tra `which firebase`

### Lỗi: `Could not authenticate ... gcf-admin-robot ... Not found`
#### Triệu chứng
- deploy Functions đi được xa nhưng fail ở bước generate upload URL

#### Nguyên nhân
- project chưa có hạ tầng Google Cloud đầy đủ cho Functions
- thường là thiếu App Engine hoặc service identity chưa được provision xong

#### Cách kiểm tra
- mở Google Cloud Console
- kiểm tra App Engine đã được tạo cho đúng project chưa

#### Cách sửa
- tạo App Engine trong đúng project `placepals-a5221`
- chờ vài phút
- deploy lại

### Lỗi: nhầm project `My First Project`
#### Triệu chứng
- Firebase CLI thấy đúng project
- nhưng Google Cloud Console chỉ hiện `My First Project`

#### Nguyên nhân
- browser đang dùng account khác
- hoặc đang nhìn nhầm project trong top bar

#### Cách kiểm tra
- nhìn top bar của Google Cloud Console
- kiểm tra đúng project là `placepals-a5221`

#### Cách sửa
- đổi đúng account Google
- mở link trực tiếp với project id:

```text
https://console.cloud.google.com/appengine?project=placepals-a5221
```

### Lỗi: `flutter_local_notifications requires core library desugaring`
#### Triệu chứng
- `flutter run` hoặc Gradle fail ở `checkDebugAarMetadata`

#### Nguyên nhân
- chưa bật desugaring trong `android/app/build.gradle.kts`

#### Cách kiểm tra
- xem `compileOptions` đã có `isCoreLibraryDesugaringEnabled = true` chưa
- xem `dependencies` đã có `desugar_jdk_libs:2.1.4` chưa

#### Cách sửa
- bật `isCoreLibraryDesugaringEnabled = true`
- thêm:

```kotlin
coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.4")
```

## 10. Quy trình test end-to-end

### Test cơ bản
1. Mở app Android
2. Login bằng user hợp lệ
3. Chấp nhận quyền notification nếu được hỏi
4. Kiểm tra welcome push có tới không

### Test Firestore
Kiểm tra:
- `users/{uid}.androidFcmToken`
- `users/{uid}.androidFcmTokenUpdatedAt`
- `users/{uid}.lastLoginAt`

Kiểm tra subcollection:
- `users/{uid}/loginPushEvents/{loginEventId}`

### Test logout-login lại
1. Logout
2. Login lại cùng user
3. Kiểm tra có welcome push mới

### Test foreground
- app đang mở
- sign-in xong
- notification vẫn phải hiện qua local notification

### Test background
- app ở background
- notification phải hiện như notification system

## 11. Hiện trạng implementation trong repo

### Đã có
- Welcome push sau explicit login
- Local notification khi foreground
- Detach token khi sign-out
- Cloud Function callable để gửi push
- Firestore event log theo từng lần login

### Giới hạn hiện tại
- Chỉ Android
- Function đang ở `us-central1`
- Chưa có iOS/APNs
- Chưa tối ưu nhiều thiết bị cho một user
- Chưa có deep link riêng khi tap notification

## 12. Nâng cấp về sau

### Đổi region gần Việt Nam hơn
- chuyển function sang `asia-southeast1`
- đồng bộ client callable sang cùng region

### Nâng runtime backend
- đổi Node runtime từ `20` lên `22`
- nâng `firebase-functions` lên bản mới hơn

### Siết bảo mật
- viết Firestore rules rõ ràng cho:
  - user chỉ update metadata của chính mình
  - client không được tự ghi `loginPushEvents`

### Hỗ trợ nhiều thiết bị
- thay `androidFcmToken` đơn lẻ bằng token registry
- cho phép một user có nhiều token active

### Hỗ trợ iOS
- thêm APNs
- cấu hình permission và handling riêng cho iOS

## 13. Command tham chiếu nhanh

### Flutter

```bash
flutter pub get
flutter run
```

### Functions

```bash
cd /home/phung/new3/flutter_project/placepals/functions
npm install
```

```bash
cd /home/phung/new3/flutter_project/placepals
npx firebase-tools@latest deploy --only functions --project placepals-a5221
```

### Firebase CLI

```bash
firebase projects:list
firebase use --add
firebase login
firebase logout
```

## 14. Tài liệu chính thức nên tra cứu thêm
- Firebase Cloud Messaging cho Flutter:
  - https://firebase.google.com/docs/cloud-messaging/flutter/receive-messages
- Quản lý FCM token:
  - https://firebase.google.com/docs/cloud-messaging/manage-tokens
- Message types của FCM:
  - https://firebase.google.com/docs/cloud-messaging/customize-messages/set-message-type
- Firebase Functions callable:
  - https://firebase.google.com/docs/functions/callable
- Firebase Functions getting started:
  - https://firebase.google.com/docs/functions/get-started
- Firebase Functions locations:
  - https://firebase.google.com/docs/functions/locations

## 15. Kết luận ngắn
- Với use case “chào mừng user sau đăng nhập”, kiến trúc `Flutter + FCM + Firestore + Cloud Functions callable` là phù hợp và an toàn.
- Cái khó nhất không nằm ở code gửi notification, mà nằm ở:
  - đồng bộ token đúng lúc
  - không làm hỏng luồng login
  - cấu hình Android đúng
  - deploy Functions đúng project, đúng CLI, đúng Google Cloud backend
- Khi gặp lỗi, hãy kiểm tra theo thứ tự:
  1. project đúng chưa
  2. account đúng chưa
  3. Firebase CLI đúng chưa
  4. App Engine đã tạo chưa
  5. Android desugaring đã bật chưa
