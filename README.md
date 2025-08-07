# E-Health Project (E-Sağlık Uygulaması)

Bu proje, Flutter framework'ü kullanılarak geliştirilmiş kapsamlı bir e-sağlık mobil uygulamasıdır. Kullanıcıların sağlık ihtiyaçlarını karşılamak için tasarlanmış modern ve kullanıcı dostu bir platformdur.

## 🏥 Proje Özellikleri

### 🔐 Kimlik Doğrulama
- Firebase Authentication ile güvenli giriş/kayıt sistemi
- Kullanıcı profil yönetimi
- Oturum yönetimi

### 🏠 Ana Sayfa Özellikleri
- **BMI Hesaplayıcı**: Vücut kitle indeksi hesaplama
- **Adım Sayacı**: Günlük adım takibi
- **Hava Durumu**: Güncel hava durumu bilgileri
- **İlaç Hatırlatıcısı**: İlaç alma zamanlarını takip etme
- **Sağlık Geçmişi**: Kullanıcının sağlık verilerini kaydetme ve görüntüleme

### 🏥 Sağlık Hizmetleri
- **Nöbetçi Eczane**: Yakındaki nöbetçi eczaneleri bulma
- **Hastane Bilgileri**: Hastane lokasyonları ve bilgileri
- **Sağlık Haberleri**: Güncel sağlık haberleri ve makaleler

### 🛒 E-ticaret Özellikleri
- **Ürün Kataloğu**: Sağlık ürünleri, ilaçlar ve kozmetik ürünler
- **Alışveriş Sepeti**: Ürün ekleme, çıkarma ve sipariş verme
- **Favori Ürünler**: Beğenilen ürünleri kaydetme

### 📊 Veri Yönetimi
- **Firebase Firestore**: Bulut veritabanı entegrasyonu
- **SQLite**: Yerel veritabanı desteği
- **Shared Preferences**: Kullanıcı tercihlerini saklama

## 🚀 Kurulum

### Gereksinimler
- Flutter SDK (>=2.19.2)
- Dart SDK
- Android Studio / VS Code
- Firebase hesabı

### Adımlar

1. **Projeyi klonlayın**
```bash
git clone [repository-url]
cd e_health_project
```

2. **Bağımlılıkları yükleyin**
```bash
flutter pub get
```

3. **Firebase yapılandırması**
   - Firebase Console'da yeni bir proje oluşturun
   - `google-services.json` dosyasını `android/app/` klasörüne ekleyin
   - `GoogleService-Info.plist` dosyasını `ios/Runner/` klasörüne ekleyin

4. **Uygulamayı çalıştırın**
```bash
flutter run
```

## 📁 Proje Yapısı

```
lib/
├── main.dart                 # Uygulama giriş noktası
├── pages/                    # Sayfa bileşenleri
│   ├── login.dart           # Giriş sayfası
│   ├── register.dart        # Kayıt sayfası
│   ├── home.dart            # Ana sayfa
│   ├── welcome_page.dart    # Karşılama sayfası
│   ├── home_screen/         # Ana sayfa bileşenleri
│   │   ├── BMI_calculator.dart
│   │   ├── adim_sayar.dart
│   │   ├── weather.dart
│   │   └── medicine_screen.dart
│   ├── navigation_screen/   # Navigasyon sayfaları
│   │   ├── news.dart
│   │   ├── nobetci_eczane.dart
│   │   └── profile.dart
│   └── profile_screen/      # Profil sayfaları
├── service/                 # Servis katmanı
│   ├── auth_service.dart    # Kimlik doğrulama servisi
│   └── firebase_options.dart
├── model/                   # Veri modelleri
│   ├── product_model.dart   # Ürün modeli
│   ├── cart.dart           # Sepet modeli
│   └── blood_test_data_base.dart
├── widget/                  # Özel widget'lar
└── helpers/                 # Yardımcı fonksiyonlar
```

## 🔧 Kullanılan Teknolojiler

### Frontend
- **Flutter**: Cross-platform mobil uygulama geliştirme
- **Dart**: Programlama dili
- **Material Design**: UI/UX tasarım sistemi

### Backend & Veritabanı
- **Firebase Authentication**: Kullanıcı kimlik doğrulama
- **Firebase Firestore**: NoSQL veritabanı
- **Firebase Storage**: Dosya depolama
- **SQLite**: Yerel veritabanı

### Diğer Kütüphaneler
- `image_picker`: Resim seçimi
- `http`: HTTP istekleri
- `url_launcher`: URL açma
- `shared_preferences`: Yerel veri saklama
- `flutter_local_notifications`: Yerel bildirimler
- `percent_indicator`: İlerleme göstergeleri
- `charts_flutter`: Grafik ve çizelgeler

## 📱 Ekran Görüntüleri

[Buraya uygulamanın ekran görüntüleri eklenebilir]

## 🤝 Katkıda Bulunma

1. Bu repository'yi fork edin
2. Yeni bir branch oluşturun (`git checkout -b feature/yeni-ozellik`)
3. Değişikliklerinizi commit edin (`git commit -am 'Yeni özellik eklendi'`)
4. Branch'inizi push edin (`git push origin feature/yeni-ozellik`)
5. Pull Request oluşturun

## 📄 Lisans

Bu proje [LICENSE](LICENSE) dosyasında belirtilen lisans altında lisanslanmıştır.

## 👥 Geliştirici

Bu proje, e-sağlık alanında modern mobil uygulama geliştirme amacıyla oluşturulmuştur.

## 📞 İletişim

Proje hakkında sorularınız için:
- Email: [email-adresi]
- GitHub: [github-profil-linki]

## 🔄 Güncellemeler

### v1.0.0
- İlk sürüm yayınlandı
- Temel e-sağlık özellikleri eklendi
- Firebase entegrasyonu tamamlandı
- Kullanıcı arayüzü geliştirildi

---

**Not**: Bu uygulama geliştirme aşamasındadır ve sürekli güncellenmektedir.
