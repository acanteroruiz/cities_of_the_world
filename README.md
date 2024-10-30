# Cities of the World

A demo project about fetching data with an offline-first approach.

## Features

- **Offline First**: The app loads data from the API and stores it locally using HydratedCubit. This ensures that the app can function even without an internet connection, by displaying cached data and a message to the user.
- **Infinite Scroll**: Users can load multiple pages of results with an infinite scroll approach.
- **Search Functionality**: Users can filter results by city name using a search field.
- **Testing**: Comprehensive unit tests are included to ensure the reliability of the app.

- **Toggle Views**: Users can toggle between a list view and a map view to see the data presented in different formats.

  **Note**: This feature is not implemented because the data from the provided API always returns `lat` and `lng` fields as null, making it impossible to display any location on the map. Adding a bottom navigation bar to include a map view option with a static image or map is not valuable for a technical test, in my opinion. Therefore, the focus has been shifted to other aspects such as testing, architecture, and developing use cases for cached data.

## Project Structure

- **lib/**: Contains the main source code for the app.
- **test/**: Contains the test files for the app.
- **packages/api_client/**: Contains the API client package used for fetching data from the remote server.

## Additional Information

- The app uses HydratedCubit for state management and local caching.
- The app follows a modular architecture to ensure separation of concerns and ease of testing.
- The app includes both unit tests to ensure the reliability of the codebase.

Feel free to explore the codebase and run the tests to get a better understanding of the project.

## Getting Started

### Prerequisites

- Flutter SDK
- Dart SDK

### Installation

1. **Clone the repository**:
    ```sh
    git clone https://github.com/yourusername/cities_of_the_world.git
    cd cities_of_the_world
    ```

2. **Install dependencies**:
    ```sh
    flutter pub get
    ```

### Running the App

1. **Run the app**:
    ```sh
    flutter run
    ```

## How to Test

### Running Tests in the Project

1. **Navigate to the project directory**:
    ```sh
    cd path/to/your/project
    ```

2. **Run the tests**:

    - To run the tests without coverage:
    ```sh
    ./run_tests.sh
    ```
   
    - To run the tests with coverage:
    
    ```sh
    ./run_coverage_tests.sh
    ```

### Running Tests in `api_client` Package

1. **Navigate to the `api_client` package directory**:
    ```sh
    cd path/to/your/project/packages/api_client
    ```

2. **Run the tests**:
    - To run the tests without coverage:
    ```sh
    ./run_tests.sh
    ```

    - To run the tests with coverage:

    ```sh
    ./run_coverage_tests.sh
    ```

**Note**: The `run_coverage_tests.sh` script uses `genhtml` to generate the coverage report. If `genhtml` is not installed, you can install it by following these instructions:

#### On macOS:
1. Install Homebrew if you haven't already:
    ```sh
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    ```

2. Install `lcov` (which includes `genhtml`):
    ```sh
    brew install lcov
    ```

#### On Linux:
1. Install `lcov` using your package manager. For example, on Ubuntu:
    ```sh
    sudo apt-get install lcov
    ```

After installing `lcov`, you should be able to run the `run__coverage_tests.sh` script without any issues.

