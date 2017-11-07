import XCTest
@testable import scrabble_package

class scrabble_packageTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(scrabble_package().text, "Hello, World!")
    }


    static var allTests = [
        ("testExample", testExample),
    ]
}
