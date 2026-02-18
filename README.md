# 📱 Merchant Product Management App

A production-ready **Flutter application** built as part of a **Senior Mobile Engineer (Flutter) Take Home Test**.
The app allows merchants to manage products with **offline-first capability**, automatic synchronization, and clean architecture.

---

## 🚀 Demo Features

- 📦 Product List (Pagination / Infinite Scroll)
- 🔍 Product Detail View
- ➕ Create Product
- ✏️ Edit Product
- 📶 Offline-first support
- 🔄 Automatic sync when network restored
- ⚠️ Error, loading, and offline states handling

---

## 🏗️ Architecture Overview

This project follows **Clean Architecture** principles:

```
lib/
├── core/
│   ├── error/
│   ├── network/
│   └── utils/
│
├── data/
│   ├── datasources/
│   │   ├── local/
│   │   └── remote/
│   ├── models/
│   └── repositories/
│
├── domain/
│   ├── entities/
│   ├── repositories/
│   └── usecases/
│
└── presentation/
    ├── pages/
    ├── widgets/
    └── state_management/
```

### Patterns Used

- Repository Pattern
- Dependency Injection (get_it)
- Bloc / Cubit for State Management
- Offline-first architecture

---

## 🧰 Tech Stack

- Flutter (latest stable)
- State Management: Bloc / Cubit
- Local Database: Hive / Drift / SQLite
- HTTP Client: Dio / http
- Connectivity Detection: connectivity_plus
- Dependency Injection: get_it

---

## 🌐 Backend (Mock API)

Mock backend powered by:

👉 JSON Server

### Base URL

```
http://localhost:3000
```

### API Endpoints

| Method | Endpoint                      | Description            |
| ------ | ----------------------------- | ---------------------- |
| GET    | /products?\_page=1&\_limit=20 | Paginated product list |
| GET    | /products/{id}                | Product detail         |
| POST   | /products                     | Create product         |
| PUT    | /products/{id}                | Update product         |

---

## ⚙️ Getting Started

### 1. Clone Repository

```bash
git clone https://github.com/yourusername/merchant-product-app.git
cd merchant-product-app
```

---

### 2. Install Dependencies

```bash
flutter pub get
```

---

### 3. Run Mock Backend

Make sure Node.js installed.

```bash
cd mock-backend
npx json-server --watch db.json --port 3000
```

Test in browser:

```
http://localhost:3000/products
```

---

### 4. Run Flutter App

```bash
flutter run
```

---

## 📡 Offline-First Strategy

### 🔽 Read Flow

1. Load data from **local database**
2. Display immediately to user
3. Fetch from server in background
4. Update local cache + UI

---

### ✍️ Write Flow (Create / Update)

1. Save data to **local DB first**
2. Mark as `pending_sync`
3. UI updates instantly
4. Sync to server when connection available

---

## 🔄 Synchronization Strategy

### Sync Triggered When:

- App start
- Connectivity restored
- Manual refresh

### Sync Process

```
for each pending item:
   send request to server
   if success:
      update local data
      remove pending flag
   else:
      retry with exponential backoff
```

### Retry Policy

- Exponential backoff
- Retry limit configurable
- Failed items remain in queue

---

## ⚔️ Conflict Handling (HTTP 409)

In real backend, conflicts may occur if data outdated.

### Conflict Detection

Based on `updatedAt` field:

```
if local.updatedAt < server.updatedAt → conflict
```

### Resolution Strategy

Current strategy: **Last Write Wins + User Awareness**

User will be prompted with options:

- Use server version
- Keep local version (force overwrite)
- Manual merge (future enhancement)

---

## 📶 Network Handling

Using:

- connectivity_plus

Handled states:

- Online
- Offline
- Slow connection

UI Indicators:

- Offline banner
- Sync progress indicator
- Retry button

---

## 🧪 Error Handling

Handled across layers:

- Network error
- API error
- Local database error
- Sync failure

User sees friendly UI states instead of crashes.

---

## ⚖️ Trade-offs & Decisions

| Decision                 | Reason                      |
| ------------------------ | --------------------------- |
| Local-first storage      | Better UX & offline support |
| Bloc State Management    | Predictable & testable      |
| Repository Pattern       | Scalable & maintainable     |
| Last-write-wins conflict | Simpler UX                  |
| Background sync queue    | Avoid data loss             |

---

## 🔮 Future Improvements

- Background sync with WorkManager
- Conflict diff UI
- Real-time sync (WebSocket)
- Unit & integration tests
- Authentication layer

---

## 👨‍💻 Author

**Fikry Andias Praja**
Flutter & Android Developer

---

## 📌 Notes

This project emphasizes:

✔ System Design
✔ Architecture
✔ Data Flow
✔ Offline Capability

instead of UI polish.

---

## ⭐️ If you find this useful

Feel free to give a ⭐️ to this repository!
