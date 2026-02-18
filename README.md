# Turkish Marketer

A comprehensive Flutter mobile application for the Turkish Marketer platform — connecting businesses, browsing posts and companies, managing categories, and handling requests for quotation (RFQ). Built with modern Flutter architecture patterns and supporting multiple languages including RTL layouts.

---

## 📱 Features

### Authentication & Onboarding
- **Onboarding Flow** — Interactive first-time user experience with page indicators
- **User Registration** — Sign up with phone number and email verification
- **Phone Verification** — OTP-based verification using `flutter_verification_code`
- **Login** — Secure authentication with token-based sessions
- **Company Registration** — Add company information during onboarding
- **Session Management** — Automatic token refresh and session persistence

### Core Features
- **Home Feed** — Browse posts with images, descriptions, country info, credits, and timestamps
- **Post Details** — Detailed view with attachments, contact information, and tags
- **Companies Directory** — Browse companies with detailed profiles
- **Company Details** — View company information, products, and contact details
- **RFQ (Request for Quotation)** — Submit and manage quotation requests
- **Categories & Sub-categories** — Hierarchical category browsing with filters
- **Category Filters** — Advanced filtering options for refined searches
- **Search** — Global search across posts, companies, and products
- **Profile Management** — Edit profile, change password, manage agents
- **Product Index** — Browse and manage product listings
- **Agents Management** — Manage company agents and representatives
- **WebView Integration** — Embedded web content support

### Technical Features
- **Multi-language Support** — English, Turkish, and Arabic (RTL-ready)
- **Offline Capability** — Connectivity awareness with `connectivity_plus`
- **Image Caching** — Optimized image loading with `cached_network_image`
- **File Picker** — Document and media selection with `file_picker`
- **Phone Number Input** — International phone number formatting with `libphonenumber_plugin`
- **Keyboard Management** — Enhanced keyboard handling with `keyboard_actions`
- **SVG Support** — Vector graphics rendering with `flutter_svg`

---

## 🛠 Tech Stack

| Category                | Technology                          | Purpose                                    |
|------------------------|-------------------------------------|--------------------------------------------|
| **Framework**          | Flutter                             | Cross-platform mobile development          |
| **Language**           | Dart 3.4.3+                         | Programming language                       |
| **State Management**  | Riverpod 2.5.1                      | Reactive state management                  |
| **Dependency Injection** | GetIt 7.7.0                      | Service locator pattern                    |
| **HTTP Client**        | Dio 5.7.0                           | RESTful API communication                  |
| **Local Storage**      | SharedPreferences 2.0.9             | Key-value persistent storage              |
| **Localization**       | flutter_localizations + intl 0.19.0 | Multi-language support                     |
| **UI Components**      | Material Design                     | Material Design components                 |
| **Vector Graphics**    | flutter_svg 2.0.10                  | SVG image rendering                        |
| **Image Loading**      | cached_network_image 3.4.1          | Network image caching                      |
| **Connectivity**       | connectivity_plus 5.0.2             | Network status monitoring                  |
| **File Handling**     | file_picker 8.1.2                   | File selection from device                 |
| **Phone Numbers**      | libphonenumber_plugin 0.3.3         | International phone formatting             |
| **WebView**            | webview_flutter 4.8.0               | Embedded web content                       |
| **Verification**       | flutter_verification_code 1.1.7     | OTP input widgets                          |
| **Keyboard**           | keyboard_actions 4.2.0              | Enhanced keyboard interactions             |
| **Form Generation**    | json_gen_form 0.3.0                 | Dynamic form generation                    |

---

## 📋 Prerequisites

### Required Software
- **Flutter SDK** `>=3.4.3 <4.0.0`
- **Dart** 3.4.3 or higher
- **Git** for version control

### Platform-Specific Requirements

#### iOS/macOS
- **Xcode** (latest stable version)
- **CocoaPods** (`sudo gem install cocoapods`)
- **macOS** for iOS development

#### Android
- **Android Studio** or **Android SDK**
- **Java Development Kit (JDK)** 11 or higher
- **Android SDK** with API level 21+

### Verify Installation

```bash
# Check Flutter installation
flutter doctor

# Verify Dart version
dart --version

# Check connected devices
flutter devices
```

---

## 🚀 Getting Started

### 1. Clone the Repository

```bash
git clone <repository-url>
cd turkish_marketer_app
```

### 2. Install Dependencies

```bash
flutter pub get
```

For iOS, also install CocoaPods dependencies:

```bash
cd ios
pod install
cd ..
```

### 3. Configure Assets

Ensure these asset directories exist and are populated:

```
assets/
├── locale/
│   ├── localization_en.json    # English translations
│   ├── localization_tr.json    # Turkish translations
│   └── localization_ar.json    # Arabic translations
├── images/
│   └── [app images and icons]
└── fonts/
    ├── Inter-Medium.ttf
    ├── Inter-Regular.ttf
    └── Inter-SemiBold.ttf
```

### 4. Configure Environment

Edit `lib/environment.dart` to set your environment:

```dart
const Env runningEnvironment = Env.production; // or Env.stage
```

Update API endpoints in `lib/api_service/endpoints.dart`:

```dart
static const String _baseUrl = "https://your-api-domain.com/public/";
```

### 5. Run the Application

#### Debug Mode
```bash
# Run on connected device/emulator
flutter run

# Run on specific device
flutter run -d <device-id>

# Run with hot reload enabled (default)
# Press 'r' for hot reload, 'R' for hot restart
```

#### Release Mode
```bash
# Android
flutter run --release

# iOS
flutter run --release
```

### 6. Build for Production

#### Android
```bash
# APK (for direct installation)
flutter build apk

# App Bundle (for Play Store)
flutter build appbundle

# Split APKs by ABI (smaller file size)
flutter build apk --split-per-abi
```

#### iOS
```bash
# Build iOS app
flutter build ios

# Then open in Xcode for archive and distribution
open ios/Runner.xcworkspace
```

---

## 📁 Project Structure

```
turkish_marketer_app/
├── lib/
│   ├── main.dart                      # App entry point, theme, localization setup
│   ├── di.dart                        # Dependency injection (GetIt) configuration
│   ├── environment.dart               # Environment config (production/stage)
│   ├── extentions.dart                # Dart extensions (e.g., String.localized())
│   │
│   ├── api_service/                   # API layer
│   │   ├── endpoints.dart             # API endpoint definitions
│   │   ├── base_response.dart         # Base response model with Status
│   │   └── dio_error_printer.dart     # Error handling utilities
│   │
│   ├── models/                        # Data models
│   │   ├── user_model.dart            # User authentication model
│   │   ├── post_model.dart            # Post/feed item model
│   │   ├── lookup_model.dart          # Lookup/reference data model
│   │   └── registration_info_model.dart # Registration data model
│   │
│   ├── screens/                       # Feature screens & view models
│   │   ├── pre_app/                   # Pre-app initialization screen
│   │   ├── on_boarding/               # Onboarding flow
│   │   │   ├── on_boarding_screen.dart
│   │   │   ├── on_boarding_view_model.dart
│   │   │   └── widgets/
│   │   │       ├── page_indicator.dart
│   │   │       ├── text_page_view.dart
│   │   │       └── bottom_buttons_view.dart
│   │   │
│   │   ├── auth/                      # Authentication screens
│   │   │   ├── login/
│   │   │   │   ├── login_screen.dart
│   │   │   │   └── login_view_model.dart
│   │   │   ├── signup/
│   │   │   │   ├── signup_screen.dart
│   │   │   │   └── signup_view_model.dart
│   │   │   ├── verification/
│   │   │   │   ├── verification_screen.dart
│   │   │   │   └── verification_view_model.dart
│   │   │   └── addCompany/
│   │   │       ├── add_company_screen.dart
│   │   │       └── add_company_view_model.dart
│   │   │
│   │   ├── allTabs/                   # Main app tabs
│   │   │   ├── home/
│   │   │   │   ├── home_screen.dart
│   │   │   │   ├── home_view_model.dart
│   │   │   │   └── post_details/
│   │   │   ├── companies/
│   │   │   │   ├── companies_screen.dart
│   │   │   │   ├── companies_view_model.dart
│   │   │   │   ├── company_ details/
│   │   │   │   └── rfq_screen/
│   │   │   └── categories/
│   │   │       ├── categories_screen.dart
│   │   │       ├── categories_view_model.dart
│   │   │       ├── sub_categories/
│   │   │       └── category_filter/
│   │   │
│   │   ├── profile/                   # User profile screens
│   │   │   ├── profile_screen.dart
│   │   │   ├── profile_view_model.dart
│   │   │   ├── edit_profile/
│   │   │   ├── change_password/
│   │   │   ├── agents/
│   │   │   └── Index_of_products/
│   │   │
│   │   ├── search/                    # Search functionality
│   │   │   └── search_screen.dart
│   │   │
│   │   ├── tab_bar/                   # Bottom navigation
│   │   │   ├── tab_bar_screen.dart
│   │   │   └── tab_bar_view_model.dart
│   │   │
│   │   └── web_view_app.dart          # WebView wrapper
│   │
│   └── utils/                         # Utilities & shared code
│       ├── app_translations/          # Localization system
│       │   ├── app_translations.dart  # Translation loader
│       │   └── language_model.dart    # Language model
│       │
│       ├── app_widgets/               # Reusable UI components
│       │   ├── buttons_widgets/
│       │   │   ├── custom_app_button.dart
│       │   │   ├── custom_app_text_button.dart
│       │   │   ├── custom_app_back_button.dart
│       │   │   ├── app_back_button.dart
│       │   │   ├── cancel_and_save_buttons_row.dart
│       │   │   └── switch_with_text_button.dart
│       │   │
│       │   ├── text_field_widgets/
│       │   │   ├── custom_app_text_field.dart
│       │   │   ├── custom_app_intl_phone_field.dart
│       │   │   └── search_bar_text_field.dart
│       │   │
│       │   ├── app_card_widgets/
│       │   │   ├── post_card.dart
│       │   │   ├── post_details_card.dart
│       │   │   ├── company_card.dart
│       │   │   ├── product_card.dart
│       │   │   ├── profile_card.dart
│       │   │   ├── index_product_card.dart
│       │   │   ├── sub_category_widget.dart
│       │   │   ├── check_box_card.dart
│       │   │   └── list_card.dart
│       │   │
│       │   ├── list_views_widgets/
│       │   │   ├── products_list_view.dart
│       │   │   ├── attachments_container_list_view.dart
│       │   │   ├── contact_info_container_view.dart
│       │   │   ├── tags_container_list_view.dart
│       │   │   └── list_view_container_builder.dart
│       │   │
│       │   ├── slider_widgets/
│       │   │   ├── custom_slider_container.dart
│       │   │   └── custom_slider_button.dart
│       │   │
│       │   ├── custom_app_text.dart   # Custom text widget
│       │   ├── custom_app_bar.dart    # Custom app bar
│       │   ├── drop_down_button.dart  # Dropdown widget
│       │   ├── icon_tag_view.dart     # Icon tag display
│       │   └── app_top_header_image.dart
│       │
│       ├── common_widgets/            # Shared widgets
│       │   ├── error_dialog.dart      # Error dialog (iOS/Android)
│       │   ├── loading_dialog.dart    # Loading overlay
│       │   ├── app_circular_progress.dart
│       │   ├── shimmer_loading.dart   # Shimmer effect
│       │   ├── no_data_view.dart      # Empty state
│       │   └── cached_url_image.dart  # Cached image wrapper
│       │
│       ├── decoration_and_assets/     # Design system
│       │   ├── colors.dart            # Color constants
│       │   ├── dimentions.dart        # Spacing/sizing constants
│       │   ├── decorations.dart      # Box decorations
│       │   └── images.dart            # Image asset paths
│       │
│       ├── routing/                   # Navigation system
│       │   ├── routes.dart            # Route name constants
│       │   ├── router.dart            # Route generator
│       │   └── navigation_service.dart # Navigation utilities
│       │
│       ├── IntlPhoneField/            # Phone field components
│       │   ├── intl_phone_field.dart
│       │   ├── countries.dart
│       │   └── helpers.dart
│       │
│       ├── change_langage_dialog/     # Language switcher
│       │   ├── change_language_view.dart
│       │   └── change_language_state.dart
│       │
│       ├── local_repository.dart      # SharedPreferences wrapper
│       ├── hide_keyboard_on_tap.dart  # Keyboard utilities
│       └── ...
│
├── assets/                            # App assets
│   ├── locale/                        # Translation JSON files
│   ├── images/                        # Images and icons
│   └── fonts/                         # Inter font family
│
├── ios/                               # iOS platform code
├── android/                           # Android platform code
├── web/                               # Web platform code (if applicable)
├── linux/                             # Linux platform code
├── macos/                             # macOS platform code
├── windows/                           # Windows platform code
│
├── pubspec.yaml                       # Dependencies & configuration
├── analysis_options.yaml              # Linter rules
└── README.md                          # This file
```

---

## 🏗 Architecture

### Design Pattern: MVVM (Model-View-ViewModel)

The app follows the **MVVM (Model-View-ViewModel)** pattern with **Riverpod** for state management:

- **Model** — Data models in `lib/models/`
- **View** — UI screens (StatelessWidget/StatefulWidget)
- **ViewModel** — State management with Riverpod providers (e.g., `*_view_model.dart`)

### State Management with Riverpod

```dart
// Example: ViewModel Provider
final homeViewModelProvider = StateNotifierProvider<HomeViewModel, HomeState>(
  (ref) => HomeViewModel(),
);

// Usage in Screen
final viewModel = ref.watch(homeViewModelProvider);
```

### Dependency Injection with GetIt

Services are registered in `lib/di.dart`:

```dart
// Service Locator
final sl = GetIt.instance;

// Registration
sl.registerLazySingleton<Dio>(() => client);
sl.registerLazySingleton<LocalRepo>(() => LocalRepo(...));
sl.registerLazySingleton<NavigationService>(() => NavigationService());
```

### API Architecture

- **Base URL**: Configured in `lib/api_service/endpoints.dart`
- **API Version**: `v1.0`
- **Response Format**: Standardized `BaseResponse<T>` with `Status` object
- **Error Handling**: Dio interceptors handle 401 (unauthorized) and show error dialogs
- **Headers**: Content-Language header for localization

**Available Endpoints:**
- `POST /user/login` — User authentication
- `POST /user/signUp` — User registration
- `POST /user/addCompany` — Add company information
- `POST /user/verifyEmail` — Email verification
- `POST /user/resendActivationCode` — Resend OTP
- `POST /user/logout` — User logout
- `GET /constants/getOptions` — Fetch lookup/options data

---

## 🌍 Localization

### Supported Languages
- **English** (`en`) — Default
- **Turkish** (`tr`)
- **Arabic** (`ar`) — RTL support

### Translation Files
Translation JSON files are located in `assets/locale/`:
- `localization_en.json`
- `localization_tr.json`
- `localization_ar.json`

### Usage in Code

```dart
// Using extension method
Text('welcome'.localized())

// Or using AppTranslations
AppTranslations.of(context)?.text('welcome')
```

### Changing Language

Language preference is stored in `SharedPreferences` and can be changed via the language dialog (`utils/change_langage_dialog/`).

---

## 🎨 UI Components

### Custom Widgets

The app includes a comprehensive set of reusable widgets:

- **Buttons**: `customButtonApp`, `customAppTextButton`, `customAppBackButton`
- **Text Fields**: `customAppTextField`, `customAppIntlPhoneField`, `searchBarTextField`
- **Cards**: `PostCard`, `CompanyCard`, `ProductCard`, `ProfileCard`
- **Lists**: `ProductsListView`, `AttachmentsContainerListView`
- **Dialogs**: `showErrorDialog`, `LoadingAlertDialog`
- **App Bar**: `customAppBar` with profile and search actions

### Design System

- **Font Family**: Inter (Medium, Regular, SemiBold)
- **Colors**: Defined in `utils/decoration_and_assets/colors.dart`
- **Dimensions**: Spacing constants in `utils/decoration_and_assets/dimentions.dart`
- **Theme**: Material Design with custom AppBar theme

---

## 🔧 Configuration

### Environment Setup

Edit `lib/di.dart` to change the running environment:

```dart
const Env runningEnvironment = Env.production; // or Env.stage
```

### API Configuration

Update the base URL in `lib/api_service/endpoints.dart`:

```dart
static const String _baseUrl = "https://your-api-domain.com/public/";
```

### Localization

Add translation files to `assets/locale/` following the naming pattern:
- `localization_{language_code}.json`

### Fonts

Ensure Inter font files are in `assets/fonts/`:
- `Inter-Medium.ttf`
- `Inter-Regular.ttf`
- `Inter-SemiBold.ttf`

---

## 🧪 Development

### Running Tests

```bash
# Run all tests
flutter test

# Run tests with coverage
flutter test --coverage
```

### Code Analysis

```bash
# Analyze code
flutter analyze

# Format code
flutter format lib/

# Check for issues
flutter pub run flutter_lints:analyze
```

### Hot Reload & Hot Restart

- **Hot Reload** (`r`): Preserves app state, fast updates
- **Hot Restart** (`R`): Restarts app, clears state
- **Full Restart**: Stop and restart the app

### Debugging

```bash
# Run in debug mode with verbose logging
flutter run --verbose

# Run with specific flavor (if configured)
flutter run --flavor production
```

---

## 🐛 Troubleshooting

### Common Issues

#### iOS Build Issues
```bash
# Clean and reinstall pods
cd ios
rm -rf Pods Podfile.lock
pod install
cd ..
flutter clean
flutter pub get
```

#### Android Build Issues
```bash
# Clean build
flutter clean
flutter pub get
cd android
./gradlew clean
cd ..
```

#### Dependency Conflicts
```bash
# Update dependencies
flutter pub upgrade
flutter pub get
```

#### Localization Not Working
- Ensure JSON files exist in `assets/locale/`
- Check `pubspec.yaml` includes assets path
- Verify file naming: `localization_{code}.json`

#### API Connection Issues
- Verify base URL in `endpoints.dart`
- Check network permissions in `AndroidManifest.xml` / `Info.plist`
- Ensure backend CORS settings allow mobile app requests

---

## 📱 Platform-Specific Notes

### iOS
- Minimum iOS version: Check `ios/Podfile` and `ios/Runner.xcodeproj`
- Requires `Info.plist` configuration for network permissions
- Uses CocoaPods for native dependencies

### Android
- Minimum SDK version: Check `android/app/build.gradle`
- Requires internet permission in `AndroidManifest.xml`
- Uses Gradle for dependency management

---

## 🔐 Security Considerations

- **Token Storage**: User tokens stored securely in `SharedPreferences`
- **API Authentication**: Token-based authentication with refresh tokens
- **HTTPS**: All API calls should use HTTPS (configure in endpoints)
- **Input Validation**: Implement validation in view models
- **Error Handling**: Sensitive error messages should not be exposed to users

---

## 📝 Code Style

The project follows Flutter/Dart style guidelines:
- Use `flutter_lints` package for linting rules
- Follow Dart style guide: https://dart.dev/guides/language/effective-dart/style
- Use meaningful variable and function names
- Add comments for complex logic

---

## 🤝 Contributing

1. Create a feature branch from `main`
2. Make your changes following the code style
3. Test your changes thoroughly
4. Submit a pull request with a clear description

---

## 📄 License

This project is private and not published to pub.dev (`publish_to: 'none'` in `pubspec.yaml`). All rights reserved.

---

## 📞 Support

For issues, questions, or contributions, please contact the development team or create an issue in the repository.

---

## 🔄 Version History

- **v0.1.0** — Initial release
  - Core authentication flow
  - Home feed with posts
  - Companies directory
  - Categories and filters
  - Profile management
  - Multi-language support (EN, TR, AR)

---

**Built with ❤️ using Flutter**
