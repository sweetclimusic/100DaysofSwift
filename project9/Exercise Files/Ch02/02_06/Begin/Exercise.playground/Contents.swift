/*:
# Chapter 2.6 - Future and Just (Begin)
Future and Just are two special types of Publishers. Just emits just once, before terminating, whereas Future culminates in a single result, either an output value or failure completion, initialized by wrapping any asynchronous call.
*/

import Foundation
import Combine


// (1) A simple publisher using Just, to produce once to each subscriber, before 💀
let _ = Just("A data stream")
    .sink { (value) in
        print("value is \(value)")
}

// (2) Connect subject to a publisher, and publish the value `29`
let subject = PassthroughSubject<Int, Never>()

Just(29)
    .subscribe(subject)

// (3) A simple use of Future, in a function
enum FutureError: Error{
    case notMultiple
}

