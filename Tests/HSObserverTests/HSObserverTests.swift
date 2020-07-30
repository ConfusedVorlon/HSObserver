import XCTest
@testable import HSObserver

final class HSObserverTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(HSObserver().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
