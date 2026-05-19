# Task Explorer

Task Explorer is a simple iOS application built using SwiftUI and MVVM architecture.
The app fetches tasks from a remote API, supports local persistence for completion states, and demonstrates clean architecture principles with Repository Pattern and Dependency Injection.

---

# Features

- Fetch task list from remote API
- View task details
- Toggle task completion state
- Persist completion changes locally using UserDefaults
- Offline-friendly completion state handling
- Error state handling
- Loading state handling
- SwiftUI Preview support with mock dependencies
- Unit Testing with mock repository

---

# Tech Stack

- Swift
- SwiftUI
- MVVM Architecture
- Repository Pattern
- Async/Await
- URLSession
- UserDefaults
- XCTest

---

# Architecture

The project uses:

- MVVM for UI separation
- Repository Pattern for data orchestration
- Dependency Injection for testability
- Feature-based folder structure

## Architecture Flow

```text
View
    ↓
ViewModel
    ↓
Repository
    ↓
Remote / Local Data Source
```

---

# Project Structure

```text
TaskExplorer
├── Core
│   ├── Networking
│   │   ├── APIEndpoint.swift
│   │   ├── HTTPMethod.swift
│   │   ├── NetworkError.swift
│   │   ├── NetworkService.swift
│   │   └── URLSessionNetworkService.swift
│   │
│   └── Common
│       └── ErrorView.swift
│
├── Features
│   └── Task
│       ├── List
│       │   ├── Views
│       │   └── ViewModels
│       │
│       ├── Detail
│       │   └── Views
│       │
│       ├── Models
│       ├── Repository
│       └── Persistence
│
└── Tests
    ├── Mocks
    └── ViewModels
```

---

# API

The app uses the following endpoint:

```text
https://jsonplaceholder.typicode.com/todos
```

---

# Local Persistence Strategy

Task completion updates are persisted locally using UserDefaults.

Only completion overrides are stored locally instead of storing the entire task list.

## Stored Format

```swift
[String: Bool]
```

Example:

```swift
[
    "1": true,
    "3": false
]
```

This approach keeps local storage lightweight and simple.

---

# Networking Layer

The networking layer is intentionally kept simple and reusable.

## Components

- APIEndpoint
- HTTPMethod
- NetworkError
- NetworkService Protocol
- URLSessionNetworkService

## Responsibilities

### NetworkService

Responsible for:

- Executing HTTP requests
- Decoding API responses

### Repository

Responsible for:

- Fetching remote data
- Loading local completion states
- Merging remote and local data
- Exposing domain models to ViewModels

### ViewModel

Responsible for:

- UI state management
- Handling user interactions
- Calling repository methods

---

# Dependency Injection

Dependencies are injected manually through initializers.

Example:

```swift
TaskListViewModel(
    repository: repository
)
```

This improves:

- Testability
- Modularity
- Separation of concerns

---

# SwiftUI State Management

The app uses:

- @StateObject for ViewModels
- @Binding for task synchronization between list and detail screen
- @Published for reactive UI updates

Task detail updates automatically reflect in the list using Binding.

---

# Error Handling

The app includes:

- Loading state
- Error state
- Retry mechanism

A reusable ErrorView component is used for iOS 16 compatibility.

---

# Unit Testing

Unit tests are implemented using XCTest.

## Tested Scenarios

- Fetch task success
- Fetch task failure
- Toggle completion update

## Mocking Strategy

The ViewModel is tested using a mock repository:

```swift
MockTaskRepository
```

This ensures:

- Isolated tests
- Deterministic behavior
- No real networking dependency

---

# Preview Strategy

SwiftUI previews use mock repositories instead of real services.

Example:

```swift
#Preview {
    TaskListView(
        vm: TaskListViewModel(
            repository: MockTaskRepository()
        )
    )
}
```

---

# Minimum Deployment Target

- iOS 16

---

# Tradeoffs & Decisions

## Why UserDefaults instead of CoreData?

Since the application only needs lightweight local persistence for completion states, UserDefaults provides:

- Simpler implementation
- Lower complexity
- Faster development
- Sufficient functionality for current requirements

CoreData would be more suitable if:

- Full offline support was required
- CRUD operations became more complex
- Relationships or advanced querying were needed

---

# Future Improvements

Potential future improvements:

- Full offline cache support
- Pagination
- Search & filtering
- Dependency container
- Snapshot testing
- Persistent local database using CoreData or SwiftData
- Better synchronization strategy

---

# Running the Project

1. Clone the repository
2. Open the Xcode project
3. Run the app on iOS 16+ simulator or device

---

# Author

Aldino Efendi

