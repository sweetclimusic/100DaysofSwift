/*:
# Chapter 3.2 - Error Handling (Begin)
An important aspect of coding is being able to account for errors, or in other words, handle errors. Like any other framework, Combine is certain to encounter errors, from network to decoding, to incorrect credentials. As a good citizen programmer, it is imperative that you handle the unexpected, in a graceful manner.

*/

import Foundation
import Combine

struct Post: Codable{
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

enum APIError: Error{
    case networkError(error: String)
    case responseError(error: String)
    case unknownError
}

let samplePost = Post(userId: 1, id: 2, title: "No Post", body: "")

//(1) Create a `dataTaskPublisher`
let url = URL(string: "https://jsonplaceholder.typicode.com/posts")
let publisher = URLSession.shared.dataTaskPublisher(for: url!)
    .map {$0.data}
    .decode(type: Array<Post>.self, decoder: JSONDecoder())

//(2) Subscribe to the publisher with `mapError` Error handling
let cancellableSink = publisher
    .sink(receiveCompletion: {completion in
        print(String(describing: completion))
    }, receiveValue: {value in
        print("returned value \(value)")
    })

//(3) A simple Publisher example with `.tryMap` and `.catch`



