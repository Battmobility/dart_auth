# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is `batt_auth` - a Flutter package that provides authentication functionality for BattMobility applications. It's a reusable library that handles login, registration, password reset, and token management with Keycloak integration.

## Common Commands

### Testing
- `flutter test` - Run all tests for the package
- `cd example && flutter test` - Run tests for the example app

### Development
- `flutter analyze` - Run static analysis
- `flutter pub get` - Get dependencies
- `flutter pub deps` - Show dependency tree
- `dart format .` - Format code
- `flutter gen-l10n` - Generate localization files

### Example App
- `cd example && flutter run` - Run the example application
- `cd example && flutter build web` - Build example for web
- `cd example && flutter build apk` - Build example for Android

## Architecture

### Package Structure
The package follows a clean architecture pattern with three main layers:

1. **Domain Layer** (`lib/authentication/domain/`):
   - `models/` - Core data models (Accesstoken, AuthStatus)
   - `repositories/` - Abstract repository interfaces
   - `exceptions/` - Domain-specific exceptions
   - `mappers/` - Data transformation logic

2. **Data Layer** (`lib/authentication/data/`):
   - `datasource/` - Remote data sources for API calls
   - `repositories/` - Concrete repository implementations
   - `services/` - Network services (Dio-based)

3. **Presentation Layer** (`lib/authentication/presentation/`):
   - `screens/` - Login screen implementation
   - `widgets/` - Reusable UI components

### Key Components

- **BattAuth**: Main class for package initialization (`lib/batt_auth.dart`)
- **AuthenticationRepository**: Core repository for auth operations
- **DioAuthNetworkService**: HTTP client implementation using Dio
- **LoginScreen**: Main authentication UI with login/register/forgot password flows

### Localization
- Uses Flutter's internationalization with ARB files
- Supports English (en), French (fr), and Dutch (nl)
- Configuration in `l10n.yaml`
- Generated files in `lib/l10n/`

### Dependencies
- **dio**: HTTP client for API calls
- **flutter_secure_storage**: Secure token storage
- **url_launcher**: For external authentication flows
- **batt_ds**: Internal design system package

## Integration Notes

To use this package:
1. Initialize with `BattAuth.init(authUrl, apiUrl)`
2. Call `login()` function with required callbacks
3. Handle `Accesstoken` objects for authenticated requests
4. Use `refreshAccessToken()` for token renewal

The package expects Keycloak-compatible authentication endpoints and handles OAuth2/OpenID Connect flows.