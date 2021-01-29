/*:
# Chapter 3.3 - Testing in Combine (Finish)
Like error handling, testing is also a fundamental part of development. Thankfully, in Combine, testing is just as straightforward and familiar to you as testing local components, leveraging Apple's XCTest framework.

*/

import Foundation
import Combine

import XCTest

class MyTests : XCTestCase {
    var subscriptions = Set<AnyCancellable>()
    let expectedTitle = "sunt aut facere repellat provident occaecati excepturi optio reprehenderit"
    let expectedId = 1
    
    func testPublisher() {
        let _ = APIService.getPosts()
        .sink(receiveCompletion: { error in
            print("Completed subscription \(String(describing:error))")
        }, receiveValue: {results in
            print("Got \(results.count) posts back")
            XCTAssert(results.count > 0)
            XCTAssert(results.count == 100,
                      "We got \(results.count) instead of 100 posts back")
            XCTAssert(results[0].title == self.expectedTitle,
                      "We got back the title \(results[0].title) instead of \(self.expectedTitle)")
        })
        .store(in: &subscriptions)
    }
}

//Courtesy of [NSScreenCast](https://github.com/nsscreencast/330-using-xctest-in-playgrounds)
class TestObserver : NSObject, XCTestObservation {
    func testCase(_ testCase: XCTestCase, didFailWithDescription description: String, inFile filePath: String?, atLine lineNumber: Int) {
        print("🚫 \(description) line:\(lineNumber)")
    }
    
    func testCaseDidFinish(_ testCase: XCTestCase) {
        if testCase.testRun?.hasSucceeded == true {
            print("✅ \(testCase)")
        }
    }
}

let observer = TestObserver()
XCTestObservationCenter.shared.addTestObserver(observer)

MyTests.defaultTestSuite.run()

