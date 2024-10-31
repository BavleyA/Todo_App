# Todo App

A simple Todo App built with Flutter, utilizing the BLoC (Business Logic Component) pattern with Cubit for state management. This app allows users to manage their tasks efficiently by categorizing them into three main screens: New Tasks, Done Tasks, and Archived Tasks. 

## Features

- **Three Main Screens**:
  - **New Tasks**: View and manage tasks that are yet to be completed.
  - **Done Tasks**: View tasks that have been completed.
  - **Archived Tasks**: View tasks that have been archived for future reference.
  
- **Task Management**: Move tasks between New, Done, and Archived states effortlessly.

- **Smooth Navigation**: Easy navigation between screens for a seamless user experience.

## Table of Contents

- [Getting Started](#getting-started)
- [Screens Overview](#screens-overview)
- [State Management with BLoC & Cubit](#state-management-with-bloc--cubit)
- [Installation and Running the App](#installation-and-running-the-app)
- [Contributing](#contributing)
- [License](#license)
- [Acknowledgments](#acknowledgments)

## Getting Started

# Screens Overview

## 1. New Tasks
- This screen displays all tasks that are yet to be completed.
- Users can add new tasks and mark them as done or archived.

## 2. Done Tasks
- This screen shows tasks that have been marked as completed.
- Users can move tasks to archived tasks.

## 3. Archived Tasks
- This screen contains tasks that have been archived.
- Users can restore archived tasks back to Done tasks.

# State Management with BLoC & Cubit

The app uses the BLoC pattern to manage state efficiently. Each screen is managed by its respective Cubit that handles task operations, such as adding, completing, or archiving tasks.

## BLoC Architecture

- **Cubit**: A simple state management class that extends the `Cubit` class.
- **Events**: Events that trigger state changes, like adding or moving tasks.
- **States**: Represents the current state of tasks on each screen.


## Installation

### Prerequisites

- Flutter SDK
- Dart SDK

1. Clone the repository:

   ```bash
   git clone https://github.com/yourusername/todo_app.git
   
2. Navigate to the project directory:
   
   ```bash
   cd todo_app
   
3. Install the dependencies:

   ```bash
   flutter pub get

### Running The App

- To run the app on an emulator or a physical device, use:
  ```bash
  flutter run

# Contributing

Contributions are welcome! If you'd like to contribute to the project, please fork the repository and submit a pull request.

# License

This project is licensed under the MIT License. See the LICENSE file for more details.

# Acknowledgments

- Flutter for the powerful UI toolkit.
- The BLoC pattern for state management.
