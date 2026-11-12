# MedTrack (Medication Adherence App)

Screenshots coming soon.

A Flutter application for tracking medications with separate Patient and Caregiver views using Firebase Authentication.

## Features

### Patient Module
- Email and password sign-in and registration via Firebase Authentication (`LoginPage`).
- Add medications with name, dosage, and reminder time (`AddMedicationPage`).
- View and delete medications in the current session (`PatientDashboard` / `AddMedicationPage`).

### Caregiver Module
- Sign in to the caregiver view (`CaregiverDashboard`).
- View overview counts and the list of medications stored in `AddMedicationPage.medications`.

### General
- Role selection (`Patient` or `Caregiver`) on the login screen.
- Material 3 UI with cross-platform Flutter project setup (Android, iOS, Web, macOS, Windows, Linux).

## Current limitations

- **In-memory medication storage:** Medications are stored in the static in-memory list `AddMedicationPage.medications` (`List<Map<String, String>>`) and are lost when the app closes.
- **Role selection is not persisted per account:** The Patient or Caregiver role is chosen on the login screen before signing in and is not stored on the user account. Any authenticated account can open either dashboard by selecting a role at login.
- **Firebase Authentication only:** Firebase is used only for Authentication (`firebase_core` and `firebase_auth`). Cloud Firestore is not used.
- **No reminder notifications:** Reminder times are stored and displayed as formatted strings only; local or push notifications are not implemented.
- **Caregiver dashboard placeholders:** `CaregiverDashboard` reads from the local `AddMedicationPage.medications` list rather than remote patient data, and the `Adherence Rate` (`95%`) and `Patients` (`1`) stat cards display static values.

## Roadmap

- Persist medications per user in Cloud Firestore.
- Store account roles and support per-patient caregiver linking.
- Add scheduled local or push reminder notifications for medication times.
- Compute adherence rate and patient counts from stored dose logs.
- Unit tests.

## Tech Stack

- **Frontend:** Flutter (Dart `>=3.0.0 <4.0.0`, Material 3)
- **Authentication:** Firebase Authentication (`firebase_core`, `firebase_auth`)
- **Platforms:** Android, iOS, Web, macOS, Windows, Linux

## Setup

1. Install dependencies:
   ```bash
   flutter pub get
   ```
2. Configure Firebase:
   - The project includes `lib/firebase_options.dart`, `firebase.json`, and `android/app/google-services.json`.
   - To use your own Firebase project, enable Email/Password sign-in in Firebase Authentication and run `flutterfire configure` to regenerate `lib/firebase_options.dart` and platform config files.
3. Run the app:
   ```bash
   flutter run
   ```

## Project Structure

```text
lib/
  main.dart                 App entry point, Firebase initialization, Material 3 theme
  firebase_options.dart     Generated Firebase configuration per platform
  login_page.dart           Email/password login, account creation, and role selector
  patient_dashboard.dart    Patient header and embedded AddMedicationPage
  add_medication_page.dart  Medication form, static medications list, and delete dialog
  caregiver_dashboard.dart  Caregiver overview cards and medication list
  medication_model.dart     Medication data model with toJson() and fromJson()
  home_page.dart            Unused medication list screen (not wired into navigation)
```
