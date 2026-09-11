# Architecture Guide

## Overview
This application follows a **Clean Architecture** approach tailored for Flutter, heavily leveraging **Cubit** (BLoC) for state management and **GetIt** for Dependency Injection. 

## Folder Structure

The `lib/` directory is split into the following primary layers:

### 1. Presentation Layer (`lib/presentation/`)
- **`app/`**: Contains core application wrappers, global routing (`go_router`), and design tokens (`resources/`).
- **`features/`**: Grouped by feature (e.g., Auth, Profile, Project Creation).
  - Each feature folder contains its own UI and Cubits.
  - `common_widgets/`: Reusable, atomic design components (buttons, app bars, text fields).

### 2. Domain Layer (`lib/domain/`)
Contains business logic, entities, and abstract repository interfaces. This layer is independent of any external libraries or Flutter dependencies.

### 3. Data Layer (`lib/data/`)
Implements the interfaces defined in the domain layer. 
- Handles networking via **Dio**.
- Manages local storage (e.g., `flutter_secure_storage`, `shared_preferences`).

### 4. Core (`lib/core/`)
Cross-cutting concerns that apply across all layers:
- `config/`: App configuration and environments.
- `di/`: Dependency injection setup using GetIt.
- `error/`: Standardized error handling and failure models.
- `l10n/`: Localization setup.

### 5. Utils (`lib/utils/`)
Helper methods and extensions:
- `extensions/`: Enhancements to standard Dart/Flutter classes (e.g., `context.isRtl`, `context.textTheme`).
- `constants/`: Global app constants.

## Key Dependencies
- **State Management:** `flutter_bloc` (Cubit)
- **Routing:** `go_router`
- **Networking:** `dio`
- **Dependency Injection:** `get_it`
- **UI Scaling:** `flutter_screenutil`
- **Local Storage:** `flutter_secure_storage`, `shared_preferences`

## Navigation Strategy
All routing is managed centrally in `lib/presentation/app/navigation/app_router.dart` using `go_router`. Routes are strongly typed or referenced via `AppRouteEnum`.
