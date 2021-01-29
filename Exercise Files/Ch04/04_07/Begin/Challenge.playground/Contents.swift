/*:
# Chapter 4.7 - Challenge (Begin)
In this challenge, you will apply many of the concepts you’ve learned in the chapter, by using a Delay, and Backpressure to control the data consumed.
*/

import Foundation
import Combine

var queue: DispatchQueue = DispatchQueue(label: "Queue")

let numberPublisher = (0...100)
    .publisher

// (1) Set a delay of 3 seconds before retrieving data

// (2) Create a custom Subscriber that implements Backpressure.


