/*:
# Chapter 4.1 - Schedulers (Finish)
Schedulers allow you to orchestrate where and when to publish, and Knowing how to queue your upstream publishers, or downstream subscription streams, whether they should be processing in the background, in your main thread, sequence serially or concurrently. When using Combine to update your application’s UI elements, it is crucial you optimize your streams to use the main thread, but to also not degrade the user experiences.

*/

import Foundation
import Combine

struct Post: Codable{
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

print("Publisher: On main thread?: \(Thread.current.isMainThread)")
print("Publisher: thread info: \(Thread.current)")

let url = URL(string: "https://jsonplaceholder.typicode.com/posts")
let queue = DispatchQueue(label: "a queue")

let publisher = URLSession.shared.dataTaskPublisher(for: url!)
    .map {$0.data}
    .decode(type: Array<Post>.self, decoder: JSONDecoder())
    .receive(on: ImmediateScheduler.shared)

let cancellableSink = publisher
    .subscribe(on: queue)
    //.receive(on: DispatchQueue.global())
    .sink(receiveCompletion: {completion in
        print("Subscriber: On main thread?: \(Thread.current.isMainThread)")
        print("Subscriber: thread info: \(Thread.current)")
    }, receiveValue: {value in
        print("Subscriber: On main thread?: \(Thread.current.isMainThread)")
        print("Subscriber: thread info: \(Thread.current)")
    })


