# 👗 Fashion Shop App (Flutter + Firebase)

Ứng dụng **Fashion Shop** được xây dựng bằng **Flutter**, hỗ trợ **User & Admin**, sử dụng **Firebase (Auth + Firestore)** kết hợp **SQLite** để lưu dữ liệu offline.
Ứng dụng đáp ứng đầy đủ quy trình **mua sắm – thanh toán – theo dõi đơn hàng – quản trị admin**.

---

## 📱 Tính năng chính

### 👤 User

* 🔐 Đăng nhập / Đăng ký (Email & Google)
* 🛍️ Xem danh sách sản phẩm
* ❤️ Yêu thích sản phẩm
* 🛒 Giỏ hàng (Add / Remove / Update)
* 💳 Thanh toán:

  * COD (Cash on Delivery)
  * QR Banking (Admin xác nhận)
* 📦 Theo dõi trạng thái đơn hàng **Realtime**
* 👤 Quản lý hồ sơ:

  * Cập nhật username
  * Đổi email
  * Đổi mật khẩu
  * Ảnh đại diện
* 📴 Hỗ trợ dữ liệu offline (SQLite)

---

### 🔑 Admin

* 🔐 Đăng nhập Admin (role = `admin`)
* 📦 Quản lý đơn hàng:

  * Duyệt đơn: `Pending → Confirmed → Shipping → Completed`
  * Xác nhận thanh toán QR
  * Realtime update cho User
* 🧾 CRUD sản phẩm (Create / Read / Update / Delete)
* 👥 Quản lý user (Firestore)
* 🔒 Bảo mật bằng Firestore Rules

---

## 🧱 Kiến trúc & Công nghệ

### 🚀 Công nghệ sử dụng

* **Flutter** (UI & State Management)
* **Provider** (State Management)
* **Firebase Authentication**
* **Cloud Firestore**
* **SQLite** (Offline Storage)
* **Image Picker**
* **Firebase Security Rules**

---

## 🔐 Firebase Setup

### 1️⃣ Authentication

* Enable:

  * Email/Password
  * Google Sign-In


---
---

## ▶️ Cách chạy project

```bash
flutter pub get
flutter run
```

> ⚠️ Lưu ý:

* Đảm bảo Firebase đã được cấu hình (`google-services.json`)
* Máy ảo còn đủ dung lượng

---

## 🧪 Tài khoản test

### Admin

```text
Email: admin@gmail.com
Role: admin123123
```

### User (có thể đăng kí)

```text
Email: 
Role: 
```

---

## 📌 Roadmap (Mở rộng)

* 🔔 Push Notification (Order status)
* 📊 Admin Dashboard (Chart)
* 🌐 REST API backend
* 💳 Payment Gateway (VNPay / Momo)
* 🧠 Recommendation System

---

## 👨‍💻 Tác giả

**Fashion Shop App**
Flutter • Firebase 

---

