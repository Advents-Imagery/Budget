# IncomeApp

A simple SwiftUI iOS application that stores income source details locally with Core Data and syncs the database with iCloud using `NSPersistentCloudKitContainer`.

## Features
- Basic login screen using `@AppStorage` to track logged-in state.
- Manage a list of income sources with fields for pay frequency, source name, and amount.
- Data persisted locally and backed up to iCloud via CloudKit.

## Building
Open the project in Xcode and run on an iOS device or simulator. Ensure iCloud capability is enabled for the app identifier.
