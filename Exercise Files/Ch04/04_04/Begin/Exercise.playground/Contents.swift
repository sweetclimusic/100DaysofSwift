/*:
# Chapter 4.4 - Type Erasures (Begin)
Combine also has an equivalent notion of implementation access, called Type
Erasures. They let you design your Publishers so that you don’t have to
overexposed inner details of that publisher.


*/

import Foundation
import Combine

struct Post: Codable{
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

let url = URL(string: "https://jsonplaceholder.typicode.com/posts")
let publisher = URLSession.shared.dataTaskPublisher(for: url!)
    .map {$0.data}
    .decode(type: Array<Post>.self, decoder: JSONDecoder())
//(1) Add `.eraseToAnyPublisher()`

let cancellableSink = publisher
    .sink(receiveCompletion: {completion in
        print(String(describing: completion))
    }, receiveValue: {value in
        print("returned value \(value)")
    })



