/*:
# Chapter 2.4 - Subscribers (End)
As the counterparts to Publishers, **Subscribers** receive inputs from Publishers. In this video, we will explore Subscribers in greater detail, and understand how they interact within the Combine ecosystem.
*/


import Foundation
import Combine
import UIKit
import SwiftUI


//(1) Create a new Just publisher, map some text as prefix, and assign to label.
[1, 5, 9]
    .publisher
    .sink { print($0) }

let label = UILabel()
Just("John")
    .map {"My name is \($0)"}
    .assign(to: \.text, on: label)

