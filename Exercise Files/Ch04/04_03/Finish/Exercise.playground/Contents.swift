/*:
# Chapter 4.3 - Backpressure (Finish)
Backpressure is a quite overlooked yet powerful control knob in the Publisher/Subscriber model, supported by the framework. I will spend a few minutes going through what Backpressure in Combine is, and why you would want to make use of it.

*/

import Foundation
import Combine

let cityPublisher = (["San Jose", "San Francisco", "Menlo Park", "Palo Alto", ]).publisher

final class CitySubscriber: Subscriber{
    
    //Tells the subscriber that we have successfully subscribed and may request items and it can send values. We enter how many values we want to receive from the publisher.
    func receive(subscription: Subscription) {
        subscription.request(.max(2))
        //subscription.request(.unlimited)
    }
    
    //Tells the subscriber that the publisher has produced an element, and we can use this method to output the results, and returns the requested number of items, sent to a publisher from a subscriber via the subscription.
    func receive(_ input: String) -> Subscribers.Demand {
        print("City: \(input)")
        return .none
    }
    
    //Tells the subscriber that the publisher has completed publishing, either normally or with an error
    func receive(completion: Subscribers.Completion<Never>) {
        print("Subscription \(completion)")
    }
    
    typealias Input = String
    typealias Failure = Never
    
}


let citySubscription = CitySubscriber()

cityPublisher.subscribe(citySubscription)


