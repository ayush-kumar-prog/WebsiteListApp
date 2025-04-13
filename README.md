# WebsiteListApp

A SwiftUI iOS app that fetches a list of popular websites from a remote JSON and displays them in a searchable, sortable list. This project follows **MVVM** architecture with protocol-based service injection, making it highly testable and extensible. **No GenAI was used in the making of this project. **

## Features

- **Fetch** websites from a remote JSON endpoint.
- **Search** by name or description.
- **Sort** websites by name (case-insensitive).
- **View** detail with icon, description, and link to open in Safari.
- **MVVM Architecture** with best practices for separation of concerns.
- **Test-Driven Development** with unit & UI tests.

## Project Structure
WebsiteListApp/ ├─ Models/ ├─ Services/ ├─ ViewModels/ ├─ Views/ ├─ Tests/ └─ UITests/

## How to Run

1. Open `WebsiteListApp.xcodeproj` or `.xcworkspace` in Xcode (15+).
2. Ensure you have iOS 17/18 SDK (or the relevant installed).
3. Press **Run** (⌘ + R) to launch on the Simulator.

## How to Test

- **Unit Tests**: `Product → Test` (⌘ + U).
- **UI Tests**: Included in `WebsiteListAppUITests` – also run with ⌘ + U or from the Test Navigator.

## Future Enhancements

- Offline caching with Core Data.
- “Favorites” feature with persistent storage.
- More advanced animations/transitions.
- iPad / macOS Catalyst optimizations.

## Author

- Ayush Kumar (c) 4/13/25.
