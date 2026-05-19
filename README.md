# Task Explorer

Task Explorer is a simple iOS application built using SwiftUI and MVVM architecture.  
The app fetches tasks from a remote API, supports local persistence for completion states, and demonstrates clean architecture principles using the Repository Pattern and Dependency Injection.

---

# Running the Project

1. Clone the repository
2. Open the Xcode project
3. Run the app on iOS 16+ simulator or device

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
- Lightweight data limiting for better UI responsiveness

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

# API

The app uses the following endpoint:

```text
https://jsonplaceholder.typicode.com/todos
```

---

# Data Fetching Strategy

For demo simplicity and better UI responsiveness, the application limits fetched tasks to the first 20 items.

This keeps:
- Initial loading lightweight
- UI rendering faster
- Demo behavior more realistic

The limiting is handled inside the Repository layer.

---

# Local Persistence Strategy

Task completion updates are persisted locally using UserDefaults.

Instead of storing the full task list locally, the app only stores completion overrides.

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

This approach keeps local storage lightweight and simple while still supporting persistent completion states.

---

# Networking Layer

The networking layer is intentionally kept lightweight and reusable.

## Components

- APIEndpoint
- NetworkService Protocol & Implementation

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

# Error Handling

The app includes:

- Loading state
- Error state
- Retry mechanism

A reusable `ErrorView` component is used for iOS 16 compatibility.

---

# Unit Testing

Unit tests are implemented using XCTest.

## Tested Scenarios

- Fetch task success
- Fetch task failure
- Empty task result
- Toggle completion update
- Invalid task toggle handling
- Error recovery flow

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

CoreData or SwiftData would be more suitable if:

- Full offline support was required
- CRUD operations became more complex
- Relationships or advanced querying were needed

---

# Future Improvements

Potential future improvements:

- Full offline cache support
- Pagination / infinite scrolling
- Search & filtering
- Dependency container
- Snapshot testing
- Persistent local database using CoreData or SwiftData
- Better synchronization strategy
- Pull-to-refresh support

# AI Usage Report
## AI Tools Used
- ChatGPT

---

## Tasks Assisted by AI

AI tools were used to assist with:

- Brainstorming project architecture
- Reviewing MVVM + Repository structure
- Discussing folder organization
- Reviewing dependency injection approach
- Refining networking layer structure
- Reviewing persistence strategy using UserDefaults
- Generating and refining README documentation
- Suggesting unit test scenarios
- Debugging Swift concurrency and async/await related issues
- Improving code readability and naming consistency

---

## Decisions Made Manually

The following decisions were made manually during implementation:

- Choosing MVVM + Repository architecture
- Choosing feature-based folder structure
- Deciding to use UserDefaults instead of CoreData
- Designing task completion persistence strategy
- Deciding to limit fetched data to improve responsiveness
- Implementing SwiftUI view hierarchy and navigation flow
- Structuring ViewModel responsibilities and state handling
- Writing and adjusting application logic
- Deciding the level of architectural complexity appropriate for the project scope

---

## Limitations and Corrections Applied

Several AI suggestions were reviewed and adjusted manually during development:

- Some architecture suggestions were intentionally simplified to avoid overengineering for a small take-home project
- Swift 6 concurrency and Sendable recommendations were partially adjusted to better fit the project scope and avoid unnecessary complexity
- Certain async testing suggestions were simplified to keep unit tests stable and maintainable
- Networking abstraction was kept intentionally lightweight instead of introducing additional layers or containers
- AI-generated code and recommendations were manually reviewed, tested, and modified before integration