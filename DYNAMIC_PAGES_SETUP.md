# 📱 Flutter Dynamic Pages Implementation

## ✅ Struktur yang Sudah Dibuat

### 1. **News Module** (Berita)
```
lib/mvc/news/
├── bloc/
│   └── news_cubit.dart          # States & Cubit untuk manage news
├── data/
│   ├── news_model.dart          # Data model dari API
│   └── news_repository.dart     # API integration
└── view/
    ├── berita_screen.dart       # Main news list (TODO: update UI)
    ├── berita_detail_screen.dart
    └── berita_tersimpan_screen.dart
```

**API Endpoint:**
- `GET /api/berita` - List all news
- `GET /api/berita/{slug}` - Get news detail

**Model Structure:**
```dart
NewsModel {
  id, title, slug, content, image, userId, createdAt, updatedAt
}
```

---

### 2. **Profile Module** (Profil User)
```
lib/mvc/profile/
├── bloc/
│   └── profile_cubit.dart       # States & Cubit untuk manage profile
├── data/
│   ├── profile_model.dart       # Data model dari API
│   └── profile_repository.dart  # API integration
└── view/
    ├── profile_screen.dart      # Main profile (TODO: update UI)
    └── edit_profile_screen.dart
```

**API Endpoint:**
- `GET /api/profile` - Get current user profile
- `POST /api/profile` - Update profile

**Model Structure:**
```dart
ProfileModel {
  id, name, email, role, phone, address, city, createdAt
}
```

---

### 3. **Dashboard Module** (Beranda Stats)
```
lib/mvc/dashboard/
├── bloc/
│   └── dashboard_cubit.dart     # States & Cubit untuk statistics
├── data/
│   ├── dashboard_model.dart     # Data model dari API
│   └── dashboard_repository.dart # API integration
└── view/
    └── (no dedicated view, used in home_screen)
```

**API Endpoint:**
- `GET /api/dashboard` - Get statistics

**Model Structure:**
```dart
DashboardModel {
  totalLaporan, statusPending, statusProses, statusSelesai
}
```

---

### 4. **Report Module** (Laporan - Already Exists)
```
lib/mvc/report/
├── bloc/
│   └── report_cubit.dart        # Already exists
├── data/
│   ├── report_model.dart
│   └── report_repository.dart
└── view/
    ├── laporan_screen.dart      # Main report list
    ├── buat_laporan_screen.dart # Create new report
    └── laporan_detail_screen.dart
```

---

## 🔧 Integrasi di main.dart

Semua cubits sudah didaftarkan di `MultiRepositoryProvider` dan `MultiBlocProvider`:

```dart
// Repositories
final newsRepository = NewsRepository();
final profileRepository = ProfileRepository();
final dashboardRepository = DashboardRepository();

// Cubits
BlocProvider(create: (context) => NewsCubit(newsRepository)),
BlocProvider(create: (context) => ProfileCubit(profileRepository)),
BlocProvider(create: (context) => DashboardCubit(dashboardRepository)),
```

---

## 📝 Next Steps: Update UI Screens

### 1. **Home Screen** (lib/mvc/home/view/home_screen.dart)
- Replace hardcoded greeting dengan user profile dari API
- Replace hardcoded stats dengan dashboard data dari API
- Load featured news di section "Berita Terkini"

```dart
BlocBuilder<DashboardCubit, DashboardState>(
  builder: (context, state) {
    if (state is DashboardLoaded) {
      return StatCard(
        items: [
          StatItemData(label: "Total", count: "${state.dashboard.totalLaporan}", ...),
          StatItemData(label: "Proses", count: "${state.dashboard.statusProses}", ...),
          StatItemData(label: "Selesai", count: "${state.dashboard.statusSelesai}", ...),
        ],
      );
    } else if (state is DashboardLoading) {
      return const Center(child: CircularProgressIndicator());
    } else {
      return const SizedBox();
    }
  },
)
```

### 2. **Berita Screen** (lib/mvc/news/view/berita_screen.dart)
- Replace hardcoded news list dengan API data
- Add pull-to-refresh functionality
- Add error handling & loading state

```dart
BlocBuilder<NewsCubit, NewsState>(
  builder: (context, state) {
    if (state is NewsLoaded) {
      return ListView.builder(
        itemCount: state.news.length,
        itemBuilder: (context, index) {
          final news = state.news[index];
          return NewsCard(
            title: news.title,
            content: news.content,
            image: news.image,
            ...
          );
        },
      );
    } else if (state is NewsLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (state is NewsError) {
      return Center(child: Text('Error: ${state.message}'));
    }
    return const SizedBox();
  },
)
```

### 3. **Profile Screen** (lib/mvc/profile/view/profile_screen.dart)
- Replace hardcoded user data dengan ProfileModel dari API
- Update edit profile functionality

```dart
BlocBuilder<ProfileCubit, ProfileState>(
  builder: (context, state) {
    if (state is ProfileLoaded) {
      return ProfileCard(
        name: state.profile.name,
        email: state.profile.email,
        phone: state.profile.phone,
        ...
      );
    } else if (state is ProfileLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    return const SizedBox();
  },
)
```

### 4. **Laporan Screen** (lib/mvc/report/view/laporan_screen.dart)
- Already has cubit, just update UI if needed

---

## 🚀 Testing Checklist

- [ ] Ensure all API endpoints are working in Laravel
- [ ] Test News API: `GET /api/berita`
- [ ] Test Profile API: `GET /api/profile`
- [ ] Test Dashboard API: `GET /api/dashboard`
- [ ] Run Flutter: `flutter run`
- [ ] Check console logs for errors
- [ ] Test BlocBuilder widgets load data correctly
- [ ] Test error states display properly
- [ ] Test loading states show spinners

---

## 📚 File Summary

**Created Files:**
- `lib/mvc/news/bloc/news_cubit.dart`
- `lib/mvc/news/data/news_model.dart`
- `lib/mvc/news/data/news_repository.dart`
- `lib/mvc/profile/bloc/profile_cubit.dart`
- `lib/mvc/profile/data/profile_model.dart`
- `lib/mvc/profile/data/profile_repository.dart`
- `lib/mvc/dashboard/bloc/dashboard_cubit.dart`
- `lib/mvc/dashboard/data/dashboard_model.dart`
- `lib/mvc/dashboard/data/dashboard_repository.dart`

**Modified Files:**
- `lib/main.dart` - Added all new providers and cubits

**To Be Updated (UI Integration):**
- `lib/mvc/home/view/home_screen.dart`
- `lib/mvc/news/view/berita_screen.dart`
- `lib/mvc/profile/view/profile_screen.dart`
- `lib/mvc/report/view/laporan_screen.dart`
