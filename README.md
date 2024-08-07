# Expense Tracker

Expense Tracker is a mobile application built with Flutter that helps users manage and visualize their expenses. It provides an intuitive interface for logging expenses and generates insightful charts to help users understand their spending habits.

## Features

- User authentication using Firebase
- Add, edit, and delete expenses
- Categorize expenses
- View expenses in a list format
- Visualize monthly expenses with bar charts
- Secure and real-time data synchronization

## Project Structure

- `lib/`: Contains the main Dart code for the application
- `core/`: Core utilities, themes, and dependencies
- `features/`: Feature-specific code (e.g., home, authentication)
 - `domain/`: Entities and use cases
 - `data/`: Data sources and repositories
 - `presentation/`: UI components and BLoC classes


## Dependencies

- `flutter_bloc`: State management
- `firebase_core`: Firebase core functionality
- `firebase_auth`: User authentication
- `cloud_firestore`: Cloud-based database
- `fl_chart`: Charting library for visualizations

