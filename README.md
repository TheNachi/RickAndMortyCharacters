# Rick and Morty Character Viewer

This iOS application displays characters from the Rick and Morty universe, allowing users to view character details and filter characters based on their status.

## Building and Running the Application

1. Clone the repository to your local machine.
2. Open the `RickAndMortyCharacters.xcodeproj` file in Xcode.
3. Select your target device or simulator.
4. Click the "Run" button or press `Cmd + R` to build and run the application.

## Running Tests

This project includes unit tests, integration tests, and UI tests to ensure the reliability and correctness of the application. To run the tests:

1. Open the project in Xcode.
2. Select the desired test target:
   - `RickAndMortyCharactersTests` for unit and integration tests
   - `RickAndMortyCharactersUITests` for UI tests
3. To run all tests, press `Cmd + U` or go to Product > Test in the menu bar.
4. To run specific test classes or methods:
   - Open the test file you want to run
   - Click the diamond-shaped icon next to the class or method declaration

The test results will appear in the Test navigator and the Console in Xcode.

### Test Coverage

The tests cover various scenarios including:
- Character list loading and filtering
- Character details view model
- API integration
- Basic UI interactions and navigation

To view test coverage:
1. Run the tests as described above
2. Go to the Report Navigator (Command + 9)
3. Select the latest test run
4. Click on the Coverage tab to see detailed coverage information


## Assumptions and Decisions

1. **Color Coding**: The application uses color coding to represent the status of each character. Green indicates "Alive", red indicates "Dead", and gray is used for "Unknown" status.

2. **Filter Functionality**: A filter button was implemented to allow users to clear filter selections easily. This improves user experience by providing a quick way to reset the character list view.

3. **Architecture**: The MVVM (Model-View-ViewModel) architecture was chosen for this project. This decision was made to improve testability and maintain a clear separation of concerns.

4. **Combine Framework**: Apple's Combine framework was used for handling asynchronous events. This modern approach to handling data streams and asynchronous operations aligns well with SwiftUI and provides a robust foundation for future enhancements.


## Challenges and Solutions

1. **SwiftUI and UIKit Integration**: 
   - Challenge: Properly integrating SwiftUI with UIKit, especially for the table view.
   - Solution: This wasn't a significant challenge as I had prior experience with this integration. The `UIViewControllerRepresentable` protocol was used to wrap the UIKit table view for use in SwiftUI.

2. **Performance Optimization**:
   - Challenge: Ensuring smooth scrolling and efficient memory usage with potentially large lists of characters.
   - Solution: Implemented cell reuse in the UITableView and used lazy loading for character images to optimize performance and memory usage.

## Future Improvements

1. Implement caching for offline support.
2. Add more detailed character information and possibly episode lists.
3. Implement search functionality to find specific characters.
4. Enhance UI/UX with animations and transitions.
5. Add unit and UI tests for better code coverage.

## Feedback and Contributions

Feedback and contributions are welcome. Please feel free to submit issues or pull requests to improve the application.