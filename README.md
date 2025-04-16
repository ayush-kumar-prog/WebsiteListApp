# WebsiteListApp

A SwiftUI iOS app that fetches a list of popular websites from a remote JSON and displays them in a searchable, sortable list. This project follows **MVVM** architecture with protocol-based service injection, making it highly testable and extensible. **No GenAI was used in the making of this project. **

## Features

- **Fetch:** Retrieves websites from a remote JSON endpoint.
- **Search:** Filters the list by website name or description.
- **Sort:** Orders websites alphabetically (case-insensitive).
- **Detail View:** Presents website details with an icon, description, and a link to open the site in Safari.
- **Favorites:** Mark websites as favorite by tapping the star icon.
- **Swipe to Reset:** A swipe gesture allows users to quickly reset the list (or refresh data).
- **Tap-to-Reload Icon:** If an image fails to load, users can tap the icon to attempt a reload.
- **Disabled autocorrect in search bar:** Most search bars dont autocorrect spelling, incorporated that
- **Offline Caching:** Implements basic file-based caching within the networking layer. When a network fetch is successful, the website JSON is saved to disk. If a subsequent network call fails, the app automatically falls back to loading the cached data.
- **MVVM Architecture:** Clean separation of concerns with dependency injection for improved testability.
- **Test-Driven Development (TDD):** Early iterations were driven by unit tests, and comprehensive UI tests now validate critical user flows.

## Project Structure
WebsiteListApp/ ├─ Models/ ├─ Services/ ├─ ViewModels/ ├─ Views/ ├─ Tests/ └─ UITests/

## How to Run

1. Open `WebsiteListApp.xcodeproj` or `.xcworkspace` in Xcode (15+).
2. Ensure you have iOS 17/18 SDK (or the relevant installed).
3. Press **Run** (⌘ + R) to launch on the Simulator.

## How to Test

- **Unit Tests**: `Product → Test` (⌘ + U).
- **UI Tests**: Included in `WebsiteListAppUITests` – also run with ⌘ + U or from the Test Navigator.

## Development Approach

### How I Approached the Task

I began this project with a strong commitment to Test-Driven Development (TDD). Early on, I wrote extensive unit tests for the core Website model, networking services, and view model logic. These tests drove the design and ensured a modular, testable architecture from the start. However, as the project scope expanded and deadlines loomed, I pivoted my focus to deliver a complete and robust UI and functionality. Comprehensive UI tests now verify most critical user flows, even though many of the initial unit tests have been consolidated or left as legacy artifacts.

### What I’m Particularly Proud Of

- **Robust Architecture:**  
  Using MVVM with protocol-based dependency injection has resulted in a clean, maintainable codebase that is easy to extend.
- **Thoughtful UI Interactions:**  
  Small features like the favorite star icon, swipe-to-reset gesture, and tap-to-reload image handling enhance the user experience.
- **Agile & Iterative Process:**  
  The project evolution—from rigorous TDD practices to a focus on UI tests—demonstrates my ability to adapt to deadlines without sacrificing quality.

### What I Would Improve or Add Given More Time

- **Enhanced Offline Caching:**  
  Although the app currently implements basic file-based caching (saving website JSON to disk and falling back to it when network calls fail), I would upgrade this to a robust solution (e.g., using Core Data) to better manage larger datasets and more complex offline scenarios.
- **Expanded Favorites Feature:**  
  Improve the favorites functionality with persistent storage and more advanced filtering options.
- **UI Refinements:**  
  Introduce more polished animations and transitions to further enhance the user experience.
- **Platform Support:**  
  Optimize the interface for iPad, macOS Catalyst, and other Apple platforms.

## Author

- Ayush Kumar (c) 4/13/25.
