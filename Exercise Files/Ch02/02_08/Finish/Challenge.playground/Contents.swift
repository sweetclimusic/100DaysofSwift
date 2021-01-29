/*:
# Chapter 2.8 - Challenge (Finish)
In this challenge, you will create a simple Combine publish and subscribe project in Playgrounds, that will use NotificationCenter to signal to a button when the clock has changed.

*/

import Foundation
import Combine
import UIKit

let textField = UITextField()

//(1) Create a publisher, which publishes the following boolean array
let array = [true, false, false, false, false, true, true]
let publisher = array.publisher
//(2) Create a subscriber, to assign to the textfield's isEnabled property, when publisher emits new data, from the publisher
let subscriber = publisher.assign(to: \.isEnabled, on: textField)
textField.publisher(for: \.isEnabled).sink{ print($0)}
//(3) Add an operator, to drop the first 2 elements from the publisher, before the subscriber assigns to the button
let _ = publisher.dropFirst(2).sink{print($0)}

